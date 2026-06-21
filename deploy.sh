#!/bin/bash
set -e

# Configuration
PROJECT_ID="gen-lang-client-0214569817"
SERVICE_NAME="my-google-ai-studio-applet"
REGION="us-west1"
REPO_NAME="cloud-run-source-deploy"
IMAGE_TAG="us-west1-docker.pkg.dev/${PROJECT_ID}/${REPO_NAME}/${SERVICE_NAME}:latest"

echo "=== Starting deployment of Personal Page application ==="

# 1. Ensure Artifact Registry repository exists
echo "Checking if Artifact Registry repository exists..."
if ! gcloud artifacts repositories describe "${REPO_NAME}" --location="${REGION}" --project="${PROJECT_ID}" >/dev/null 2>&1; then
  echo "Creating Artifact Registry repository '${REPO_NAME}'..."
  gcloud artifacts repositories create "${REPO_NAME}" \
    --repository-format=docker \
    --location="${REGION}" \
    --project="${PROJECT_ID}"
else
  echo "Artifact Registry repository '${REPO_NAME}' already exists."
fi

# 2. Build and push image using Cloud Build
echo "Submitting build to Cloud Build..."
gcloud builds submit --tag="${IMAGE_TAG}" --project="${PROJECT_ID}"

# Fetch built image digest to force a new Cloud Run revision
echo "Fetching built image digest..."
IMAGE_DIGEST=$(gcloud artifacts docker images describe "${IMAGE_TAG}" --format="value(image_summary.digest)")
FULL_IMAGE_REF="us-west1-docker.pkg.dev/${PROJECT_ID}/${REPO_NAME}/${SERVICE_NAME}@${IMAGE_DIGEST}"
echo "Using image reference: ${FULL_IMAGE_REF}"

# 3. Export current service configuration
echo "Exporting current Cloud Run service configuration..."
gcloud run services describe "${SERVICE_NAME}" \
  --project="${PROJECT_ID}" \
  --region="${REGION}" \
  --format=json > service_tmp.json

# 4. Update JSON using built-in Python json library
echo "Updating service configuration..."
python3 -c "
import json

with open('service_tmp.json', 'r') as f:
    data = json.load(f)

# Update annotations to remove source/base-image references
annotations = data['spec']['template']['metadata'].get('annotations', {})
annotations.pop('run.googleapis.com/sources', None)
annotations.pop('run.googleapis.com/base-images', None)

# Update the app-container image and remove command overrides if present
for container in data['spec']['template']['spec']['containers']:
    if container['name'] == 'app-container':
        container['image'] = '${FULL_IMAGE_REF}'
        container.pop('args', None)
        container.pop('command', None)

# Remove runtimeClassName if present to avoid conflicts
data['spec']['template']['spec'].pop('runtimeClassName', None)

with open('service_tmp.json', 'w') as f:
    json.dump(data, f, indent=2)
"

# 5. Apply the new configuration
echo "Applying updated configuration to Cloud Run service..."
gcloud run services replace service_tmp.json --project="${PROJECT_ID}" --region="${REGION}"

# Clean up
rm service_tmp.json

echo "=== Deployment Completed Successfully! ==="
echo "The application is available at: https://my-google-ai-studio-applet-599376401905.us-west1.run.app"

# Marcin Oziemski — Personal Web Profile

A premium, highly interactive personal portfolio website showcasing engineering leadership, platform strategy, and technical execution. 

The application is built on a modern frontend stack using **React 19**, **Vite 6**, **Tailwind CSS v4**, and **Motion** (Framer Motion) for fluid interactions. It features a custom interactive 3D mesh background, scroll-driven UI card state transitions, and responsive video embeds.

---

## 🚀 Features

*   **Interactive 3D Mesh Background**: A high-performance canvas-based 3D mesh background that dynamically reacts to cursor movements while retaining high readability of foreground content.
*   **Vibrant Motion Animations**: Micro-animations, responsive layout transitions, and scroll-driven entry/exit card behaviors powered by `motion`.
*   **Engineering Leadership Focus**: Highlights leadership roles, impact metrics (sprint predictability, cycle time improvements, store rating scaling), and professional writing/speaking.
*   **Modern Styling & Theming**: Engineered using Tailwind CSS v4, custom HSL-tailored color palettes, Outfit/Inter typography, and glassmorphism cards.
*   **Full Responsiveness & SEO**: Fully optimized for mobile and desktop, utilizing semantic HTML5 tags and accessibility standards.
*   **Dockerized Deployment**: Fully containerized setup ready for server-side hosting with a custom Node.js serving wrapper.

---

## 🛠️ Tech Stack

*   **Core**: [React 19](https://react.dev/), [TypeScript](https://www.typescriptlang.org/)
*   **Bundler**: [Vite 6](https://vite.dev/)
*   **Styling**: [Tailwind CSS v4](https://tailwindcss.com/)
*   **Animations**: [Motion (Framer Motion)](https://motion.dev/)
*   **Icons**: [Lucide React](https://lucide.dev/)
*   **Deployment**: [Docker](https://www.docker.com/), [Google Cloud Run](https://cloud.google.com/run)

---

## 💻 Getting Started

### Prerequisites

*   **Node.js**: `v22.x` (or newer)
*   **NPM**: `v10.x` (or newer)

### Installation

Clone the repository and install the dependencies:

```bash
git clone git@github.com:marcinOz/marcin_web_profile.git
cd marcin_web_profile
npm install
```

### Local Development

Run the Vite development server locally on `http://localhost:3000`:

```bash
npm run dev
```

### Production Build

Compile the production-ready static assets (compiled into the `/dist` directory):

```bash
npm run build
```

To run the custom server wrapper locally for testing production behavior:

```bash
node server.cjs
```

---

## 📦 Docker & Deployment

The project is configured for containerized deployment to **Google Cloud Run** using a custom shell script.

### Local Container Build

To build and run the Docker container locally:

```bash
# Build the Docker image
docker build -t personal-page .

# Run the container
docker run -p 3000:3000 personal-page
```

### Deploying to GCP Cloud Run

The deployment pipeline is fully automated in [deploy.sh](file:///Users/marcin.oziemski/antigravity/Personal-Page/deploy.sh):

```bash
chmod +x deploy.sh
./deploy.sh
```

**What the deploy script does:**
1.  Verifies/creates the Google Cloud Artifact Registry repository.
2.  Submits the project to Google Cloud Build to build and push the Docker image.
3.  Exports and updates the Cloud Run service configuration for the `my-google-ai-studio-applet` service.
4.  Applies the updated revision dynamically.

---

## 📁 Project Structure

```text
├── .agents/                 # Workspace customizations / AI agent instructions
├── public/                  # Static assets (favicons, compressed loop videos)
├── src/
│   ├── components/
│   │   └── MeshBackground.tsx  # Interactive Canvas-based 3D mesh background
│   ├── App.tsx              # Main application page layout & components
│   ├── index.css            # Base styles and Tailwind config
│   ├── firebase.ts          # Firebase SDK initialization
│   └── main.tsx             # Application entry point
├── server.cjs               # Production Node.js server wrapper
├── Dockerfile               # Multi-stage production build configuration
├── deploy.sh                # Automated GCP Cloud Run deployment script
└── vite.config.ts           # Vite application config
```

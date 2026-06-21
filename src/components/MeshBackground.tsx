/**
 * @license
 * SPDX-License-Identifier: Apache-2.0
 */

import { useEffect, useRef } from 'react';

export default function MeshBackground() {
  const canvasRef = useRef<HTMLCanvasElement>(null);
  const mouseRef = useRef({ x: -1000, y: -1000, active: false });

  useEffect(() => {
    const canvas = canvasRef.current;
    if (!canvas) return;

    const ctx = canvas.getContext('2d');
    if (!ctx) return;

    let animationFrameId: number;
    let isTabActive = true;
    let width = 0;
    let height = 0;

    // Grid spacing configuration (in pixels)
    const spacing = 52;
    
    // 3D projection parameters
    const fov = 900;
    const translateZ = 750;
    const angleX = -1.05; // Negative tilts top of grid away from camera
    const angleY = 0.0;
    const angleZ = 0.12;  // Slight rotation for asymmetric visual interest

    // 3D Rotation Utilities
    const rotateX = (x: number, y: number, z: number, angle: number) => {
      const cos = Math.cos(angle);
      const sin = Math.sin(angle);
      return { x, y: y * cos - z * sin, z: y * sin + z * cos };
    };

    const rotateY = (x: number, y: number, z: number, angle: number) => {
      const cos = Math.cos(angle);
      const sin = Math.sin(angle);
      return { x: x * cos + z * sin, y, z: -x * sin + z * cos };
    };

    const rotateZ = (x: number, y: number, z: number, angle: number) => {
      const cos = Math.cos(angle);
      const sin = Math.sin(angle);
      return { x: x * cos - y * sin, y: x * sin + y * cos, z };
    };

    const handleResize = () => {
      const rect = canvas.getBoundingClientRect();
      width = rect.width;
      height = rect.height;
      
      // Support high-DPI (Retina) displays
      const dpr = window.devicePixelRatio || 1;
      canvas.width = width * dpr;
      canvas.height = height * dpr;
      ctx.scale(dpr, dpr);
    };

    window.addEventListener('resize', handleResize);
    handleResize();

    // Track cursor positioning
    const handleMouseMove = (e: MouseEvent) => {
      mouseRef.current.x = e.clientX;
      mouseRef.current.y = e.clientY;
      mouseRef.current.active = true;
    };

    const handleMouseLeave = () => {
      mouseRef.current.active = false;
    };

    const handleTouchMove = (e: TouchEvent) => {
      if (e.touches && e.touches[0]) {
        mouseRef.current.x = e.touches[0].clientX;
        mouseRef.current.y = e.touches[0].clientY;
        mouseRef.current.active = true;
      }
    };

    const handleTouchEnd = () => {
      mouseRef.current.active = false;
    };

    window.addEventListener('mousemove', handleMouseMove);
    document.addEventListener('mouseleave', handleMouseLeave);
    window.addEventListener('touchmove', handleTouchMove, { passive: true });
    window.addEventListener('touchend', handleTouchEnd);

    // Pause loop when page is in the background
    const handleVisibilityChange = () => {
      isTabActive = !document.hidden;
    };
    document.addEventListener('visibilitychange', handleVisibilityChange);

    const startTime = Date.now();

    const draw = () => {
      if (!isTabActive) return;

      const time = (Date.now() - startTime) * 0.8;
      ctx.clearRect(0, 0, width, height);

      // Oversize the grid to cover rotation margins
      const gridWidth = width * 1.5;
      const gridHeight = height * 1.8;
      const cols = Math.ceil(gridWidth / spacing) + 4;
      const rows = Math.ceil(gridHeight / spacing) + 4;

      const centerX = width / 2;
      const centerY = height / 2;

      // Project grid points into 2D space
      const points: { px: number; py: number; opacity: number; highlight: number }[][] = [];

      for (let r = 0; r < rows; r++) {
        points[r] = [];
        for (let c = 0; c < cols; c++) {
          const baseX = (c - cols / 2) * spacing;
          const baseY = (r - rows / 2) * spacing;

          // Double wave formula for organic rhythm
          let baseZ = Math.sin(c * 0.12 + time * 0.001) * Math.cos(r * 0.15 + time * 0.0012) * 22
                    + Math.sin(r * 0.08 - time * 0.0006) * 10;

          // Initial rotation & projection to estimate distance to screen cursor
          let rot = rotateY(baseX, baseY, baseZ, angleY);
          rot = rotateX(rot.x, rot.y, rot.z, angleX);
          rot = rotateZ(rot.x, rot.y, rot.z, angleZ);

          const zDepthPre = rot.z + translateZ;
          const scalePre = fov / Math.max(1, zDepthPre);
          let projX = centerX + rot.x * scalePre;
          let projY = centerY + rot.y * scalePre;

          let highlight = 0;

          // Apply mouse pressure warp
          if (mouseRef.current.active) {
            const dx = projX - mouseRef.current.x;
            const dy = projY - mouseRef.current.y;
            const dist = Math.hypot(dx, dy);
            const radius = 230; // Radius of mouse distortion

            if (dist < radius) {
              const force = 1 - dist / radius;
              highlight = force;
              
              // Displace Z depth backward (downwards) creating a 3D valley under cursor
              baseZ += force * 80;

              // Re-calculate projection with deformed Z depth
              rot = rotateY(baseX, baseY, baseZ, angleY);
              rot = rotateX(rot.x, rot.y, rot.z, angleX);
              rot = rotateZ(rot.x, rot.y, rot.z, angleZ);

              const zDepthPost = rot.z + translateZ;
              const scalePost = fov / Math.max(1, zDepthPost);
              projX = centerX + rot.x * scalePost;
              projY = centerY + rot.y * scalePost;
            }
          }

          // Radial edge fade to make the grid melt into background
          const distToCenter = Math.hypot(projX - centerX, projY - centerY);
          const maxRadius = Math.max(width, height) * 0.9;
          const edgeFade = Math.max(0, 1 - distToCenter / maxRadius);

          // Z-depth fade to handle points clipping close to the viewport
          const zDepth = rot.z + translateZ;
          let zFade = 1;
          if (zDepth < 50) zFade = 0;
          else if (zDepth < 200) zFade = (zDepth - 50) / 150;

          points[r][c] = {
            px: projX,
            py: projY,
            opacity: edgeFade * zFade,
            highlight
          };
        }
      }

      // Draw mesh connection lines
      ctx.lineWidth = 0.75;

      // Horizontal lines
      for (let r = 0; r < rows; r++) {
        for (let c = 0; c < cols - 1; c++) {
          const p1 = points[r][c];
          const p2 = points[r][c + 1];

          if (p1.opacity > 0 && p2.opacity > 0) {
            const avgOpacity = (p1.opacity + p2.opacity) / 2;
            const avgHighlight = (p1.highlight + p2.highlight) / 2;
            
            if (avgHighlight > 0.01) {
              // Blend from brand primary (blue: 0, 93, 163) to brand tertiary (violet: 126, 63, 159)
              const rVal = Math.round(0 * (1 - avgHighlight) + 126 * avgHighlight);
              const gVal = Math.round(93 * (1 - avgHighlight) + 63 * avgHighlight);
              const bVal = Math.round(163 * (1 - avgHighlight) + 159 * avgHighlight);
              const alpha = (0.12 * (1 - avgHighlight) + 0.28 * avgHighlight) * avgOpacity;
              ctx.strokeStyle = `rgba(${rVal}, ${gVal}, ${bVal}, ${alpha})`;
            } else {
              ctx.strokeStyle = `rgba(0, 93, 163, ${0.12 * avgOpacity})`;
            }

            ctx.beginPath();
            ctx.moveTo(p1.px, p1.py);
            ctx.lineTo(p2.px, p2.py);
            ctx.stroke();
          }
        }
      }

      // Vertical lines
      for (let r = 0; r < rows - 1; r++) {
        for (let c = 0; c < cols; c++) {
          const p1 = points[r][c];
          const p2 = points[r + 1][c];

          if (p1.opacity > 0 && p2.opacity > 0) {
            const avgOpacity = (p1.opacity + p2.opacity) / 2;
            const avgHighlight = (p1.highlight + p2.highlight) / 2;

            if (avgHighlight > 0.01) {
              const rVal = Math.round(0 * (1 - avgHighlight) + 126 * avgHighlight);
              const gVal = Math.round(93 * (1 - avgHighlight) + 63 * avgHighlight);
              const bVal = Math.round(163 * (1 - avgHighlight) + 159 * avgHighlight);
              const alpha = (0.12 * (1 - avgHighlight) + 0.28 * avgHighlight) * avgOpacity;
              ctx.strokeStyle = `rgba(${rVal}, ${gVal}, ${bVal}, ${alpha})`;
            } else {
              ctx.strokeStyle = `rgba(0, 93, 163, ${0.12 * avgOpacity})`;
            }

            ctx.beginPath();
            ctx.moveTo(p1.px, p1.py);
            ctx.lineTo(p2.px, p2.py);
            ctx.stroke();
          }
        }
      }

      // Draw grid intersection dots
      for (let r = 0; r < rows; r++) {
        for (let c = 0; c < cols; c++) {
          const p = points[r][c];
          if (p.opacity > 0) {
            if (p.highlight > 0.01) {
              const rVal = Math.round(20 * (1 - p.highlight) + 126 * p.highlight);
              const gVal = Math.round(88 * (1 - p.highlight) + 63 * p.highlight);
              const bVal = Math.round(182 * (1 - p.highlight) + 159 * p.highlight);
              const alpha = (0.22 * (1 - p.highlight) + 0.5 * p.highlight) * p.opacity;
              ctx.fillStyle = `rgba(${rVal}, ${gVal}, ${bVal}, ${alpha})`;
            } else {
              ctx.fillStyle = `rgba(20, 88, 182, ${0.2 * p.opacity})`;
            }

            ctx.beginPath();
            // Slightly enlarge dots that are close to the cursor
            ctx.arc(p.px, p.py, 1.1 + p.highlight * 0.8, 0, Math.PI * 2);
            ctx.fill();
          }
        }
      }
    };

    const tick = () => {
      draw();
      animationFrameId = requestAnimationFrame(tick);
    };

    tick();

    return () => {
      window.removeEventListener('resize', handleResize);
      window.removeEventListener('mousemove', handleMouseMove);
      document.removeEventListener('mouseleave', handleMouseLeave);
      window.removeEventListener('touchmove', handleTouchMove);
      window.removeEventListener('touchend', handleTouchEnd);
      document.removeEventListener('visibilitychange', handleVisibilityChange);
      cancelAnimationFrame(animationFrameId);
    };
  }, []);

  return (
    <canvas
      ref={canvasRef}
      className="absolute inset-0 w-full h-full opacity-75"
    />
  );
}

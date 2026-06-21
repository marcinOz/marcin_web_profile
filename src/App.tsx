/**
 * @license
 * SPDX-License-Identifier: Apache-2.0
 */

import { useScroll, motion, AnimatePresence } from 'motion/react';
import { useRef, useEffect, useState } from 'react';
import { Users, Smartphone, Bot, Mail, ExternalLink, Linkedin, X, Loader2 } from 'lucide-react';
import MeshBackground from './components/MeshBackground';

function CentralGraphic({ hideCards }: { hideCards: boolean }) {
  const [isVideoLoaded, setIsVideoLoaded] = useState(false);
  const [isMobile, setIsMobile] = useState(typeof window !== 'undefined' ? window.innerWidth < 768 : false);
  const videoRef = useRef<HTMLVideoElement>(null);

  useEffect(() => {
    const checkMobile = () => setIsMobile(window.innerWidth < 768);
    checkMobile();
    window.addEventListener('resize', checkMobile);
    return () => window.removeEventListener('resize', checkMobile);
  }, []);

  // Set isVideoLoaded to true if the video is already ready on mount
  useEffect(() => {
    const video = videoRef.current;
    if (video && video.readyState >= 2) {
      setIsVideoLoaded(true);
    }
  }, []);

  return (
    <div className="central-anchor">
      <div className="anchor-container">
        <div className="w-full h-full relative group">
          {/* VIDEO VERSION */}
          <video
            ref={videoRef}
            autoPlay
            loop
            muted
            playsInline
            onLoadedData={() => setIsVideoLoaded(true)}
            className="w-full h-full object-cover rounded-[60px] md:rounded-[80px] shadow-2xl grayscale hover:grayscale-0 transition-all duration-700 border-[12px] border-white/80"
            src={isMobile ? "/video_480.mp4" : "/video.mp4"}
            preload="auto"
          />

          <AnimatePresence>
            {!isVideoLoaded && (
              <motion.div
                initial={{ opacity: 1 }}
                exit={{ opacity: 0 }}
                transition={{ duration: 0.5 }}
                className="absolute inset-0 z-10 flex flex-col items-center justify-center bg-slate-100/90 backdrop-blur-md rounded-[60px] md:rounded-[80px] border-[12px] border-white/80"
              >
                <Loader2 className="w-10 h-10 text-primary animate-spin mb-4" />
                <span className="text-sm font-bold text-primary tracking-widest uppercase">Loading</span>
              </motion.div>
            )}
          </AnimatePresence>

          <div className="absolute -right-24 md:-right-48 top-12 space-y-4 pointer-events-auto hidden md:block">
            {[
              {
                icon: <Users size={18} />,
                title: "Engineering Leadership",
                desc: "Team design & mentoring",
                bg: "hero-gradient text-white"
              },
              {
                icon: <Smartphone size={18} />,
                title: "Mobile Platform",
                desc: "Flutter & Scaling",
                bg: "bg-tertiary-container text-on-tertiary-container"
              },
              {
                icon: <Bot size={18} />,
                title: "AI Engineering",
                desc: "Workflow Productivity",
                bg: "bg-secondary-container text-on-secondary-container"
              }
            ].map((card, i) => (
              <motion.div
                key={i}
                custom={i}
                initial="hidden"
                animate={hideCards ? "exit" : "visible"}
                variants={{
                  hidden: { scale: 0, opacity: 0 },
                  visible: (i) => ({
                    scale: 1,
                    opacity: 1,
                    transition: { delay: i * 0.15, type: "spring", stiffness: 300, damping: 20 }
                  }),
                  exit: (i) => ({
                    scale: 0,
                    opacity: 0,
                    transition: { delay: (2 - i) * 0.1, duration: 0.3, ease: "easeIn" }
                  })
                }}
              >
                <motion.div
                  animate={{ y: [0, -8, 0] }}
                  transition={{ duration: 3 + i * 0.2, repeat: Infinity, ease: "easeInOut", delay: i * 0.3 }}
                  className="glass-card p-4 rounded-2xl flex items-center gap-4 w-[240px] md:w-[280px] shadow-xl hover:translate-x-4 transition-transform duration-500"
                >
                  <div className={`w-10 h-10 rounded-full flex items-center justify-center shrink-0 ${card.bg}`}>
                    {card.icon}
                  </div>
                  <div>
                    <h4 className="font-headline font-extrabold text-[10px] text-on-surface uppercase tracking-wider">{card.title}</h4>
                    <p className="text-[9px] text-on-surface-variant leading-tight">{card.desc}</p>
                  </div>
                </motion.div>
              </motion.div>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
}

function Header() {
  const { scrollY } = useScroll();
  const [isScrolled, setIsScrolled] = useState(false);

  useEffect(() => {
    return scrollY.on("change", (latest) => {
      // 80px is just before the "Engineering leadership..." heading
      setIsScrolled(latest > 80);
    });
  }, [scrollY]);

  return (
    <header 
      className={`fixed top-0 w-full z-[100] flex justify-between items-center px-6 md:px-12 transition-all duration-500 ${
        isScrolled 
          ? 'py-4 bg-white/85 backdrop-blur-md border-b border-slate-200/60 shadow-sm' 
          : 'py-6 bg-transparent border-b border-transparent'
      }`}
    >
      <div className="text-2xl font-black text-slate-900 tracking-tighter">Marcin.</div>
      <nav className={`hidden lg:flex items-center gap-10 px-8 py-3 rounded-full transition-all duration-500 ${
        isScrolled 
          ? 'bg-transparent border border-transparent shadow-none' 
          : 'bg-white/60 backdrop-blur-md border border-white/20 shadow-sm'
      }`}>
        <a className="text-sm font-bold text-slate-900 hover:text-primary transition-colors" href="#hero">Home</a>
        <a className="text-sm font-bold text-slate-600 hover:text-primary transition-colors" href="#impact">Impact</a>
        <a className="text-sm font-bold text-slate-600 hover:text-primary transition-colors" href="#experience">Experience</a>
        <a className="text-sm font-bold text-slate-600 hover:text-primary transition-colors" href="#writing">Writing</a>
        <a className="text-sm font-bold text-slate-600 hover:text-primary transition-colors" href="#contact">Contact</a>
      </nav>
      <a 
        href="https://www.linkedin.com/in/marcin-oziemski"
        target="_blank"
        rel="noopener noreferrer"
        className="bg-primary text-white px-8 py-3 rounded-full font-bold text-sm tracking-wide shadow-lg shadow-primary/20 hover:bg-primary-dim active:scale-95 transition-all flex items-center gap-2"
      >
        <Linkedin size={16} />
        LET'S TALK
      </a>
    </header>
  );
}

export default function App() {
  const { scrollY } = useScroll();
  const [hideCards, setHideCards] = useState(false);
  const [isPrivacyModalOpen, setIsPrivacyModalOpen] = useState(false);
  const leadershipRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    return scrollY.on("change", (latest) => {
      if (leadershipRef.current) {
        const triggerPoint = leadershipRef.current.offsetTop - window.innerHeight * 0.6;
        setHideCards(latest > triggerPoint);
      }
    });
  }, [scrollY]);

  return (
    <div className="bg-surface font-body text-on-surface selection:bg-primary-container selection:text-on-primary-container min-h-screen overflow-x-hidden">
      {/* Background Effects */}
      <div className="fixed inset-0 z-0 pointer-events-none overflow-hidden">
        <div className="absolute top-[5%] left-[-10%] w-[600px] h-[600px] bg-primary/5 rounded-full blur-[140px]"></div>
        <div className="absolute bottom-[10%] right-[-10%] w-[700px] h-[700px] bg-tertiary/5 rounded-full blur-[140px]"></div>
        <MeshBackground />
      </div>

      <Header />
      <CentralGraphic hideCards={hideCards} />

      <main className="relative z-10 pointer-events-none mt-[460px] md:mt-0">
        <div className="bg-surface/95 backdrop-blur-3xl md:bg-transparent md:backdrop-blur-none px-6 md:px-12 pt-12 md:pt-0 rounded-t-[3rem] md:rounded-none shadow-[0_-10px_40px_rgba(0,0,0,0.05)] md:shadow-none">
          <section className="min-h-screen flex flex-col md:flex-row justify-between items-center" id="hero">
          <div className="content-column pt-4 md:pt-40">
            <h1 className="chapter-heading">
              Engineering leadership for teams at scale.
            </h1>
            <p className="text-xl md:text-2xl text-slate-600 font-medium leading-relaxed mb-8">
              I lead platform and product engineering teams, improve delivery systems, and turn complex transformations into structured execution.
            </p>
            <p className="text-slate-500 font-body leading-relaxed mb-10 max-w-sm">
              I currently lead Mobile App Platform and Big Bets work at OLX, managing around 25 engineers across multiple workstreams. My background spans Android, Flutter, incident management, and AI-powered workflows.
            </p>
            <div className="bg-white/60 backdrop-blur border border-slate-200 px-6 py-4 rounded-full inline-flex items-center gap-3">
              <Mail className="text-primary" size={20} />
              <span className="font-medium text-slate-700">oziemski.marcin@gmail.com</span>
            </div>
          </div>
          <div className="content-column hidden md:block"></div>
        </section>

        <section className="flex flex-col md:flex-row justify-between" id="impact">
          <div className="content-column">
            <div className="sticky top-[80px] md:top-[120px]">
              <h2 className="chapter-heading">Selected Impact</h2>
              <p className="text-slate-500 text-lg max-w-xs">Tangible results from leading organizations and scaling delivery ecosystems.</p>
            </div>
          </div>
          <div className="content-column flex flex-col gap-6">
            <div className="impact-card" ref={leadershipRef}>
              <div className="text-primary font-bold text-xs uppercase mb-2 tracking-widest">Leadership</div>
              <p className="text-slate-900 font-semibold text-lg">Led a 25-engineer organization across platform and product workstreams at OLX</p>
            </div>
            <div className="impact-card">
              <div className="text-tertiary font-bold text-xs uppercase mb-2 tracking-widest">Strategy</div>
              <p className="text-slate-900 font-semibold text-lg">Conceived and led the Jobs Verticalization Task Force, combining business delivery with Flutter migration</p>
            </div>
            <div className="impact-card">
              <div className="text-secondary font-bold text-xs uppercase mb-2 tracking-widest">Scaling</div>
              <p className="text-slate-900 font-semibold text-lg">Scaled a team from 13 to 25 engineers while establishing structure, routines, and delivery cadence within weeks</p>
            </div>
            <div className="impact-card">
              <div className="text-emerald-600 font-bold text-xs uppercase mb-2 tracking-widest">Metrics</div>
              <p className="text-slate-900 font-semibold text-lg">Improved sprint predictability to 80%+ with a median cycle time of around 5 days</p>
            </div>
            <div className="impact-card">
              <div className="text-amber-600 font-bold text-xs uppercase mb-2 tracking-widest">Product</div>
              <p className="text-slate-900 font-semibold text-lg">Rolled out the App Rating module, improving store ratings from 2.0 to 4.5</p>
            </div>
            <div className="impact-card">
              <div className="text-slate-500 font-bold text-xs uppercase mb-2 tracking-widest">Process</div>
              <p className="text-slate-900 font-semibold text-lg">Created a cross-organizational Mobile Incident Group shift from reactive to proactive</p>
            </div>
          </div>
        </section>

        <section className="flex flex-col md:flex-row justify-between" id="experience">
          <div className="content-column">
            <div className="sticky top-[80px] md:top-[120px]">
              <h2 className="chapter-heading">Experience</h2>
              <p className="text-slate-500 text-lg max-w-xs">A career built at the intersection of technical excellence and strategic engineering management.</p>
            </div>
          </div>
          <div className="content-column">
            <div className="space-y-16">
              <div className="relative pl-12 border-l-2 border-primary/20">
                <div className="absolute -left-[11px] top-0 w-5 h-5 rounded-full bg-primary ring-8 ring-primary/5"></div>
                <span className="text-sm font-bold text-primary block mb-1">Present</span>
                <h3 className="text-2xl font-bold text-slate-900">Engineering Manager, OLX</h3>
                <p className="text-slate-600 mt-2 leading-relaxed">Leading mobile platform and product workstreams across multiple business units. Managing technical roadmap and organizational health.</p>
              </div>
              <div className="relative pl-12 border-l-2 border-slate-200">
                <div className="absolute -left-[11px] top-0 w-5 h-5 rounded-full bg-slate-300"></div>
                <span className="text-sm font-bold text-slate-400 block mb-1">Previous</span>
                <h3 className="text-2xl font-bold text-slate-900">Engineering Lead, Netguru</h3>
                <p className="text-slate-600 mt-2 leading-relaxed">Managed multi-project delivery, engineering quality, and stakeholder alignment across a portfolio of products.</p>
              </div>
              <div className="relative pl-12 border-l-2 border-slate-200">
                <div className="absolute -left-[11px] top-0 w-5 h-5 rounded-full bg-slate-300"></div>
                <span className="text-sm font-bold text-slate-400 block mb-1">Background</span>
                <h3 className="text-2xl font-bold text-slate-900">Senior Android / Flutter Leader</h3>
                <p className="text-slate-600 mt-2 leading-relaxed">Built Flutter capability from scratch, owned hiring pipelines, and grew from senior IC into engineering leadership.</p>
              </div>
            </div>
          </div>
        </section>

        <section className="flex flex-col md:flex-row justify-between" id="writing">
          <div className="content-column">
            <div className="sticky top-[80px] md:top-[120px]">
              <h2 className="chapter-heading">Writing & Speaking</h2>
              <p className="text-lg text-slate-600 leading-relaxed max-w-sm">
                I share insights about mobile engineering, architecture, and developer workflows through articles and conference talks.
              </p>
            </div>
          </div>
          <div className="content-column flex flex-col justify-center">
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
              <a className="flex items-center justify-between p-6 bg-white/60 rounded-2xl border border-slate-100 hover:border-primary transition-all group shadow-sm" href="https://medium.com/@oziemski" target="_blank" rel="noopener noreferrer">
                <div className="flex flex-col">
                  <span className="font-bold text-slate-900">Medium</span>
                  <span className="text-xs text-slate-500">Technical Articles</span>
                </div>
                <ExternalLink className="text-slate-300 group-hover:text-primary transition-colors" size={20} />
              </a>
              <a className="flex items-center justify-between p-6 bg-white/60 rounded-2xl border border-slate-100 hover:border-primary transition-all group shadow-sm" href="https://www.linkedin.com/in/marcin-oziemski/" target="_blank" rel="noopener noreferrer">
                <div className="flex flex-col">
                  <span className="font-bold text-slate-900">LinkedIn</span>
                  <span className="text-xs text-slate-500">Thought Leadership</span>
                </div>
                <ExternalLink className="text-slate-300 group-hover:text-primary transition-colors" size={20} />
              </a>
              <a className="flex items-center justify-between p-6 bg-white/60 rounded-2xl border border-slate-100 hover:border-primary transition-all group shadow-sm" href="https://github.com/marcinOz" target="_blank" rel="noopener noreferrer">
                <div className="flex flex-col">
                  <span className="font-bold text-slate-900">GitHub</span>
                  <span className="text-xs text-slate-500">Open Source</span>
                </div>
                <ExternalLink className="text-slate-300 group-hover:text-primary transition-colors" size={20} />
              </a>
              <a className="flex items-center justify-between p-6 bg-white/60 rounded-2xl border border-slate-100 hover:border-primary transition-all group shadow-sm" href="https://vimeo.com/844165894" target="_blank" rel="noopener noreferrer">
                <div className="flex flex-col">
                  <span className="font-bold text-slate-900">Vimeo</span>
                  <span className="text-xs text-slate-500">Presentation Recording</span>
                </div>
                <ExternalLink className="text-slate-300 group-hover:text-primary transition-colors" size={20} />
              </a>
            </div>
            <p className="mt-12 p-8 bg-primary/5 rounded-3xl border border-primary/10 text-slate-700 italic">
              "I’ve published 10+ technical articles and given conference talks focused on engineering team effectiveness and architecture."
            </p>
          </div>
        </section>

        <section className="flex flex-col md:flex-row justify-between items-center" id="about">
          <div className="content-column">
            <h2 className="chapter-heading">About</h2>
            <p className="text-xl text-slate-600 leading-relaxed">
              I’m based in Gdańsk, Poland, and I enjoy working at the intersection of engineering leadership, platform thinking, and product delivery. I’m especially interested in mobile ecosystems, organization design, and using AI tools in practical, team-friendly ways.
            </p>
          </div>
          <div className="content-column">
            <div className="glass-card p-10 md:p-14 rounded-[3rem] text-center border-primary/20 bg-white/80 shadow-2xl relative overflow-hidden group" id="contact">
              <div className="absolute inset-0 hero-gradient opacity-0 group-hover:opacity-[0.02] transition-opacity duration-700 pointer-events-none"></div>
              <h3 className="text-3xl font-headline font-extrabold text-slate-900 mb-8">
                Building a platform, scaling engineering teams, or improving delivery systems?
              </h3>
              <a 
                href="https://www.linkedin.com/in/marcin-oziemski"
                target="_blank"
                rel="noopener noreferrer"
                className="bg-primary text-white px-12 py-5 rounded-full font-bold text-xl shadow-2xl shadow-primary/30 hover:scale-105 hover:shadow-primary/40 active:scale-95 transition-all inline-flex items-center gap-3"
              >
                <Linkedin size={24} />
                Let’s talk.
              </a>
            </div>
          </div>
        </section>
        </div>
      </main>

      <footer className="relative z-50 w-full py-16 bg-white/60 border-t border-slate-200/60 backdrop-blur-md">
        <div className="max-w-7xl mx-auto px-6 md:px-12 flex flex-col md:flex-row justify-between items-center gap-8">
          <div className="text-2xl font-black text-slate-900 tracking-tighter">Marcin.</div>
          <p className="font-body text-xs text-slate-500 uppercase tracking-widest">© 2024 Marcin Oziemski | Engineering Leadership</p>
          <div className="flex gap-10 text-sm font-bold">
            <button onClick={() => setIsPrivacyModalOpen(true)} className="text-slate-400 hover:text-primary transition-colors cursor-pointer">Privacy</button>
            <a className="text-slate-400 hover:text-primary transition-colors" href="#">Terms</a>
            <a className="text-slate-400 hover:text-primary transition-colors" href="https://www.linkedin.com/in/marcin-oziemski" target="_blank" rel="noopener noreferrer">LinkedIn</a>
          </div>
        </div>
      </footer>

      <aside className="fixed bottom-12 right-6 md:right-12 flex flex-col gap-4 z-50">
        <a className="w-14 h-14 bg-white shadow-xl rounded-full flex items-center justify-center text-slate-500 hover:text-primary hover:scale-110 transition-all border border-slate-100" href="mailto:oziemski.marcin@gmail.com">
          <Mail size={24} />
        </a>
      </aside>

      {/* Privacy Policy Modal */}
      <AnimatePresence>
        {isPrivacyModalOpen && (
          <div className="fixed inset-0 z-[200] flex items-center justify-center p-4 sm:p-6">
            <motion.div
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              exit={{ opacity: 0 }}
              className="absolute inset-0 bg-slate-900/40 backdrop-blur-sm"
              onClick={() => setIsPrivacyModalOpen(false)}
            />
            <motion.div
              initial={{ opacity: 0, scale: 0.95, y: 20 }}
              animate={{ opacity: 1, scale: 1, y: 0 }}
              exit={{ opacity: 0, scale: 0.95, y: 20 }}
              className="relative w-full max-w-2xl bg-white rounded-3xl shadow-2xl overflow-hidden flex flex-col max-h-[90vh]"
            >
              <div className="p-8 md:p-10 overflow-y-auto">
                <button
                  onClick={() => setIsPrivacyModalOpen(false)}
                  className="absolute top-6 right-6 p-2 bg-slate-100 hover:bg-slate-200 rounded-full text-slate-500 transition-colors"
                >
                  <X size={20} />
                </button>
                <h2 className="text-3xl font-headline font-extrabold text-slate-900 mb-8">Privacy Policy</h2>
                
                <div className="space-y-8 text-slate-600 text-sm md:text-base leading-relaxed">
                  <div>
                    <h3 className="font-bold text-slate-900 mb-2 text-lg">1. General Information</h3>
                    <p>This website serves as a personal portfolio/showcase. The owner of the website is Marcin Oziemski.</p>
                  </div>
                  
                  <div>
                    <h3 className="font-bold text-slate-900 mb-2 text-lg">2. Data Processing (Hosting)</h3>
                    <p>This website is hosted using Google Firebase. As a result, Google servers may automatically collect certain technical data, such as:</p>
                    <ul className="list-disc pl-5 mt-3 space-y-2">
                      <li>Your IP address,</li>
                      <li>Date and time of access,</li>
                      <li>Information about your browser and operating system.</li>
                    </ul>
                    <p className="mt-3">This data is used solely for technical purposes (to ensure website stability) and for security monitoring.</p>
                  </div>

                  <div>
                    <h3 className="font-bold text-slate-900 mb-2 text-lg">3. Contact (LinkedIn)</h3>
                    <p>The website features a "Let's Talk" button that redirects you to LinkedIn. By clicking this button, you are navigating to an external platform that operates under its own privacy policy and uses its own cookies. This website does not capture your login credentials or the content of any messages sent via LinkedIn.</p>
                  </div>

                  <div>
                    <h3 className="font-bold text-slate-900 mb-2 text-lg">4. Cookies</h3>
                    <p>This website does not use its own tracking or marketing cookies. Basic technical cookies may be generated by the Firebase infrastructure to ensure the website functions correctly.</p>
                  </div>

                  <div>
                    <h3 className="font-bold text-slate-900 mb-2 text-lg">5. Contact</h3>
                    <p>If you have any questions regarding this privacy policy, please feel free to reach out to me directly via my LinkedIn profile.</p>
                  </div>
                </div>
              </div>
            </motion.div>
          </div>
        )}
      </AnimatePresence>
    </div>
  );
}

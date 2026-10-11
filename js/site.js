// Mobile menu, before/after sliders and gentle reveal-on-scroll, shared by every page.
(() => {
  const header = document.querySelector('header'), btn = document.querySelector('.menu-toggle');
  if (header && btn) {
    const set = open => { header.classList.toggle('open', open); btn.setAttribute('aria-expanded', open); };
    btn.addEventListener('click', () => set(!header.classList.contains('open')));
    header.querySelectorAll('nav a').forEach(a => a.addEventListener('click', () => set(false)));
    document.addEventListener('keydown', e => { if (e.key === 'Escape') set(false); });
  }

  document.querySelectorAll('.ba').forEach(ba => {
    const input = ba.querySelector('input');
    const update = () => ba.style.setProperty('--pos', input.value + '%');
    input.addEventListener('input', update); update();
  });

  const targets = document.querySelectorAll('section h2, .lead, .services > div, .works a, .why > div, .steps li, .timeline li, .gallery button, .ba, .facts, details');
  if (!('IntersectionObserver' in window) || matchMedia('(prefers-reduced-motion: reduce)').matches) return;
  document.documentElement.classList.add('js');
  const io = new IntersectionObserver(entries => entries.forEach(e => {
    if (e.isIntersecting) { e.target.classList.add('in'); io.unobserve(e.target); }
  }), {rootMargin: '0px 0px -8% 0px'});
  targets.forEach((el, i) => {
    if (el.getBoundingClientRect().top < innerHeight) return;   // already on screen: leave it as is
    el.classList.add('reveal');
    const sib = [...el.parentElement.children].indexOf(el);
    el.style.transitionDelay = Math.min(sib, 5) * 80 + 'ms';
    io.observe(el);
  });
})();

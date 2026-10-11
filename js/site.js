// Mobile menu: the ☰ button opens and closes the nav; picking a link or pressing Esc closes it.
(() => {
  const header = document.querySelector('header'), btn = document.querySelector('.menu-toggle');
  if (!header || !btn) return;
  const set = open => { header.classList.toggle('open', open); btn.setAttribute('aria-expanded', open); };
  btn.addEventListener('click', () => set(!header.classList.contains('open')));
  header.querySelectorAll('nav a').forEach(a => a.addEventListener('click', () => set(false)));
  document.addEventListener('keydown', e => { if (e.key === 'Escape') set(false); });
})();

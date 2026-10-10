// Project gallery: click a photo to open it large; arrows, swipe and keyboard move between photos.
(() => {
  const items = [...document.querySelectorAll('.gallery button')];
  const lb = document.querySelector('dialog.lb');
  if (!items.length || !lb) return;
  const img = lb.querySelector('img'), cap = lb.querySelector('figcaption');
  let i = 0;
  const show = n => {
    i = (n + items.length) % items.length;
    const thumb = items[i].querySelector('img');
    img.src = items[i].dataset.full;
    img.alt = thumb.alt;
    cap.textContent = `${thumb.alt} (${i + 1} of ${items.length})`;
  };
  items.forEach((b, n) => b.addEventListener('click', () => { show(n); lb.showModal(); }));
  lb.querySelector('.x').onclick = () => lb.close();
  lb.querySelector('.prev').onclick = () => show(i - 1);
  lb.querySelector('.next').onclick = () => show(i + 1);
  lb.querySelector('.prev').hidden = lb.querySelector('.next').hidden = items.length < 2;
  lb.addEventListener('click', e => { if (e.target === lb || e.target.tagName === 'FIGURE') lb.close(); });
  lb.addEventListener('keydown', e => {
    if (e.key === 'ArrowLeft') show(i - 1);
    if (e.key === 'ArrowRight') show(i + 1);
  });
  let x0 = null;
  lb.addEventListener('touchstart', e => { x0 = e.touches[0].clientX; }, {passive: true});
  lb.addEventListener('touchend', e => {
    if (x0 === null) return;
    const dx = e.changedTouches[0].clientX - x0; x0 = null;
    if (Math.abs(dx) > 40) show(dx < 0 ? i + 1 : i - 1);
  });
})();

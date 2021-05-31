const toggleDashboard = () => {
  console.log('hello world');

  const avatar = document.querySelector('#navbarDropdown');

  const dashboard = document.querySelector('#dashboard');

  const notif = document.getElementById('navbar-avatar');

  if (!(avatar && dashboard)) return;

  avatar.addEventListener('click', () => {
    if (dashboard.classList.contains('hidden')) {
      dashboard.style.transition = "all 0.5s ease";
      dashboard.classList.remove('hidden');
        if (notif.classList.contains('notification')) {
          notif.classList.remove('notification');
        }
    } else {
      dashboard.classList.add('hidden');
      dashboard.style.transition = "";
    }
  });
}

export { toggleDashboard };

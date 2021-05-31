const toggleDashboard = () => {
  console.log('hello world');

  const avatar = document.querySelector('#navbarDropdown');

  const dashboard = document.querySelector('#dashboard')

  if (!(avatar && dashboard)) return;

  avatar.addEventListener('click', () => {
    if (dashboard.classList.contains('hidden')) {
      dashboard.style.transition = "all 0.5s ease";
      dashboard.classList.remove('hidden');
    } else {
      dashboard.classList.add('hidden');
      dashboard.style.transition = "";
    }
  });
}

export { toggleDashboard };

const changeHeart = () => {
  console.log('hello world');

  const heart = document.querySelector('#favorite-heart');

  heart.addEventListener('click', () => {
    if (heart.classList.contains('far fa-heart mb-2')) {
      heart.classList.remove('far fa-heart mb-2');
      heart.classList.add('fas fa-heart mb-2');
    }
  });
}

export { changeHeart };

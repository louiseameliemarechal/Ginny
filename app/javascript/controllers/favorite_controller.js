import { Controller } from "stimulus"
import Rails from "@rails/ujs"

export default class extends Controller {
  static targets = ['heart']
  static values = { doctor: String }

  get favoritesContainer() {
    return document.getElementById('favorites-container');
  }

  favorite() {
    Rails.ajax({
      type: "post",
      url: `/doctors/${this.doctorValue}/favorites`,
      success: (data) => {
        this.favoritesContainer.insertAdjacentHTML('beforeend', data.dashboard_favorite);
        this.fullHeart(data);
      }
    })
  }

  unfavorite(event) {
    // console.log(event.target.dataset.id)
    console.log(event.target);
    Rails.ajax({
      type: "delete",
      url: `/favorites/${event.target.dataset.id}`,
      success: () => {
        const dashboardFavorite = document.querySelector(`[data-favorite-id="${event.target.dataset.id}"]`);
        console.log(dashboardFavorite);
        dashboardFavorite.remove();
        this.emptyHeart();
      }
    })
  }

  fullHeart(data) {
    this.heartTarget.innerHTML = `
      <i class="fas fa-heart mb-2"
         data-id=${data.favorite.id}
         data-favorite-target="heart"
         data-action="click->favorite#unfavorite"></i>`
  }

  emptyHeart() {
    this.heartTarget.innerHTML = `
      <i class="far fa-heart mb-2"
         data-favorite-id-value=${null}
         data-favorite-target="heart"
         data-action="click->favorite#favorite"></i>`
  }

}

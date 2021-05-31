import { Controller } from "stimulus"
import Rails from "@rails/ujs"

export default class extends Controller {
  static targets = ['heart']
  static values = { doctor: String }

  favorite() {
    Rails.ajax({
      type: "post",
      url: `/doctors/${this.doctorValue}/favorites`,
      success: (data) => { this.fullHeart(data) }
    })
  }

  unfavorite(event) {
    // console.log(event.target.dataset.id)
    Rails.ajax({
      type: "delete",
      url: `/favorites/${event.target.dataset.id}`,
      success: () => { this.emptyHeart() }
    })
  }

  fullHeart(data) {
    this.heartTarget.innerHTML = `
      <i class="fas fa-heart mb-2"
         data-favorite-id-value=${data.id}
         data-favorite-target="heart"
         data-action="click->favorite#unfavorite"></i>`
  }

  emptyHeart() {
    this.heartTarget.innerHTML = `
      <i class="far fa-heart mb-2"
         data-favorite-id-value=${null}
         data-favorite-target="heart"
         data-action="click->favorite#unfavorite"></i>`
  }

}

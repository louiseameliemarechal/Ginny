import { timers } from "jquery"
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["advancedFilters", "filtersBtn"]

  connect() {
    console.log('Hello from search_form_controller');
  }

  showAdvancedFilters() {
    event.preventDefault();
    this.advancedFiltersTarget.classList.remove('d-none');
    this.filtersBtnTarget.classList.add('d-none');
  }
}

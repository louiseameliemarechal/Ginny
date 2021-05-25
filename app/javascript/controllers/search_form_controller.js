import { timers } from "jquery"
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["advancedFilters"]

  connect() {
    console.log('Hello from search_form_controller');
  }

  showAdvancedFilters() {
    event.deventDefault();
    this.advancedFiltersTarget.classList.remove('d-none');
  }
}

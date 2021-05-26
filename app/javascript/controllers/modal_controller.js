import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["checkbox", "errorMessage", "nextButton"]

  change() {
    if (this.checkboxTarget.checked!=true) {
      this.errorMessageTarget.classList.remove('d-none')
    } else {
      this.nextButtonTarget.click()
    }
  }
}
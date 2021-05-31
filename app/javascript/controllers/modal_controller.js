import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["checkbox", "nextButton", "label", "searchForm", "footer", "message"]

  change() {
    if (this.checkboxTarget.checked!=true) {
      this.labelTarget.classList.add("red-color");
    } else {
      /* this.nextButtonTarget.click(); */
      this.searchFormTarget.classList.remove("d-none");
      this.footerTarget.remove();
      this.messageTarget.classList.add("d-none");
    }
  }
}
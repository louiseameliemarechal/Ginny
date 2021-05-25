// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["step1", "step2", "progress", "loginButton"]

  change() {
    if (this.step1Target.classList.contains('d-none')){
      this.loginButtonTarget.click()
    }
    this.step1Target.classList.add('d-none');
    this.step2Target.classList.remove('d-none');
    this.progressTarget.setAttribute("style", 'width: 60%;');
  }
}

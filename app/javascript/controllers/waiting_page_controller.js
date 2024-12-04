import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="waiting-page"
export default class extends Controller {
  static targets = ["waitingDom", "form", "dom"]
  connect() {
  }

  wait() {
    const form = this.formTarget
    if (form.checkValidity() === true) {
      if (form.id === "new_fridge_scan") {
        this.domTarget.classList.add("d-none")
        this.waitingDomTarget.innerHTML = `
        <div class="waiting-scan-gif">
          <h3>Looking for your ingredients</h3>
          <img src="https://media2.giphy.com/media/3o6gEd7LbHXWWiLbuE/200w.webp?cid=dda24d50986bef2kcb6251do3b8rr76vlt2cfhhgp3kxpteh&amp;ep=v1_internal_gif_by_id&amp;rid=200w.webp&amp;ct=g" srcset="https://media2.giphy.com/media/3o6gEd7LbHXWWiLbuE/200w.webp?cid=dda24d50986bef2kcb6251do3b8rr76vlt2cfhhgp3kxpteh&amp;ep=v1_internal_gif_by_id&amp;rid=200w.webp&amp;ct=g 200w,https://media2.giphy.com/media/3o6gEd7LbHXWWiLbuE/giphy.webp?cid=dda24d50986bef2kcb6251do3b8rr76vlt2cfhhgp3kxpteh&amp;ep=v1_internal_gif_by_id&amp;rid=giphy.webp&amp;ct=g 480w," alt="Fridge scanning gif"></img>
        </div>`
      } else {
          this.domTarget.classList.add("d-none")
          this.waitingDomTarget.innerHTML = `
          <div class="waiting-recipes-gif">
            <h2>Just a moment, our chef is preparing your delicious recipes</h2>
            <img src="https://media4.giphy.com/media/l1TJTwU3VfPHU4FCbx/200w.webp?cid=dda24d50ygtqtzz5xp3z60qpolmoa26ihmg2vzvui3uecvj2&amp;ep=v1_internal_gif_by_id&amp;rid=200w.webp&amp;ct=g" srcset="https://media4.giphy.com/media/l1TJTwU3VfPHU4FCbx/200w.webp?cid=dda24d50ygtqtzz5xp3z60qpolmoa26ihmg2vzvui3uecvj2&amp;ep=v1_internal_gif_by_id&amp;rid=200w.webp&amp;ct=g 200w,https://media4.giphy.com/media/l1TJTwU3VfPHU4FCbx/giphy.webp?cid=dda24d50ygtqtzz5xp3z60qpolmoa26ihmg2vzvui3uecvj2&amp;ep=v1_internal_gif_by_id&amp;rid=giphy.webp&amp;ct=g 480w," alt="Cooking Chef"></img>
          </div>`
      }
    }
  }
}

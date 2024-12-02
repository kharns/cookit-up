import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="waiting-page"
export default class extends Controller {
  static targets = ["newScanDom", "form"]
  connect() {
    console.log("connecte coco")
    console.log(this.formTarget)
  }

  wait(event) {
    console.log(event)

    if (this.formTarget.checkValidity() === true) {
      this.formTarget.classList.add("d-none")
      this.newScanDomTarget.innerHTML = `<div class="waiting-gif">
                                        <h3>Looking for your ingredients</h3>
                                        <img id="gif" class="nlSABoG9CSaJpsufv8WW9 _3vYn8QjoEvrXxHyqdn9ddZ _2XBDTIVigBJDybhZvL-hU3" src="https://media2.giphy.com/media/3o6gEd7LbHXWWiLbuE/200w.webp?cid=dda24d50986bef2kcb6251do3b8rr76vlt2cfhhgp3kxpteh&amp;ep=v1_internal_gif_by_id&amp;rid=200w.webp&amp;ct=g" srcset="https://media2.giphy.com/media/3o6gEd7LbHXWWiLbuE/200w.webp?cid=dda24d50986bef2kcb6251do3b8rr76vlt2cfhhgp3kxpteh&amp;ep=v1_internal_gif_by_id&amp;rid=200w.webp&amp;ct=g 200w,https://media2.giphy.com/media/3o6gEd7LbHXWWiLbuE/giphy.webp?cid=dda24d50986bef2kcb6251do3b8rr76vlt2cfhhgp3kxpteh&amp;ep=v1_internal_gif_by_id&amp;rid=giphy.webp&amp;ct=g 480w," alt="Fridge scanning gif"></img>
                                        </div>`
    }
  }
}

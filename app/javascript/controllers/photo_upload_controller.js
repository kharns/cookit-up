import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="photo-upload"
export default class extends Controller {
  static targets = ["input", "preview", "submit"]

  connect() {
    console.log("photo-upload connected")
    console.log(this.inputTarget)
  }

  preview() {

    const file = this.inputTarget.files[0]
    if (file) {
      this.submitTarget.classList.remove('d-none')
      const reader = new FileReader()
      reader.onload = (e) => {
        this.previewTarget.src = e.target.result
        this.previewTarget.style.display = ""
      }
      reader.readAsDataURL(file)
    }

    console.log(this.formTarget)
    console.log(this.inputTarget.files[0])

  }
}

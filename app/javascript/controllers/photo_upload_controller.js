import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="photo-upload"
export default class extends Controller {
  static targets = ["input", "preview", "submit"]

  connect() {
    console.log("photo-upload connected")
    console.log(this.inputTarget)
  }

  preview() {
    // file = fichier uploadé par user
    const file = this.inputTarget.files[0]

    // Si file présent
    if (file) {
      // On affiche le bouton submit du formulaire
      this.submitTarget.classList.remove('d-none')

      // pour la preview de l'image //
      const reader = new FileReader()
      reader.onload = (e) => {
        // Au chargement de l'image, on met à jour la src de l'img du DOM
        this.previewTarget.src = e.target.result
        // On retire le display-none
        this.previewTarget.style.display = ""
      }
      reader.readAsDataURL(file)
    }
  }
}

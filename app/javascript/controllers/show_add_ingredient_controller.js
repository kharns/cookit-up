import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // Définition des cibles Stimulus pour ce contrôleur
    // Ces cibles correspondent aux éléments HTML avec des attributs data-show-add-ingredient-target
    // - "input" : le champ de saisie de texte
    // - "form" : le formulaire complet
    // - "formContainer" : le div qui contient le formulaire
    // - "toggleButton" : le bouton '+' initial qui déclenche l'affichage du formulaire
  static targets = [ "input", "form", "formContainer", "toggleButton" ]

  // Méthode déclenchée lors du clic sur le bouton '+'
  toggle(event) {
    // Empêche le comportement par défaut de l'événement
    // (comme la soumission du formulaire ou le rechargement de page)
    event.preventDefault()

    // Rend le conteneur du formulaire visible
    // Passe de display: none à display: block
    this.formContainerTarget.style.display = 'block'

    // Cache le bouton '+' initial
    // Le bouton disparaît pour laisser place au formulaire
    this.toggleButtonTarget.style.display = 'none'

    // Donne le focus au champ de saisie
    // Permet à l'utilisateur de commencer à saisir immédiatement
    this.inputTarget.focus()
  }

  // Méthode pour soumettre le formulaire
  submitForm(event) {
    // Empêche le comportement par défaut de l'événement de soumission
    // Évite le rechargement de page ou toute action par défaut
    event.preventDefault()

    // Soumet programmatiquement le formulaire
    // Déclenche l'envoi des données sans intervention manuelle
    this.formTarget.submit()
  }
}

import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="favourite"
export default class extends Controller {
  reload(event) {

    if (event.detail.success) {
      console.log("Rechargement de la page après succès");
      window.location.reload();
    } else {
      console.error("Erreur lors de la requête PATCH");
    }
  }
}

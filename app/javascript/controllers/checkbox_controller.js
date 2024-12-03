import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="checkbox"
export default class extends Controller {
  static targets = ["all", "item", "label"];

  // Toggles all individual checkboxes based on the "select all" checkbox
  toggleAll() {
    const checked = this.allTarget.checked;

    this.itemTargets.forEach(checkbox => {
      checkbox.checked = checked;
    });

    // Change the label text based on the state of "Select All"
    this.updateLabelText(checked);
  }

  // Updates the label text based on the state of the "select all" checkbox
  updateLabelText(isChecked) {
    const labelText = isChecked ? "UNSELECT ALL INGREDIENTS" : "SELECT ALL INGREDIENTS";
    this.labelTarget.textContent = labelText; // Met à jour le texte du label
  }

  // Updates the "select all" checkbox based on individual checkboxes' states
  toggleItem() {
    // Vérifie si tous les checkboxes individuels sont cochés
    const allChecked = this.itemTargets.every(checkbox => checkbox.checked);
    this.allTarget.checked = allChecked; // Met à jour l'état du checkbox "Select All"

    // Update the label text based on the new state of "Select All"
    this.updateLabelText(allChecked);
  }

  // Synchronizes the "select all" checkbox with individual checkboxes
  updateAllCheckbox() {
    const allChecked = this.itemTargets.every(checkbox => checkbox.checked);
    this.allTarget.checked = allChecked; // Met à jour l'état du checkbox "Select All"

    // Update the label text based on the new state of "Select All"
    this.updateLabelText(allChecked);
  }
}

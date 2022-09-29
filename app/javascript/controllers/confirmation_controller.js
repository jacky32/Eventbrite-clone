import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  confirm(event) {
    if (!window.confirm(this.messageValue)) {
      event.preventDefault();
      event.stopImmediatePropagation();
    }
  }

  toggleModal(event) {
    event.preventDefault();
    const deleteModal = document.getElementById("confirmation-modal");
    deleteModal.classList.toggle("is-active");
  }
}

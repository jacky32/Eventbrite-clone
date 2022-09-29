import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  toggleModal(event) {
    event.preventDefault();
    const deleteModal = document.getElementById("confirmation-modal");
    deleteModal.classList.toggle("is-active");
  }
}

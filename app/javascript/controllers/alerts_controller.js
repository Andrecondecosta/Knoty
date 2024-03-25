import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="alerts"
export default class extends Controller {
  static values = { notice: String, alert: String }
  static targets = ["subContentBox"]

  connect() {
    // console.log(this.subContentBoxTarget)
    const content = this.noticeValue || this.alertValue;

    if (content) {
      // const Toast = Swal.mixin({
      //   toast: true,
      //   position: "bottom",
      //   showConfirmButton: false,
      //   timer: 1000,
      //   didOpen: (toast) => {
      //     toast.onmouseenter = Swal.stopTimer;
      //     toast.onmouseleave = Swal.resumeTimer;
      //   }
      // });
      // Toast.fire({
      //   target: this.subContentBoxTarget,
      //   icon: content === this.noticeValue ? "success" : "error",
      //   title: content,
      //   width: '350px',
      //   customClass: {
      //     popup: 'rounded-pill bg-info text-light'
      //   }
      // });
      Swal.fire({
        title: "Custom animation with Animate.css",
        showClass: {
          popup: `
            animate__animated
            animate__fadeInUp
            animate__faster
          `
        },
        hideClass: {
          popup: `
            animate__animated
            animate__fadeOutDown
            animate__faster
          `
        }
      });

    }
  }
}

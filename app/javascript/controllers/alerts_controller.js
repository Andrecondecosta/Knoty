import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="alerts"
export default class extends Controller {
  static values = { notice: String, alert: String }

  connect() {
    const content = this.noticeValue || this.alertValue;

    if (content) {
      Swal.fire({
        title: content,
        target: document.querySelector('.content-box'),
        width: '350px',
        background: '#fff url(https://res.cloudinary.com/dvgcwuo68/image/upload/v1711462409/rsz_1rsz_1wooden-floor-background_w3ruiw.jpg)',
        iconHtml: content === this.noticeValue ? `<img src="https://res.cloudinary.com/dvgcwuo68/image/upload/v1711410815/icons8-check-ezgif.com-gif-maker_oqogow.gif">` :
          `<img src="https://res.cloudinary.com/dvgcwuo68/image/upload/v1711410816/icons8-error1-ezgif.com-gif-maker_fmdjtp.gif">`,
        showConfirmButton: false,
        timer: 2000,
        customClass: {
          popup: 'd-flex p-0 bg-light bg-opactiy-10',
          title: 'fs-5',
          icon: 'alert-icon no-border d-inline ps-3 bg-transparent my-1 d-flex align-items-center',
          title: 'd-inline align-self-center fs-5 ps-0 alert-bold text-dark w-100 pb-3'
        },
        showClass: {
          popup: `
            animate__animated
            animate__zoomInDown
            animate__fast
          `
        },
        hideClass: {
          popup: `
            animate__animated
            animate__zoomOutUp
            animate__fast
          `
        }
      });
    }
  }
}

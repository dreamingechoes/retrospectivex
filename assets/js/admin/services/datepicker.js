export function setup() {
  let datepicker = document.querySelector(".date");
  if (datepicker) {
    flatpickr(datepicker, {
      dateFormat: "Y-m-d H:i:ss",
      enableTime: true
    });
  }
}

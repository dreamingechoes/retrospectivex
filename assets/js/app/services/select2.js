export function setup() {
  let select2 = document.querySelector(".with-select2");
  if (select2) {
    $(select2).select2({tags: true, tokenSeparators: [',', ' ']})
  }
}

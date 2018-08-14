export function setup() {
  if (document.getElementsByClassName("collapse").length > 0) {
    $(".collapse").on("shown.bs.collapse", function(){
      $(this).parent().find(".fa-chevron-down").removeClass("fa-chevron-down").addClass("fa-chevron-up");
    }).on("hidden.bs.collapse", function(){
      $(this).parent().find(".fa-chevron-up").removeClass("fa-chevron-up").addClass("fa-chevron-down");
    });
  }
}

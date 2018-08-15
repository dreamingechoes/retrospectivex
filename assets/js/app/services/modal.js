const SELECTOR = '.modal';
const $tmpl = $(
  '<div class="modal"> \
    <div class="modal-backdrop"/> \
      <div class="modal-viewport"> \
        <div class="modal-dialog"> \
          <div class="modal-content"/></div> \
        </div> \
      </div> \
    </div> \
  </div>'
);

function fadeIn($modal) {
  const el = $modal[0];
  el.style.opacity = 0;
  (function fade() {
    var val = parseFloat(el.style.opacity);
    if (!((val += .1) > 1)) {
      el.style.opacity = val;
      requestAnimationFrame(fade);
    } else {
      $modal.trigger('dom-update', { source: 'modal' });
    }
  })();
};

export function open(content) {
  const $modal = $tmpl.clone();
  $('body').append($modal);
  $modal.find('.modal-content').html(content);
  fadeIn($modal);
  $modal.show();
}

export function replace(content) {
  const $modal = $(SELECTOR).last();
  $modal.show().find('.modal-content').html(content);
  $modal.trigger('dom-update', { source: 'modal' });
}

export function close() {
  const $el = $(SELECTOR).last();
  (function fade() {
    if ($el[0] && ($el[0].style.opacity -= .1) < 0) {
      $el.remove();
    } else {
      requestAnimationFrame(fade);
    }
  })();
}

function tryClose(e) {
  if ($(e.target).closest('.modal-content').length === 0) {
    close();
    return false;
  }
}

$(document).on('click', '.modal-viewport', tryClose);
$(document).on('click', '.modal-close', close);
$(document).on('click', '.modal-open', function (e) {
  e.preventDefault();
  open($(this.hash).html());
});

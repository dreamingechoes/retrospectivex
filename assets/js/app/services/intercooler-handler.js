import Intercooler from 'intercooler';
import { open, close } from './modal';

$(document).on('success.ic', (e, el, status, str, xhr) => {
  const action = el.attr('ic-custom-action');
  if (!action) return false;

  switch (action) {
    case "modal_open":
      open(xhr.responseText);
      break;
    case "modal_close":
      close();
      break;
    default:
      break;
  }
});

$(document).on('dom-update', (e, data) => {
  console.log('dom-update', data.source);
  if (data.source !== 'intercooler') Intercooler.processNodes(e.target);
});

Intercooler.ready((element) => element.trigger('dom-update', { source: 'intercooler' }));

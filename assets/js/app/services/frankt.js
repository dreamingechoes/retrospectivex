import * as Frankt from "frankt";
import * as Modal from "./modal.js";
import * as CodeMirror from "./codemirror.js";
import { serialize } from "frankt/priv/static/dom";

function attachResponses() {
  Frankt.channel.on("replace_with", (res) => $(res.target).trigger('dom-update', { source: 'frankt' }));
  Frankt.channel.on("open_modal", (res) => Modal.open(res.html));
  Frankt.channel.on("update_modal", (res) => Modal.replace(res.html));
  Frankt.channel.on("close_modal", (res) => Modal.close());
  Frankt.channel.on("activate_codemirror", (res) => CodeMirror.activate());
}

export default $(() => {
  const channel_tag = document.querySelector("meta[name=channel]");

  if (!channel_tag) return;

  const socket_params = {};
  Frankt.connect(channel_tag.content, socket_params)
    .receive("ok", res => {
      attachResponses();
    });
});

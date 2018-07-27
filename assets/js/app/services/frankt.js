import * as Frankt from "frankt";
import { serialize } from "frankt/priv/static/dom";

function attachResponses() {
  Frankt.channel.on("replace_with", (res) => $(res.target).trigger('dom-update', { source: 'frankt' }));
}

export default $(() => {
  const channel_tag = document.querySelector("meta[name=channel]");

  if (!channel_tag) return;

  const socket_params = {
    administrator_token: document.querySelector("meta[name=administrator_token]").content
  };
  Frankt.connect(channel_tag.content, socket_params)
    .receive("ok", res => {
      attachResponses();
    });
});

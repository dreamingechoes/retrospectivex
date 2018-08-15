import CodeMirror from "codemirror/lib/codemirror"
import "codemirror/mode/markdown/markdown"

export function activate(id) {
  if (document.getElementById(id) !== undefined) {
    let cm = CodeMirror.fromTextArea(document.getElementById(id), {
      styleActiveLine: true,
      mode: {
        name: "markdown",
        highlightFormatting: true
      },
      tabSize: 2,
      theme: "default"
    });

    cm.on("change", function (cm, change) {
      let original_textarea = document.getElementById(id);
      original_textarea.value = cm.getValue();
    });
  }
}

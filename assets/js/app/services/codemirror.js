import CodeMirror from "codemirror/lib/codemirror"
import "codemirror/mode/markdown/markdown"

export function activate() {
  if (document.getElementsByClassName("markdown").length > 0) {
    CodeMirror.fromTextArea(document.getElementsByClassName("markdown")[0], {
      styleActiveLine: true,
      mode: {
        name: "markdown",
        highlightFormatting: true
      },
      lineWrapping: true,
      tabSize: 2,
      theme: "default"
    });
  }
}

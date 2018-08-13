import CodeMirror from "codemirror/lib/codemirror"
import "codemirror/mode/markdown/markdown"

if (document.getElementsByClassName("markdown").length > 0) {
  CodeMirror.fromTextArea(document.getElementsByClassName("markdown")[0], {
    lineNumbers: true,
    styleActiveLine: true,
    mode: {
      name: "markdown",
      highlightFormatting: true
    },
    tabSize: 2,
    theme: "default"
  });
}

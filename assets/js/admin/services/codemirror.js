import CodeMirror from "codemirror/lib/codemirror"
import "codemirror/mode/markdown/markdown"

if (document.getElementsByClassName("markdown").length > 0) {
  CodeMirror.fromTextArea(document.getElementsByClassName("markdown")[0], {
    lineNumbers: true,
    styleActiveLine: true,
    matchBrackets: true,
    mode: {
      name: "markdown",
      highlightFormatting: true
    },
    lineWrapping: true,
    tabSize: 2,
    theme: "3024-day"
  });
}

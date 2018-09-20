import "phoenix_html"

// Vendor
import $ from "jquery"
import Popper from "popper.js"

import "popper.js/dist/umd/popper"
import "bootstrap/dist/js/bootstrap"
import "flatpickr/dist/flatpickr"

// Services
import "./services/frankt"
import * as Accordion from "./services/accordion"
import * as CodeMirror from "./services/codemirror"
import * as Datepicker from "./services/datepicker"

// Init accordion plugin if needed
Accordion.setup();

// Init datepicker plugin if needed
Datepicker.setup();

// Init codemirror plugin if needed
CodeMirror.activate("board_description");

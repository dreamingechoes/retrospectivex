import "phoenix_html"

// Vendor
import $ from "jquery"
import Popper from "popper.js"

import "popper.js/dist/umd/popper"
import "bootstrap/dist/js/bootstrap"
import "flatpickr/dist/flatpickr"
import "select2/dist/js/select2"

// Services
import "./services/frankt"
import * as Accordion from "./services/accordion"
import * as CodeMirror from "./services/codemirror"
import * as Datepicker from "./services/datepicker"
import * as Select2 from "./services/select2"

// Init accordion plugin if needed
Accordion.setup();

// Init datepicker plugin if needed
Datepicker.setup();

// Init codemirror plugin if needed
CodeMirror.activate("board_description");

// Init select2 plugin if needed
Select2.setup();

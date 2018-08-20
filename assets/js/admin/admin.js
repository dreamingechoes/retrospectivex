import "phoenix_html"

// Vendor
import $ from "jquery"
import Popper from "popper.js"

import "popper.js/dist/umd/popper"
import "bootstrap/dist/js/bootstrap"
import "flatpickr/dist/flatpickr"

// Services
import "./services/codemirror"
import * as Datepicker from "./services/datepicker"

// Init datepicker plugin if needed
Datepicker.setup();

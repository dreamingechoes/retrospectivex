import "phoenix_html"

// Vendor
import $ from "jquery"
import Popper from "popper.js"

import "popper.js/dist/umd/popper"
import "bootstrap/dist/js/bootstrap"

// Services
import "./services/frankt"
import * as Accordion from "./services/accordion"

// Init accordion plugin if needed
Accordion.setup();

import "phoenix_html"

// Vendor
import $ from "jquery"
import Popper from "popper.js"

import "popper.js/dist/umd/popper"
import "bootstrap/dist/js/bootstrap"

// Services
import "./services/frankt.js"
import * as Accordion from "./services/accordion.js";

// Init accordion plugin if needed
Accordion.setup();

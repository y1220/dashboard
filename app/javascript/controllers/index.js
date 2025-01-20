import { Application } from "@hotwired/stimulus";

console.log("Stimulus application started");

const application = Application.start();

// Manually import and register controllers
import DashboardController from "./dashboard_controller";
application.register("dashboard", DashboardController);

import BarchartController from "./barchart_controller";
application.register("barchart", BarchartController);

import LinechartController from "./linechart_controller";
application.register("multi-axis-chart", LinechartController);

export { application };

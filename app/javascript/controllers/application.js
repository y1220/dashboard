import { Application } from "@hotwired/stimulus-loading";

const application = Application.start();

// Configure Stimulus development experience
application.debug = false;
window.Stimulus = application;

export { application };

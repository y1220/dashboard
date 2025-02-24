// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import Rails from "@rails/ujs";
Rails.start();

import "bootstrap";
import "@hotwired/turbo-rails";
import "controllers";
import "chart.js";
import "@hotwired/turbo-rails"

console.log("Stimulus application started");

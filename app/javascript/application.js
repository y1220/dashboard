// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import Rails from "@rails/ujs";
Rails.start();

import "@hotwired/turbo-rails";
import "controllers";
import "chart.js";

console.log("Stimulus application started");

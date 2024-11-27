import { Controller } from "@hotwired/stimulus";
import { Chart } from "chart.js";

export default class extends Controller {
  static targets = ["retentionChart", "responseChart", "timingChart"];

  connect() {
    console.log("Dashboard controller connected");
    this.loadCharts();
  }

  async loadCharts() {
    console.log("Loading charts");
    const [communications, retentionRates, personalityTypes] =
      await Promise.all([
        this.fetchCommunications(),
        this.fetchRetentionRates(),
        this.fetchPersonalityTypes(),
      ]);

    this.initializeRetentionChart(retentionRates);
    this.initializeResponseChart(communications);
    this.initializeTimingChart();
  }

  async fetchCommunications() {
    const response = await fetch("/api/communications");
    return response.json();
  }

  async fetchRetentionRates() {
    const response = await fetch("/api/retention_rates");
    debugger;
    return response.json();
  }

  async fetchPersonalityTypes() {
    const response = await fetch("/api/personality_types");
    return response.json();
  }

  initializeRetentionChart(data) {
    new Chart(this.retentionChartTarget, {
      type: "line",
      data: {
        labels: [
          "Month 1",
          "Month 2",
          "Month 3",
          "Month 4",
          "Month 5",
          "Month 6",
        ],
        datasets: Object.entries(data).map(([type, rates]) => ({
          label: type,
          data: Object.values(rates),
          fill: false,
          tension: 0.1,
        })),
      },
      options: {
        responsive: true,
        scales: {
          y: {
            beginAtZero: true,
            max: 100,
          },
        },
      },
    });
  }
}

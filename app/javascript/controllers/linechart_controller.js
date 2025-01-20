// app/javascript/controllers/multi_axis_chart_controller.js
import { Controller } from "@hotwired/stimulus";
import { Chart, registerables } from "chart.js";
Chart.register(...registerables);

export default class extends Controller {
  static targets = ["multiAxisChart"];

  canvasContext() {
    return this.multiAxisChartTarget.getContext("2d");
  }

  connect() {
    fetch("/api/personality_types/patient_satisfaction")
      .then((response) => response.json())
      .then((data) => {
        new Chart(this.canvasContext(), {
          type: "line",
          data: {
            labels: data.months,
            datasets: [
              {
                label: "Overall Satisfaction (%)",
                data: data.overall_satisfaction,
                borderColor: "rgb(33, 150, 243)", // Blue
                backgroundColor: "rgba(33, 150, 243, 0.2)",
                yAxisID: "y",
                tension: 0.3,
              },
              {
                label: "Wait Time Satisfaction (%)",
                data: data.wait_time_satisfaction,
                borderColor: "rgb(76, 175, 80)", // Green
                backgroundColor: "rgba(76, 175, 80, 0.2)",
                yAxisID: "y1",
                tension: 0.3,
              },
              {
                label: "Care Quality Rating (%)",
                data: data.care_quality,
                borderColor: "rgb(255, 152, 0)", // Orange
                backgroundColor: "rgba(255, 152, 0, 0.2)",
                yAxisID: "y2",
                tension: 0.3,
              },
            ],
          },
          options: {
            responsive: true,
            interaction: {
              mode: "index",
              intersect: false,
            },
            stacked: false,
            plugins: {
              title: {
                display: true,
                text: "Patient Satisfaction Trends",
                font: {
                  size: 16,
                  weight: "bold",
                },
              },
              tooltip: {
                callbacks: {
                  label: function (context) {
                    return context.dataset.label + ": " + context.raw + "%";
                  },
                },
              },
            },
            scales: {
              y: {
                type: "linear",
                display: true,
                position: "left",
                title: {
                  display: true,
                  text: "Overall Satisfaction (%)",
                },
                min: 0,
                max: 100,
              },
              y1: {
                type: "linear",
                display: true,
                position: "right",
                title: {
                  display: true,
                  text: "Wait Time Satisfaction (%)",
                },
                min: 0,
                max: 100,
                grid: {
                  drawOnChartArea: false,
                },
              },
              y2: {
                type: "linear",
                display: true,
                position: "right",
                title: {
                  display: true,
                  text: "Care Quality Rating (%)",
                },
                min: 0,
                max: 100,
                grid: {
                  drawOnChartArea: false,
                },
              },
            },
          },
        });
      })
      .catch((error) => console.error("Error fetching data:", error));
  }
}

import { Controller } from "@hotwired/stimulus"
import { Chart } from "chart.js";
import * as Chartjs from "chart.js";

const controllers = Object.values(Chartjs).filter(
  (chart) => chart.id !== undefined
);
Chart.register(...controllers);

// Connects to data-controller="chart"
export default class extends Controller {
  static values = { myLoveLanguage: String, partnerLoveLanguage: String }
  static targets = ["myChart", "partnerChart"]

  connect() {

    if (this.hasMyLoveLanguageValue) {
      const myJson = JSON.parse(this.myLoveLanguageValue)

      const myData = {
        labels: Object.keys(myJson),
        datasets: [{
          label: 'My Stats',
          data: Object.values(myJson),
          fill: true,
          backgroundColor: 'rgba(255, 99, 132, 0.2)',
          borderColor: 'rgb(255, 99, 132)',
          pointBackgroundColor: 'rgb(29, 31, 243)',
          pointBorderColor: '#fff',
          pointHoverBackgroundColor: '#fff',
          pointHoverBorderColor: 'rgb(255, 99, 132)'
        }]
      };

      const config = {
        type: 'radar',
        data: myData,
        options: {
          elements: {
            line: {
              borderWidth: 3
            }
          }, plugins: {
            legend: {
              display: false,
            }
          },
          scales: {
            r: {
              angleLines: {
                display: false
              },
              suggestedMin: 0
            }
          }
        },
      };

      new Chart(this.myChartTarget, config);
    }

    if (this.hasPartnerLoveLanguageValue) {
      const partnerJson = JSON.parse(this.partnerLoveLanguageValue)

      const partnerData = {
        labels: Object.keys(partnerJson),
        datasets: [{
          data: Object.values(partnerJson),
          fill: true,
          backgroundColor: 'rgba(29, 31, 243, 0.1)',
          borderColor: 'rgb(29, 31, 243)',
          pointBackgroundColor: 'rgb(255, 99, 132)',
          pointBorderColor: '#fff',
          pointHoverBackgroundColor: '#fff',
          pointHoverBorderColor: 'rgb(255, 99, 132)'
        }]
      };

      const partnerConfig = {
        type: 'radar',
        data: partnerData,
        options: {
          elements: {
            line: {
              borderWidth: 3
            },
          },
          plugins: {
            legend: {
              display: false
            }
          },
          scales: {
            r: {
              angleLines: {
                display: false
              },
              suggestedMin: 0
            }
          }
        },
      };

      new Chart(this.partnerChartTarget, partnerConfig);
    }
  }
}

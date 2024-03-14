import { Controller } from "@hotwired/stimulus"
import { Chart } from "chart.js";
import * as Chartjs from "chart.js";

const controllers = Object.values(Chartjs).filter(
  (chart) => chart.id !== undefined
);
Chart.register(...controllers);

// Connects to data-controller="chart"
export default class extends Controller {
  static values = {myLoveLanguage: String, partnerLoveLanguage: String}
  static targets = ["myChart", "partnerChart"]

  connect() {

    if (this.hasMyLoveLanguageValue){
      const myJson = JSON.parse(this.myLoveLanguageValue)


      const myData= {
        labels: Object.keys(myJson),
        datasets: [{
          label: 'My First Dataset',
          data: Object.values(myJson),
          fill: true,
          backgroundColor: 'rgba(255, 99, 132, 0.2)',
          borderColor: 'rgb(255, 99, 132)',
          pointBackgroundColor: 'rgb(255, 99, 132)',
          pointBorderColor: '#fff',
          pointHoverBackgroundColor: '#fff',
          pointHoverBorderColor: 'rgb(255, 99, 132)'
        }
      ]
      };

      const config = {
        type: 'radar',
        data: myData,
        options: {
          elements: {
            line: {
              borderWidth: 3
            }
          },
          scales: {
            r: {
                angleLines: {
                    display: false
                },
                suggestedMin: 1,
                suggestedMax: 10
            }
        }
        },
      };

      new Chart(this.myChartTarget, config);
    }

        console.log(this.partnerLoveLanguageValue)
    if (this.hasPartnerLoveLanguageValue)
    {
      const partnerJson = JSON.parse(this.partnerLoveLanguageValue)
      const partnerData = {
        labels: Object.keys(partnerJson),
        datasets: [{
          label: 'My First Dataset',
          data: Object.values(partnerJson),
          backgroundColor: [
            'rgb(255, 99, 132)',
            'rgb(75, 192, 192)',
            'rgb(255, 205, 86)',
            'rgb(201, 203, 207)',
            'rgb(54, 162, 235)'
          ]
        }]
      };

      const partnerConfig = {
        type: 'polarArea',
        data: partnerData,
        options: {}
      };

      new Chart(this.partnerChartTarget, partnerConfig);
    }
  }
}

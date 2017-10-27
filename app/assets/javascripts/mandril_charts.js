function ready(){
  function cylinder(r, h) {
    var at = 2*(3.14*r**2) + 2*(3.14*r*h);
    return at;
  }

  function plotGraph(radius, length) {

    var ctx = document.getElementById("mandril").getContext('2d');

    if (radius === '' || length === '') {
      var myLineChart = new Chart(ctx, {});
      myLineChart.destroy();
      return;
    }

    var area = cylinder(radius, length);

    var myLineData = {
      labels: ["", "", "Area", "", ""],
      datasets: [{
        label: "Area",
        backgroundColor: "#bdbdbd",
        data: [null, area, area, area, null]
      }]
    }
    var myLineChart = new Chart(ctx, {
        type: 'line',
        data: myLineData,
        options: {
          scales: {
              yAxes: [{
                ticks: {
                  min: (parseInt((0 - area/2)/100 ).toFixed(0)) * 100 - 100,
                  max: (parseInt((area + area/2)/100 ).toFixed(0)) * 100 + 100
                }
              }]
          }
        }
    });
  }
  var graphContainer = document.getElementById("graph-container")
  if (graphContainer != null){
    var length = document.getElementById("length").dataset.length
    var radius = document.getElementById("radius").dataset.radius
    plotGraph(radius, length)
  }
}

$(document).on("turbolinks:load", ready)

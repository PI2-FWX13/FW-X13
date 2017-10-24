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
      labels: ["","Area"],
      datasets: [{
        label: "Arroz",
        backgroundColor: "rgba(0,255,0,1)",
        data: [area, area]
      }]
    }

    var myLineChart = new Chart(ctx, {
        type: 'line',
        data: myLineData,
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

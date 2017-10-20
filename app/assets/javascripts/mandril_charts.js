$(document).ready(function() {

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

var lengthInput = document.getElementById("lengthInput");
var radiusInput = document.getElementById("radiusInput");


lengthInput.addEventListener("input", function(){
  var radius = radiusInput.value;
  plotGraph(radius, this.value);
});

radiusInput.addEventListener("input", function() {
  var length = lengthInput.value;
  plotGraph(this.value, length);
});

})

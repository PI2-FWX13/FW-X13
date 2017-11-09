function getTemperature(){
  $.ajax({
    type:"GET",
    url:"gettemperature",
    dataType:"json",
    //data: {some_parameter: 'hello'},
    success:function(result){
      $('#temperature').text(result);
    }
  });
}

getTemperature();
setInterval(function(){
    getTemperature();
},3000);


function startCamera() {
  console.log('startCamera');
  $.ajax({
    type:"GET",
    url:"startCamera",
    dataType:"json",
    //data: {some_parameter: 'hello'},
    success:function(result){
      $('start-camera-btn').text(result)
    }
  })
}
function stopCamera() {
  console.log('stopCamera');
  $.ajax({
    type:"GET",
    url:"stopCamera",
    dataType:"json",
    //data: {some_parameter: 'hello'},
    success:function(result){
      $('stop-camera-btn').text(result)
    }
  })
}

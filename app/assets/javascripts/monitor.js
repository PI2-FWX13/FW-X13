function getTemperature(){
  $.ajax({
    type:"GET",
    url:"gettemperature",
    dataType:"json",
    //data: {some_parameter: 'hello'},
    success:function(result){
      $('#temperature').text(result)
    }
  })
}

getTemperature();
setInterval(function(){
    getTemperature()
},3000)

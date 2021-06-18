$.ajax({
	url: 'Pie_chart3',
	success: function(result){
	console.log(result);
	var series = [];
	var data = [];
	for(var i=0; i< result.length; i++){
		var object = {};
		object.name = result[i].titre_projet;
		object.y = 	result[i].percent_complete;
		data.push(object);	
	}
	var seriesObject = {
		name: 'Pourcentage',
		colorByPoint: true,
		data: data
	}	
	series.push(seriesObject);
		drawPieChart3(series);
	}
});

$.ajax({
	url: 'Pie_chart3',
	success: function(result){
	console.log(result);
	var series = [];
	var data = [];
	for(var i=0; i< result.length; i++){
		var object = {};
		object.name = result[i].titre_projet;
		object.y = 	result[i].percent_complete;
		data.push(object);	
	}
	var seriesObject = {
		name: 'Pourcentage',
		colorByPoint: true,
		data: data
	}	
	series.push(seriesObject);
		drawPieChart4(series);
	}
});

$.ajax({
	url: 'Pie_chart6',
	success: function(result){
	console.log(result);
	var series = [];
	var data = [];
	for(var i=0; i< result.length; i++){
		var object = {};
		object.name = result[i].titre_projet;
		object.y = 	result[i].percent_complete;
		data.push(object);	
	}
	var seriesObject = {
		name: 'Pourcentage',
		colorByPoint: true,
		data: data
	}	
	series.push(seriesObject);
		drawPieChat5(series);
	}
});

$.ajax({
	url: 'Pie_chart8',
	success: function(result){
	console.log(result);
	var series = [];
	var data = [];
	for(var i=0; i< result.length; i++){
		var object = {};
		object.name = result[i].titre_tache;
		object.y = 	result[i].percent_complete;
		data.push(object);	
	}
	var seriesObject = {
		name: 'Pourcentage',
		colorByPoint: true,
		data: data
	}	
	series.push(seriesObject);
		drawPieChart8(series);
	}
});

 function drawPieChart3(series){
 		Highcharts.chart('container2', {
    chart: {
        plotBackgroundColor: null,
        plotBorderWidth: null,
        plotShadow: false,
        type: 'pie'
    },
    title: {
        text: 'Graphe des projets en Pourcentage'
    },
    tooltip: {
        pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
    },
    accessibility: {
        point: {
            valueSuffix: '%'
        }
    },
    plotOptions: {
        pie: {
            allowPointSelect: true,
            cursor: 'pointer',
            dataLabels: {
                enabled: true,
                format: '<b>{point.name}</b>: {percentage:.1f}%</b>'
            }
        }
    },
    series: series
});
 } 
 
 function drawPieChart4(series){
 Highcharts.chart('container3', {
    chart: {
        type: 'column'
    },
    title: {
        text: 'Graphe des projets en pourcentage'
    },
     accessibility: {
        announceNewData: {
            enabled: true
        }
    },
  	 xAxis: {
        type: 'category'
    },
    yAxis: {
        title: {
            text: 'Projets en pourcentage'
        }
    },
    legend: {
        enabled: false
    },
 	plotOptions: {
        series: {
            borderWidth: 0,
            dataLabels: {
                enabled: true,
                format: '{point.y}%'
            }
        }
    },

    tooltip: {
        headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
        pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y}%</b><br/>'
    },

    series: series
});
            }
 
  function drawPieChart8(series){
 Highcharts.chart('container8', {
    chart: {
        type: 'column'
    },
    title: {
        text: 'Tasks en pourcentage'
    },
     accessibility: {
        announceNewData: {
            enabled: true
        }
    },
  	 xAxis: {
        type: 'category'
    },
    yAxis: {
        title: {
            text: 'Tasks en pourcentage'
        }
    },
    legend: {
        enabled: false
    },
 	plotOptions: {
        series: {
            borderWidth: 0,
            dataLabels: {
                enabled: true,
                format: '{point.y}%'
            }
        }
    },

    tooltip: {
        headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
        pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y}%</b><br/>'
    },

    series: series
});
            }
 
  function drawPieChat5(series){
 Highcharts.chart('container5', {
    chart: {
        type: 'column'
    },
    title: {
        text: 'Graphe des projets en pourcentage'
    },
     accessibility: {
        announceNewData: {
            enabled: true
        }
    },
  	 xAxis: {
        type: 'category'
    },
    yAxis: {
        title: {
            text: 'Projets en pourcentage'
        }
    },
    legend: {
        enabled: false
    },
 	plotOptions: {
        series: {
            borderWidth: 1,
            dataLabels: {
                enabled: true,
                format: '{point.y}%'
            }
        }
    },

    tooltip: {
        headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
        pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y}%</b><br/>'
    },

    series: series
});
            }
 
 
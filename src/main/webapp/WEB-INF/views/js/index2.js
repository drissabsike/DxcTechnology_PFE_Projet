$.ajax({
	url: 'Pie_chart2',
	success: function(result){
		var Titre_projet = JSON.parse(result).Titre_projet;
		var Percent_complete = JSON.parse(result).Percent_complete;
		drawLineChart(Titre_projet, Percent_complete);
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


function drawLineChart(Titre_projet, Percent_complete){
	Highcharts.chart('containerx', {
	    chart: {
	        type: 'line',
	        width: 900
	    },
	    
	    title: {
	        text: 'Graphe des projets en pourcentage'
	    },
	
	    xAxis: {
	        categories: Titre_projet
	    },
	    
	    tooltip: {
	        formatter: function() {
	          return '<strong>'+this.x+': </strong>'+ this.y+'%';
	        }
	    },
	
	    series: [{
	        data: Percent_complete
	    }]
	});
}

 function drawPieChart3(series){
 		Highcharts.chart('container2', {
    chart: {
        plotBackgroundColor: null,
        plotBorderWidth: null,
        plotShadow: false,
        type: 'pie'
    },
    title: {
        text: 'Cas de coronavirus au maroc par region 2020'
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
                format: '<b>{point.name}</b>: {point.percentage:.1f} %</b>'
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
        text: 'World\'s largest cities per 2017'
    },
    subtitle: {
        text: 'Source: Test'
    },
    xAxis: {
        type: 'category',
        labels: {
            rotation: -45,
            style: {
                fontSize: '13px',
                fontFamily: 'Verdana, sans-serif'
            }
        }
    },
    yAxis: {
        min: 0,
        title: {
            text: 'Projets en pourcentage'
        }
    },
    legend: {
        enabled: false
    },
 	plotOptions: {
        pie: {
            allowPointSelect: true,
            cursor: 'pointer',
            dataLabels: {
                enabled: true,
                format: '<b>{point.name}</b>: {point.percentage:.1f} %</b>'
            }
        }
    },
    series: series
});
            }
 
 
 
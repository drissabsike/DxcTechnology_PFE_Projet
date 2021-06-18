$.ajax({
	url: 'Pie_chart',
	success: function(result){
		var Titre_tache = JSON.parse(result).Titre_tache;
		var emp_nom = JSON.parse(result).emp_nom;
		var Percent_complete = JSON.parse(result).Percent_complete;
		drawLineChart(Titre_tache, Percent_complete);
	}
});

function drawLineChart(Titre_tache, Percent_complete){
	Highcharts.chart('container', {
	    chart: {
	        type: 'line',
	        width: 900
	    },
	    
	    title: {
	        text: 'Graphe des Taches en pourcentage'
	    },
	
	    xAxis: {
	        categories: Titre_tache
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
 
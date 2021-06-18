<%@page import="java.sql.Date"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"><html>
<head>
<meta charset="ISO-8859-1">
<title>ADMIN Dashboard</title>
<link rel="stylesheet" type="text/css" href="/webjars/bootstrap/css/bootstrap.min.css">
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<style><%@ include file="/WEB-INF/views/MANAGER/css/Styledash.css"%></style>
<script type="text/javascript"><%@ include file="/WEB-INF/views/MANAGER/file.js/dash.js"%></script>
<script type="text/javascript"><%@ include file="/WEB-INF/views/MANAGER/js/highcharts.js"%></script>
<script type="text/javascript"><%@ include file="/WEB-INF/views/MANAGER/js/index.js"%></script>
<script type="text/javascript"><%@ include file="/WEB-INF/views/MANAGER/js/index2.js"%></script>
<script type="text/javascript">
	google.charts.load('current', {'packages':['timeline']});
	google.charts.load('current', {
		  packages:['gantt']
		}).then(function () {
    google.charts.setOnLoadCallback(drawChart);
	function drawChart() {
	  var data = new google.visualization.DataTable();
	  var container = document.getElementById('chart_div');
      var chart = new google.visualization.Gantt(container);
      //var chart = new google.visualization.Timeline(container);
      
      data.addColumn('string', 'Task ID');
      data.addColumn('string', 'Task Name');
      data.addColumn('string', 'Client');
      data.addColumn('date', 'Start Date');
      data.addColumn('date', 'End Date');
      data.addColumn('number', 'Duration');
      data.addColumn('number', 'Percent Complete');
      data.addColumn('string', 'Dependencies');
      <%
      String nom = (String) session.getAttribute("nom1");
      String prenom = (String) session.getAttribute("prenom1");
      	Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/stage?serverTimezone=UTC","root","");
		String req="SELECT * FROM taches WHERE emp_nom = concat('"+nom+"',' ','"+prenom+"') ";
		PreparedStatement ps = con.prepareStatement(req);
		ResultSet rs = ps.executeQuery();
		while(rs.next()) { 
		String id_tache = rs.getString("id_tache");
		String titre_tache = rs.getString("titre_tache");
		String types_tache = rs.getString("types_tache");
		Date date_debut = rs.getDate("date_debut");
		Date date_max = rs.getDate("date_max");
		int percent_complete = rs.getInt("percent_complete");
		%>
		var pr ="<%=percent_complete%>";
		var titre_tache ="<%=titre_tache%>";
		var id_tache="<%=id_tache%>";
		var types_tache="<%=types_tache%>";
		var pr2 = parseInt(pr);
		var date_debut="<%=date_debut%>";
		var date_max="<%=date_max%>";
		
	 data.addRows([
		 [id_tache, titre_tache+" ("+pr2+"%)", types_tache,
	         new Date(date_debut), new Date(date_max), null, pr2, null]
		 ]);
	  var dataTableGroup = google.visualization.data.group(data, [0]);
	  var dateRangeStart = data.getColumnRange(3);
	  var dateRangeEnd = data.getColumnRange(4);
	  var formatDate = new google.visualization.DateFormat({
	    pattern: 'dd/MM/yyyy'
	  });

	 function drawChart() {
	    chart.draw(data, options);
	  }

	  function addMarker(markerDate) {
		    var baseline;
		    var baselineBounds;
		    var chartElements;
		    var markerLabel;
		    var markerLine;
		    var markerSpan;
		    var svg;
		    var timeline;
		    var timelineUnit;
		    var timelineWidth;
		    var timespan;

		    baseline = null;
		    timeline = null;
		    svg = null;
		    markerLabel = null;
		    chartElements = container.getElementsByTagName('svg');
		    if (chartElements.length > 0) {
		      svg = chartElements[0];
		    }
		    chartElements = container.getElementsByTagName('rect');
		    if (chartElements.length > 0) {
		      timeline = chartElements[0];
		    }
		    chartElements = container.getElementsByTagName('path');
		    if (chartElements.length > 0) {
		      baseline = chartElements[0];
		    }
		    chartElements = container.getElementsByTagName('text');
		    if (chartElements.length > 0) {
		      markerLabel = chartElements[0].cloneNode(true);
		    }
		    if ((svg === null) || (timeline === null) || (baseline === null) || (markerLabel === null) ||
		        (markerDate.getTime() < dateRangeStart.min.getTime()) ||
		        (markerDate.getTime() > dateRangeEnd.max.getTime())) {
		      return;
		    }

		    // calculate placement
		    timelineWidth = parseFloat(timeline.getAttribute('width'));
		    baselineBounds = baseline.getBBox();
		    timespan = dateRangeEnd.max.getTime() - dateRangeStart.min.getTime();
		    timelineUnit = (timelineWidth - baselineBounds.x) / timespan;
		    markerSpan = markerDate.getTime() - dateRangeStart.min.getTime();

		    // add label
		    markerLabel.setAttribute('fill', '#e91e63');
		    markerLabel.setAttribute('y', options.height);
		    markerLabel.setAttribute('x', (baselineBounds.x + (timelineUnit * markerSpan) - 4));
		    markerLabel.textContent = formatDate.formatValue(markerDate);
		    svg.appendChild(markerLabel);

		    // add line
		    markerLine = timeline.cloneNode(true);
		    markerLine.setAttribute('y', 0);
		    markerLine.setAttribute('x', (baselineBounds.x + (timelineUnit * markerSpan)));
		    markerLine.setAttribute('height', options.height);
		    markerLine.setAttribute('width', 1);
		    markerLine.setAttribute('stroke', 'none');
		    markerLine.setAttribute('stroke-width', '0');
		    markerLine.setAttribute('fill', '#e91e63');
		    svg.appendChild(markerLine);
		  }
		  
	 
	 <% } %>	
	 var rowHeight = 43;
	 var options = {
          	//height: 1500,
          	height: (dataTableGroup.getNumberOfRows() * rowHeight) + rowHeight,
          	  gantt: {
              	criticalPathStyle: {
                      stroke: '#000000',
                      strokeWidth: 5
                    },
              	 labelStyle: {
              		    color: '#000000',
              	        fontSize: 18
              	                	      },
            	       trackHeight: 45,
                       innerGridTrack: {fill: '#FFFFE0'},
              	       innerGridDarkTrack: {fill: '#FFFFE0'}
              	       }
              	    };
	 
      google.visualization.events.addListener(chart, 'ready', afterDraw);
      
		function afterDraw() {
          var g = document.getElementsByTagName("svg")[0].getElementsByTagName("g")[1];
          document.getElementsByTagName("svg")[0].parentNode.style.top = '35px';
          document.getElementsByTagName("svg")[0].style.overflow = 'visible';
          var height = Number(g.getElementsByTagName("text")[0].getAttribute('y')) + 25;
          g.setAttribute('transform','translate(0,-'+height+')');
          g = null;
        }

      var observer = new MutationObserver(function () {
        $.each($('text'), function (index, label) {
          var rowIndex = data.getFilteredRows([{
            column: 1,
            value: $(label).text()
          }]);
          if (rowIndex.length > 0) {
            $(label).attr('fill', '#000')
          }
        });
      });
      observer.observe(container, {
        childList: true,
        subtree: true
      });
      //var chart = new google.visualization.Gantt(document.getElementById('chart_div'));
      google.visualization.events.addListener(chart, 'ready', function () {
    	    // add marker for current date
    	    addMarker(new Date());
    	  });

    	  window.addEventListener('resize', drawChart, false);
    	  drawChart();

    }
		});
  </script>
</head>  
<body>
<div id="throbber" style="display:none; min-height:120px;"></div>
<div id="noty-holder"></div>
<div id="wrapper">
    <!-- Navigation -->
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
       <!-- Top Menu Items -->
        <ul class="nav navbar-right top-nav">
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                 <img src="/${image_profile}" height="80px" width="80px" style="border-radius: 50%;">
                Employe ${nom1} <b class="fa fa-angle-down"></b></a>
                <ul class="dropdown-menu">
                    <li ><a href="doLogout"><i class="fa fa-power-off"></i>Logout</a></li>
                </ul>
            </li>
        </ul>
        <!-- Sidebar Menu Items - These collapse to the responsive navigation menu on small screens -->
        <div class="collapse navbar-collapse navbar-ex1-collapse">
            <ul class="nav navbar-nav side-nav">
            	<li><a href="DashboardEmp"><img width="200px" height="90px" src="https://assets1.dxc.technology/newsroom/images/dxc_logo_hz_wht_rgb-XXSML.png">
                    </a><a href="DashboardEmp?nom=${nom1}&prenom=${prenom1}"><i class="fa fa-fw fa-star"></i>Employe Dashboard</a>
                </li>
                <li>
                    <a href="ListTaches2"><i class="fa fa-tasks" aria-hidden="true"></i>&nbsp;Liste des Taches</a>
                </li>
                <li>
                    <a href="#"><i class="fa fa-tasks" aria-hidden="true"></i>&nbsp;Gestion d'absence</a>
                </li>
            </ul>
        </div>
    </nav><br><br>
    <div id="page-wrapper">
        <div class="container-fluid">
            <div class="row" id="main" >
                <div class="col-sm-12 col-md-12 well" id="content">
                    <div class="logo" style="text-align: center;"><img src="https://assets1.dxc.technology/newsroom/images/dxc_logo_hz_blk_rgb-XXSML.png"
        			width="30%" height="40%">
        			</div>
                </div>
            </div>
        </div>
    </div>
     <center>
    <div class="card text-center"> <strong>Tasks Gantt</strong>
  <div class="card text-center" style="height: 250px; overflow-y: auto">
  <div class="card-body">
     <div id="chart_div" style="margin-right: 120px;"></div>
  </div>
</div></div></center>
<div id="container8" style="height: 400px; width:90%;"></div><br>
</div>
</body>
</html>
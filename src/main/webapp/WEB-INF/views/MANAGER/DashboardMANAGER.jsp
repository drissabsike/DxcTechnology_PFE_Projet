<%@page import="java.sql.Date"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="ISO-8859-1">
<title>Manager Dashboard</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<link rel="stylesheet" type="text/css" href="/webjars/bootstrap/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<style><%@ include file="/WEB-INF/views/MANAGER/css/Styledash.css"%></style>
<script type="text/javascript"><%@ include file="/WEB-INF/views/MANAGER/file.js/dash.js"%></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/dom-to-image/2.6.0/dom-to-image.js"></script>
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
      	String cin = (String) session.getAttribute("cin");
      	
      	Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/stage?serverTimezone=UTC","root","");
		String req="SELECT * FROM projets WHERE cin_manager = '"+cin+"' AND etat_projet='Non_Annuler' ";
		PreparedStatement ps = con.prepareStatement(req);
		ResultSet rs = ps.executeQuery();
		while(rs.next()) { 
		String id_projet = rs.getString("id_projet");
		String titre_projet = rs.getString("titre_projet");
		String client = rs.getString("client");
		Date date_debut = rs.getDate("date_debut");
		Date date_fin = rs.getDate("date_fin");
		int percent_complete = rs.getInt("percent_complete");
		%>
		var pr ="<%=percent_complete%>";
		var client ="<%=client%>";
		var cin ="<%=cin%>";
		var id_projet="<%=id_projet%>";
		var titre_projet="<%=titre_projet%>";
		var pr2 = parseInt(pr);
		var date_debut="<%=date_debut%>";
		var date_fin="<%=date_fin%>";
		
	 data.addRows([
		 [id_projet, titre_projet+" ("+pr2+"%)", client,
	         new Date(date_debut), new Date(date_fin), null, pr2, null]
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
                <img height="80px" width="80px" style="border-radius: 50%;" src="/${image_profile}">
                Manager ${nom1} 
                <b class="fa fa-angle-down"></b></a>
                <ul class="dropdown-menu">
                    <li ><a href="doLogout"><i class="fa fa-power-off"></i>Logout</a></li>
                </ul>
            </li>
        </ul>
        <!-- Sidebar Menu Items - These collapse to the responsive navigation menu on small screens -->
         <div class="collapse navbar-collapse navbar-ex1-collapse">
            <ul class="nav navbar-nav side-nav">
            	<li>
            		<a href="DashboardMANAGER"><img width="220px" height="90px" src="https://assets1.dxc.technology/newsroom/images/dxc_logo_hz_wht_rgb-XXSML.png">
                    </a><a href="DashboardMANAGER"><i class="fa fa-fw fa-star"></i>Dashboard</a>
                </li>
                <li>
                    <a href="#" data-toggle="collapse" data-target="#submenu-1"><i class="fa fa-th-list"></i>&nbsp;Projets <i class="fa fa-fw fa-angle-down pull-right"></i></a>
                    <ul id="submenu-1" class="collapse">
                        <li><a href="ListProjets"><i class="fa fa-th-list"></i>&nbsp;Liste projets</a></li>
                        <li><a href="ListProjets_annuler"><i class="fa fa-th-list"></i>&nbsp;Liste projets Annuler</a></li>
                        <li><a href="NouvProjet"><i class="fa fa-plus"></i>&nbsp;Cree un Projet</a></li>
                    </ul>
                </li>
                <li><a href="ListClients"><i class="fa fa-building"></i>&nbsp;Clients</a>
                </li>
                <li>
                    <a href="#" data-toggle="collapse" data-target="#submenu-2"><i class="fa fa-users"></i>&nbsp;Equipes<i class="fa fa-fw fa-angle-down pull-right"></i></a>
                    <ul id="submenu-2" class="collapse">
                        <li><a href="/Equipe/ListEquipe"><i class="fa fa-th-list"></i>&nbsp;Liste des équipes</a></li>
                        <li><a href="/Equipe/ListAllMember"><i class="fa fa-list"></i>&nbsp;Liste des Employes</a></li>
                        <li><a href="/Equipe/NewTeams"><i class="fa fa-plus"></i>&nbsp;Créé une Equipe</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#" data-toggle="collapse" data-target="#submenu-3"><i class="fa fa-spinner"></i>&nbsp;Workload<i class="fa fa-fw fa-angle-down pull-right"></i></a>
                    <ul id="submenu-3" class="collapse">
                        <li><a href="PlanCharge"><i class="fa fa-tasks"></i>&nbsp;Plan des Charges</a></li>
                    	<li><a href="#"><i class="fa fa-list-alt" aria-hidden="true"></i>&nbsp;Plan d'absence</a></li>
                    </ul>
                  </li>
                <li>
                    <a href="Profile?cin=${cin}&nom1=$ ${nom1}&prenom1= ${prenom1}"><i class="fa fa-cog" aria-hidden="true"></i>&nbsp;Setting</a>
                </li>
                <li>
                    <a href="#"><i class="fa fa-money" aria-hidden="true"></i>&nbsp;Facturation</a>
                </li>
            </ul>
        </div>
    </nav><br><br><br>
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
</div>
<div class="content">
        <div class="container-fluid">
          <div class="row">
            <div class="col-lg-2 col-md-6 col-sm-6"  style="margin-left: 350px;">
              <div class="card card-stats">
                <div class="card-header card-header-success card-header-icon">
                  <div class="card-icon">
                    <img height="100px" width="100px" class="center" src="https://image.flaticon.com/icons/png/128/762/762631.png">
                  </div>
                  <h3 class="material-icons">Projets ${nbrP}</h3>
                </div>
              </div>
            </div>
            <div class="col-lg-2 col-md-6 col-sm-6" style="margin-left: 40px;">
              <div class="card card-stats">
                <div class="card-header card-header-danger card-header-icon">
                  <div class="card-icon">
                    <img height="100px" width="100px" class="center"  src="https://image.flaticon.com/icons/png/128/912/912267.png">
                  </div>
                  <h3 class="card-title">Employees ${nbrE}</h3>
                </div>
              </div>
            </div>
            <div class="col-lg-2 col-md-6 col-sm-6" style="margin-left: 40px;">
              <div class="card card-stats">
                <div class="card-header card-header-info card-header-icon">
                  <div class="card-icon">
                    <img height="100px" width="100px" class="center"  src="https://image.flaticon.com/icons/png/128/2098/2098402.png">	
                  </div>
                  <h3 class="card-title">Tasks ${nbt}</h3>
                </div>
              </div>
            </div>
            <div class="col-lg-2 col-md-6 col-sm-6" style="margin-left: 40px;">
              <div class="card card-stats">
                <div class="card-header card-header-info card-header-icon">
                  <div class="card-icon"> 
                  <img height="100px" width="100px" class="center" src="https://image.flaticon.com/icons/png/128/2489/2489934.png">
                  </div>
                  <h3 class="card-title">Financement ${sumP}DH</h3>
                </div>
              </div>
            </div>
          </div>
          </div>
          </div><br><br>
            <center>
    <div class="card text-center"> <strong>Gantt des Projets</strong>
  <div class="card text-center" style="height: 450px; overflow-y: auto">
  <div class="card-body">
     <div id="chart_div" style="margin-left: 280px;margin-right: 30px;"></div>
  </div>
</div></div></center> <br><br>
  <div style="margin-left: 370px;">
            <div id="container3" style="height: 400px; width:90%;"></div></div><br>
            <div class="col-lg-9 col-md-5" style="margin-left: 18%;">
              <div class="card">
                <div class="card-header card-header-warning">
                  <h4 class="card-title">Liste des Employees</h4>
                </div>
                <div class="card-body table-responsive" style="height: 300px; overflow-y: auto;">
                  <table class="table table-hover">
                    <thead class="thead-dark">
                      <th>Employe</th>
                      <th>Experiance</th>
                      <th>Titre</th>
                      <th>Integrer le:</th>
                    </thead>
                    <tbody>
                      <c:forEach items="${listU}" var="user">
                      <tr>
                      	<td><img src="/${user.image_path}" style="border-radius: 50%;" height="50" width="50"> &nbsp;&nbsp;${user.nom} ${user.prenom}</td>
                        <td>${user.experiance}</td>
                        <td>${user.titre}</td>
                        <td>${user.date_creation}</td>
                      </tr>
                      </c:forEach>
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
           <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> <br> 
  <footer class="footer"> 
 <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.2);">
    © 2021 Copyright: DXC Technology
  </div>
 </footer>       
</body>
</html>

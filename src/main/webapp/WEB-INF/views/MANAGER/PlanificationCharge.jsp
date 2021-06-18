<%@page import="java.sql.Date"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Manager Dashboard</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.7.2/main.min.css">
<link rel="stylesheet" type="text/css" href="/webjars/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.7.2/main.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/2.9.1/lang-all.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<style><%@ include file="/WEB-INF/views/MANAGER/css/Styledash.css"%></style>
<style><%@ include file="/WEB-INF/views/MANAGER/css/t2.css"%></style>
</head>  
<%
	if(session.getAttribute("nom1")==null){
		response.sendRedirect("loginPage");
	}
%>
<script>
 document.addEventListener('DOMContentLoaded', function() {
	    var calendarEl = document.getElementById('calendar');
	    <%
	    Long id =(Long) session.getAttribute("key");
	    Class.forName("com.mysql.jdbc.Driver");
	    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/stage?serverTimezone=UTC","root","");
		String req="SELECT emp_nom,duree_t,date_debut,titre_tache,date_max,DATEDIFF(date_max, date_debut) AS days FROM taches where id_tache="+id;
		PreparedStatement ps = con.prepareStatement(req);
		ResultSet rs = ps.executeQuery();
		while(rs.next()) { 
		String emp_nom = rs.getString("emp_nom");
		Date date_debut = rs.getDate("date_debut");
		Date date_max = rs.getDate("date_max");
		int duree_t = rs.getInt("duree_t");
		int days = rs.getInt("days");
		String titre_tache = rs.getString("titre_tache");
		%>
		var titre_tache="<%=titre_tache%>";
		var duree_t ="<%=duree_t%>";
		var emp_nom ="<%=emp_nom%>";
		var date_debut="<%=date_debut%>";
		var date_max="<%=date_max%>";
		var days="<%=days%>";

		  var calendar = new FullCalendar.Calendar(calendarEl, {
		  locale: "fr",
		  initialView: 'dayGridMonth',
	      initialDate: date_debut,
	      headerToolbar: {
	        center: ''
	      },
	      events: [
	        {
	          title: emp_nom+": Charge/Jour: "+duree_t+"h, Task: "+titre_tache,
	          start: date_debut,
	          end: date_max,
	          rendering: 'background',
              color: '#A9A9A9',
              textColor: 'black'
	        }
	      ]
		});
		  var total = parseInt(duree_t)*parseInt(days);
	    <% } %>		
	    calendar.render();
	    $('#nom').html(emp_nom)
	    $('#td1').html(duree_t+"h")
	    $('#jours').html(days+"jours")
	    $('#Total').html(total+"h")
 });
    </script>	
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
                <li><a href="ListClients"><i class="fa fa-building"></i>&nbsp;Clients</a></li>
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
    </nav><br><br><br><br>
				<div id='calendar'></div><br>
   <aside style="font: 20px Calibri;">
<div>
<table style="width: 40%;">
  <tr>
    <th>Recource</th>
    <th>Charge/Jour</th>
    <th>Nomber des jours</th>
    <th>Total</th>
  </tr>
  <tr>
    <td id="nom"></td>
    <td id="td1"></td>
    <td id="jours"></td>
    <td id="Total"></td>
  </tr>
  </table>
</div>
   </aside>
        </div>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Manager Dashboard</title>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="/webjars/bootstrap/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<style><%@ include file="/WEB-INF/views/css/register.css"%></style>
<style><%@ include file="/WEB-INF/views/MANAGER/css/Styledash.css"%></style>
<script type="text/javascript"><%@ include file="/WEB-INF/views/MANAGER/file.js/dash.js"%></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
</head>  
<%
	if(session.getAttribute("nom1")==null){
		response.sendRedirect("loginPage");
	}
%>
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
                Employe ${nom1} 
                <b class="fa fa-angle-down"></b></a>
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
    </nav><br><br><br><br><br>
    <div id="page-wrapper">
        <div class="container-fluid">
            <div class="row" id="main" >
                <div class="col-sm-12 col-md-12 well" id="content">
                    <div class="logo" style="text-align: center;"><img src="https://assets1.dxc.technology/newsroom/images/dxc_logo_hz_blk_rgb-XXSML.png"
        			width="30%" height="40%">
        			</div>
                </div>
            </div>
             <div class="col-lg-12 col-md-12">
              <div class="card">
                <div class="card-header card-header-warning">
                  <h2 class="card-title">Tasks List</h2>
                </div>
                <div class="card-body table-responsive">
                  <table class="table table-hover">
                    <thead class="thead-dark">
                      	<th>Task</th>
                        <th>Date Debut</th>
                      	<th>Date Max</th>
                      	<th>Charge/J</th>
                      	<th>Statut de tâche</th>
                      	<th>Pourcentage Accompli</th>
                      	<th>Description</th>
                      	<th>Type de tache</th>
                      	<th>Action</th>
                    </thead>
                    <tbody>
                    <c:forEach items="${ListTaches}" var="tache">
                      <tr>
                        <td>${tache.titre_tache}</td>
                        <td>${tache.dateDebut}</td>
                        <td>${tache.dateMax}</td>
                        <td>${tache.duree_t}h</td>
                        <td>${tache.statut_t}</td>
                        <td><div class="w3-blue" style="height:24px;width:${tache.percent_complete}%">${tache.percent_complete}%</div></td>
                        <td>${tache.description}</td>
                        <td>${tache.types_tache}</td>
                        <td>
                        <a href="EditPhase?id_tache=${tache.id_tache}" class="btn btn-primary">Modifer</a>                      
						</td>
                       </tr>
                      </c:forEach>
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
        </div>
    </div>
</div>
 <footer class="footer"> 
  <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.2);">
    © 2021 Copyright: DXC Technology
  </div>
 </footer>  
</body>
</html>

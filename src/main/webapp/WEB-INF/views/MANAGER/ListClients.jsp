<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Manager Dashboard</title>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="/webjars/bootstrap/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<style><%@ include file="/WEB-INF/views/css/register.css"%></style>
<style><%@ include file="/WEB-INF/views/MANAGER/css/Styledash.css"%></style>
<script type="text/javascript"><%@ include file="/WEB-INF/views/MANAGER/file.js/dash.js"%></script>
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
                <img src="/${image_profile}" height="80px" width="80px" style="border-radius: 50%;">
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
	
    <div id="page-wrapper">
        <div class="container-fluid">
             <div class="col-lg-12 col-md-12">
              <div class="card">
                <div>
                 <form action="/MANAGER/ListClients" method="get">
   <h3> Chercher par Client <input id="txtSearch" type="text" name="keyword"/>
    	<input type="submit" class="btn btn-success" value="Chercher"/>
    	<a href="/MANAGER/ListClients" class="btn btn-dark">Retour à la liste</a></h3>
    </form><br>
                  <table class="table table-hover">
                    <thead class="thead-dark">
                      	<th>Client</th>
                        <th>Telephone</th>
                      	<th>Address Email</th>
                      	<th>Image</th>
                      	<th>Action</th>
                    </thead>
                    <tbody>
                    <c:forEach items="${ListClients}" var="client">
                      <tr>
                        <td style="font-size: 18px;">${client.nom_client}</td>
                        <td style="font-size: 18px;">${client.telephone}</td>
                        <td style="font-size: 18px;">${client.address}</td>
                        <td> <img src="/${client.image_path}" height="100" width="200"></td>
                        <td><a href="ProjetClient?client=${client.nom_client}" class="btn btn-success" style="width: 60%; margin:25px;">Projets</a></td>
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
</body>
</html>

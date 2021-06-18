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
		return ;
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
            		<a href="/MANAGER/DashboardMANAGER"><img width="220px" height="90px" src="https://assets1.dxc.technology/newsroom/images/dxc_logo_hz_wht_rgb-XXSML.png">
                    </a><a href="/MANAGER/DashboardMANAGER"><i class="fa fa-fw fa-star"></i>Dashboard</a>
                </li>
                <li>
                    <a href="#" data-toggle="collapse" data-target="#submenu-1"><i class="fa fa-th-list"></i>&nbsp;Projets <i class="fa fa-fw fa-angle-down pull-right"></i></a>
                    <ul id="submenu-1" class="collapse">
                        <li><a href="/MANAGER/ListProjets"><i class="fa fa-th-list"></i>&nbsp;Liste projets</a></li>
                        <li><a href="/MANAGER/ListProjets_annuler"><i class="fa fa-th-list"></i>&nbsp;Liste projets Annuler</a></li>
                        <li><a href="/MANAGER/NouvProjet"><i class="fa fa-plus"></i>&nbsp;Cree un Projet</a></li>
                    </ul>
                </li>
                <li><a href="/MANAGER/ListClients"><i class="fa fa-building"></i>&nbsp;Clients</a></li>
                <li>
                    <a href="#" data-toggle="collapse" data-target="#submenu-2"><i class="fa fa-users"></i>&nbsp;Equipes<i class="fa fa-fw fa-angle-down pull-right"></i></a>
                    <ul id="submenu-2" class="collapse">
                        <li><a href="/Equipe/ListEquipe"><i class="fa fa-th-list"></i>&nbsp;Liste des équipes</a></li>
                        <li><a href="/Equipe/ListAllMember"><i class="fa fa-list"></i>&nbsp;Liste des Employes</a></li>
                        <li><a href="/Equipe/NewTeams"><i class="fa fa-plus"></i>&nbsp;Cree une Equipe</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#" data-toggle="collapse" data-target="#submenu-3"><i class="fa fa-spinner"></i>&nbsp;Workload<i class="fa fa-fw fa-angle-down pull-right"></i></a>
                    <ul id="submenu-3" class="collapse">
                        <li><a href="/MANAGER/PlanCharge"><i class="fa fa-tasks"></i>&nbsp;Plan des Charges</a></li>
                    	<li><a href="#"><i class="fa fa-list-alt" aria-hidden="true"></i>&nbsp;Plan d'absence</a></li>
                    </ul>
                  </li>
                <li>
                    <a href="/MANAGER/Profile?cin=${cin}&nom1=$ ${nom1}&prenom1= ${prenom1}"><i class="fa fa-cog" aria-hidden="true"></i>&nbsp;Setting</a>
                </li>
                <li>
                    <a href="#"><i class="fa fa-money" aria-hidden="true"></i>&nbsp;Facturation</a>
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
         <div class="col-lg-10 col-md-12">
              <div class="card">
                <div class="card-header card-header-warning">
                  <h2 class="card-title">Liste des Employes</h2>
                </div>
                 <div class="card-body table-responsive">
                  <table class="table table-hover">
                    <thead class="thead-dark">
                      	<th>Nom d'equipe</th>
                        <th>Recource</th>
                        <th>Charge Globale</th>
                      	<th>Date d'ajout</th>
                    </thead>
                    <tbody>
                    <c:forEach items="${listMember}" var="listMember">
                      <tr>
                        <td>${listMember.team_name}</td>
                        <td>${listMember.employe}</td>
                        <td>${listMember.chargeJour}h</td>
                        <td>${listMember.date_creation}</td>
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

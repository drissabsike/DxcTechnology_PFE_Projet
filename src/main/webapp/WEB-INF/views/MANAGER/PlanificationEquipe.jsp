<%@page import="java.sql.Date"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Manager Dashboard</title>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="/webjars/bootstrap/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<style><%@ include file="/WEB-INF/views/css/register.css"%></style>
<style><%@ include file="/WEB-INF/views/MANAGER/css/Styledash.css"%></style>
<style><%@ include file="/WEB-INF/views/MANAGER/css/t.css"%></style>
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
    </nav><br><br><br><br><br>
    <div id="page-wrapper">
        <div class="container-fluid">
            <div class="row" id="main" >
                <div class="col-sm-12 col-md-12 well" id="content">
                    <div class="logo" style="text-align: center;"><img src="https://assets1.dxc.technology/newsroom/images/dxc_logo_hz_blk_rgb-XXSML.png"
        			width="30%" height="40%">
        			<H3>La Planification des Charges pour le Projet : ${titre_projet}</H3>
        			</div>
                </div>
            </div>

                <div id="page-wrapper" style="font: 20px Calibri;">
                <div class="card-body table-responsive">
                  <table id="table" class="table">
                    <thead class="thead-dark">
                      	<th >Recource</th>
                      	<th>Task</th>
                        <th>Date debut</th>
                      	<th>Date Max</th>
                      	<th>Charge</th>
                      	<th>Statut</th>
                      	<th>Pourcentage Accompli</th>
                      	<th>Description</th>
                      	<th>Type</th>
                      	<th>Action</th>
                    </thead>
                    <tbody>
                    <c:forEach items="${ListTaches}" var="tache">
                      <tr>
                        <td class="w3-gray">${tache.emp_nom}</td>
                        <td>${tache.titre_tache}</td>
                        <td>${tache.dateDebut}</td>
                        <td>${tache.dateMax}</td>
                        <td>${tache.duree_t}h</td>
                        <td class="w3">${tache.statut_t}</td>
                        <td><div class="w3-dark-grey" style="height:24px;width:${tache.percent_complete}%">${tache.percent_complete}</div></td>
                        <td>${tache.description}</td>
                        <td>${tache.types_tache}</td>
                        <td><a href="EditPhase?id_tache=${tache.id_tache}&projet=${titre_projet}" class="btn btn-dark">Modifier</a>
                        <a href="PlanificationCharge?key=${tache.id_tache}" class="btn btn-success">Détaillé</a></td>
                       </tr>
                      </c:forEach>
                    </tbody>
                    <tfoot>
					    <tr>
					      <th colspan="4">Total :</th>
					      <td>${SommeT}h</td>
					    </tr>
					</tfoot>
                  </table>
                </div>
   			 </div>
   			          <div>
   			          <p><em style="margin-left: 30%;">La charge des ressources:</em></p>
                  <table class="column-bordered-table" style="margin-left: 30%;">
                    <thead class="w3-gray">
                      	<th>Recource</th>
                        <th>Equipe</th>
                        <th>Charge Globale</th>
                    </thead>
        <%
	    String titre_projet =(String) session.getAttribute("titre_projet");
	    Class.forName("com.mysql.jdbc.Driver");
	    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/stage?serverTimezone=UTC","root","");
		String req="SELECT m.* FROM membre_equipe m, taches t WHERE m.employe=t.emp_nom AND t.ref_id_projet=(SELECT id_projet from projets WHERE titre_projet ='"+titre_projet+"') GROUP by id_member";
		PreparedStatement ps = con.prepareStatement(req);
		ResultSet rs = ps.executeQuery();
		while(rs.next()) { 
		String employe = rs.getString("employe");
		String team_name = rs.getString("team_name");
		int charge_jour = rs.getInt("charge_jour");
		%>
			   	<tbody>
                    <tr>
                        <td><%=employe%></td>
                       	<td><%=team_name%></td>
                       	<td><%=charge_jour%>h</td>
                     </tr>
                    </tbody>
         <% } con.close();%>	
                  </table><br>
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

<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" isELIgnored="false" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Manager Dashboard</title>
 	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Colorlib Templates">
    <meta name="author" content="Colorlib">
    <meta name="keywords" content="Colorlib Templates">
<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800,800i" rel="stylesheet">
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
<style><%@ include file="/WEB-INF/views/MANAGER/css/main.css"%></style>
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
                        <li><a href="/Equipe/NewTeams"><i class="fa fa-plus"></i>&nbsp;Cree une Equipe</a></li>
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
        			</div>
                </div>
            </div>
             <div class="page-wrapper bg-dark p-t-100 p-b-50">
        <div class="wrapper wrapper--w900">
            <div class="card card-6">
                <div class="card-heading">
                    <h2 class="title">Ajouter des Equipes</h2>
                </div>
                <div class="card-body">
                    <form action="/MANAGER/process_TeamAdd" method="POST">
                        <div class="form-row">
                        <div class="value" style="color:green;position: relative;">${success}</div><br>
                        <div class="value">Titre de Projet</div>
                            <div class="value">
                                <input class="input--style-6" type="text" name="Titre" value="${titre_projet}" readonly>
                                </div><br><br><br>
                        	<div class="value">Selectionner l'equipe</div>
                            <div class="value">
								<select class="input--style-6" name="equipe">
									<% try{
										Class.forName("com.mysql.jdbc.Driver");
										Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/stage?serverTimezone=UTC","root","");
										String req="SELECT nom_equipe FROM equipes";
										PreparedStatement ps = con.prepareStatement(req);
										ResultSet rs = ps.executeQuery();
										while(rs.next()){
											%>
											<option value="<%=rs.getString("nom_equipe")%>"><%=rs.getString("nom_equipe")%></option>
											<% 
										}
									}catch(Exception e){out.print(e.getMessage());}
									%>
								</select><br><br>
                            </div>
                            <div class="value">
							<div class="value">Jours</div>
                            <div class="value">
                                <input class="input--style-6" type="number" placeholder="Les jours du travail" name="jours" required="required">
                                 <br><br>
                                 <div class="value">Description</div>
                                <div class="input-group">
                                    <textarea class="textarea--style-6" name="description" placeholder="Description de Projet"></textarea>
                                	<br><br>
                  <input type="submit" class="btn btn-info" value="Ajouter"><br><br>
                  <input type="button" class="btn btn-secondary" value="Liste des Projets" onclick="goBack();">
                                </div>
                            </div></div>
                            </div>
                    </form>
                </div>
              </div>
        </div>
    </div>
   </div>
  </div>
</div>
<script type="text/javascript">
function goBack(){
	window.location.href = "http://localhost:8080/MANAGER/ListProjets";
}
</script>
 <footer class="footer"> 
 <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.2);">
    © 2021 Copyright: DXC Technology
  </div>
 </footer> 
</body>
<!-- Jquery JS-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <!-- Main JS-->
    <script src="js/global.js"></script>
</html>

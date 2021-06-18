<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
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
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <a class="navbar-brand" href="https://bryanrojasq.wordpress.com">
                <img src="http://placehold.it/200x50&text=LOGO" alt="LOGO">
            </a>
        </div>
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
        			</div>
                </div>
            </div>
             <div class="page-wrapper bg-dark p-t-100 p-b-50">
        <div class="wrapper wrapper--w900">
            <div class="card card-6">
                <div class="card-heading">
                    <h2 class="title">Créer une nouvelle Task : Projetd'ID ${id_projet}</h2>
                </div>
                <div class="card-body">
                    <form action="/MANAGER/process_create_tache" method="POST">
                        <div class="value" style="color:red;margin-left: 80px;">${success}</div>
                        <div class="form-row">
                            <div class="name">Titre Task</div>
                            <div class="value">
                                <input class="input--style-6" type="text" name="titre_tache" required="required">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="name">Charge/Jour :</div>
                            <div class="value">
                                <input class="input--style-6" type="number" name="duree_t" required="required">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="name">Pourcentage accompli %</div>
                            <div class="value">
                                <input class="input--style-6" type="number" name="percent_complete" required="required">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="name">Type</div>
                            <div class="value">
								<select class="input--style-6" name="types_tache" required="required">
									<option>Conception</option>
									<option>Developpement</option>
									<option>Design</option>
									<option>Testing</option>
									<option>Integration</option>	
								</select>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="name">La statut:</div>
                            <div class="value">
								<select class="input--style-6" name="statut_t" required="required">
									<option>En Attente</option>
									<option>En Cours</option>
									<option>Terminer</option>
								</select>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="name">Attribuer à</div>
                            <div class="value">
								<select class="input--style-6" name="emp_nom" required="required">
									<option>----Select----</option>
									<% try{
										String nom =(String) session.getAttribute("nom1");
								      	String prenom =(String) session.getAttribute("prenom1");
								      
								      	Class.forName("com.mysql.jdbc.Driver");
										Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/stage?serverTimezone=UTC","root","");
										String req="SELECT CONCAT(nom, ' ', prenom) AS fullName FROM users WHERE role_user='EMPLOYE'";
										PreparedStatement ps = con.prepareStatement(req);
										ResultSet rs = ps.executeQuery();
										while(rs.next()){
											%>
											<option value="<%=rs.getString("fullName")%>"><%=rs.getString("fullName")%></option>
											<% 
										}
									}catch(Exception e){out.print(e.getMessage());}
									%>
								</select>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="name">Date début</div>
                            <div data-role="page" id="home"> 
                            <input id="date" type="date" name="DateDebut" value="2021-06-01"><br>
    					</div>
                        </div>
                       <div class="form-row">
                            <div class="name">Date fin</div>
                            <div data-role="page" id="home"> 
                            <input id="date" type="date" name="DateMax" value="2021-07-01"><br>
                        </div>
                        </div>
                        <div class="form-row">
                            <div class="name">ID du Projet</div>
                            <div class="value">
                                <input class="input--style-6" type="number" name="id_projet"  value="${id_projet}" readonly>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="name">Description</div>
                            <div class="value">
                                <div class="input-group">
                                    <textarea class="textarea--style-6" name="description" placeholder="Description de Projet" required="required"></textarea>
                                </div>
                                <input type="submit" class="btnRegister"  value="Ajouter"/>	
                            </div>
                        </div>
                        
                    </form>
                </div>
                
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
<!-- Jquery JS-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <!-- Main JS-->
    <script src="js/global.js"></script>
</html>

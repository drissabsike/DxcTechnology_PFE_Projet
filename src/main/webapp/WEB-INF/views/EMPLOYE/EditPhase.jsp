<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" errorPage="error.jsp" pageEncoding="UTF-8" isELIgnored="false" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
    if((session.getAttribute("cin")==null) && session.getAttribute("nom2")==null){
        response.sendRedirect("loginPage");
    }
%>
<body>
<div id="throbber" style="display:none; min-height:120px;"></div>
<div id="noty-holder"></div>
<div id="wrapper">
    <!-- Navigation -->
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
        <ul class="nav navbar-right top-nav">
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                <img src="/${image_profile}" height="80px" width="80px" style="border-radius: 50%;">
                ADMIN ${nom1} 
                <b class="fa fa-angle-down"></b></a>
                <ul class="dropdown-menu">
                    <li ><a href="doLogout"><i class="fa fa-power-off"></i>Logout</a></li>
                </ul>
            </li>
        </ul>
        <!-- Sidebar Menu Items - These collapse to the responsive navigation menu on small screens -->
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
    </nav>
	<br><br><br><br><br>
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
        <div class="wrapper wrapper--w600">
            <div class="col-md-3 register-left">
                        <img src="/pics/dxc_logo_vt_blk_rgb_300.png" 
                        style="height: 160px;width: 160px;"/>
                        <h3>Bienvenue dans l'application ClickDown  ,Gerer Vos Projets</h3>
                    </div>
            <div class="card card-6">
                <div class="card-heading">
                    <h2 class="title">Modification de Task :${task.titre_tache}</h2>
                </div>
                <div class="card-body" style="margin-right: 450px;">
                    <form action="/EMPLOYE/process_update_task_emp" method="post">
                        <div class="form-row">
                            <div class="name">Task ID :</div>
                            <div class="value">
                                <input class="input--style-6" type="number" name="id_tache" value="${task.id_tache}" readonly>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="name">Charge/jour: </div>
                            <div class="value">
                                <input class="input--style-6" type="number" name="duree_t" value="${task.duree_t}" readonly>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="name">Type</div>
                            <div class="value">
                             <input class="input--style-6" type="text" value="${task.types_tache}" readonly>
							</div>
                        </div>
                        <div class="form-row">
                            <div class="name">Statut de Tache</div>
                            <div class="value">
								<select class="input--style-6" name="statut_t">
									<option>${task.statut_t}</option>
									<% try{
										Class.forName("com.mysql.jdbc.Driver");
										Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/stage?serverTimezone=UTC","root","");
										String req="SELECT * FROM statuts";
										PreparedStatement ps = con.prepareStatement(req);
										ResultSet rs = ps.executeQuery();
										while(rs.next()){
											%>
											<option value="<%=rs.getString("statut_tache")%>"><%=rs.getString("statut_tache")%></option>
											<% 
										}
									}catch(Exception e){out.print(e.getMessage());}
									%>
								</select>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="name">Date Début</div>
                            <div data-role="page" id="home"> 
                            <input id="date" type="date" value="${task.dateDebut}" readonly><br>
    
						</div>
                        </div>
                       <div class="form-row">
                            <div class="name">Date Max</div>
                            <div data-role="page" id="home"> 
                            <input id="date" type="date"  value="${task.dateMax}" readonly><br>
                        </div>
                        </div>
                        <div class="form-row">
                            <div class="name">Description</div>
                            <div class="value">
                                <div class="input-group">
                                    <textarea class="textarea--style-6" name="description">${task.description}</textarea>
                                </div>
                        <input type="submit" class="btnRegister"  value="Modifier"/>
                          </div>
                          <a href="http://localhost:8080/EMPLOYE/ListTaches2" class="btn btn-dark">Tasks List</a>
                        </div>
                        	</form>
                            </div>
                        </div>
                </div>
            </div>
        </div>
    </div>
   </div>
</body>
<!-- Jquery JS-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <!-- Main JS-->
    <script src="js/global.js"></script>
</html>

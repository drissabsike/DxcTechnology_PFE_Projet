<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
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
                   Admin:  ${nom1} 
                <b class="fa fa-angle-down"></b></a>
                <ul class="dropdown-menu">
                    <li ><a href="doLogout"><i class="fa fa-power-off"></i>Logout</a></li>
                </ul>
            </li>
        </ul>
        <!-- Sidebar Menu Items - These collapse to the responsive navigation menu on small screens -->
        <div class="collapse navbar-collapse navbar-ex1-collapse">
            <ul class="nav navbar-nav side-nav">
            	<li><a href="DashboardAdmin"><img width="200px" height="90px" src="https://assets1.dxc.technology/newsroom/images/dxc_logo_hz_wht_rgb-XXSML.png">
                    </a><a href="DashboardAdmin?nom=${nom1}&prenom=${prenom1}"><i class="fa fa-fw fa-star"></i>ADMIN Dashboard</a>
                </li>
                <li>
                    <a href="#" data-toggle="collapse" data-target="#submenu-1"><i class="fa fa-users"></i>&nbsp;Utilisateurs <i class="fa fa-fw fa-angle-down pull-right"></i></a>
                    <ul id="submenu-1" class="collapse">
                        <li><a href="ListUsers?nom=${nom1}&prenom=${prenom1}"><i class="fa fa-th-list"></i>&nbsp;Liste des Utilisateurs</a></li>
                        <li><a href="Signup_Form?nom=${nom1}&prenom=${prenom1}"><i class="fa fa-plus"></i>&nbsp;Cun Utilisateur</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#" data-toggle="collapse" data-target="#submenu-2"><i class="fa fa-users"></i>&nbsp;Clients <i class="fa fa-fw fa-angle-down pull-right"></i></a>
                    <ul id="submenu-2" class="collapse">
                        <li><a href="ListClients?nom=${nom1}"><i class="fa fa-th-list"></i>&nbsp;Liste des Clients</a></li>
                        <li><a href="NouvClient?nom=${nom1}"><i class="fa fa-user-plus"></i>&nbsp;Ajouter des Client</a></li>
                    </ul>
                </li>
                <li>
                    <a href="ListProjets?nom=${nom1}"><i class="fa fa-list-alt" aria-hidden="true"></i>&nbsp;Liste des Projets</a>
                </li>
                <li>
                    <a href="ListTaches?nom=${nom1}"><i class="fa fa-tasks" aria-hidden="true"></i>&nbsp;Liste des Phases</a>
                </li>
            </ul>
        </div>
    </nav><br><br><br><br>
	
    <div id="page-wrapper">
        <div class="container-fluid">
             <div class="col-lg-12 col-md-12">
              <div class="card">
                <div>
                 <form action="/ADMIN/ListClients" method="get">
   <h3> Chercher par Client <input id="txtSearch" type="text" name="keyword"/>
    	<input type="submit" class="btn btn-success" value="Chercher"/>
    	<a href="/ADMIN/ListClients" class="btn btn-dark">Retour à la liste</a></h3>
    </form><br>
                  <table class="table table-hover">
                    <thead class="thead-dark">
                      	<th>Client</th>
                        <th>Telephone</th>
                      	<th>Address Email</th>
                      	<th>Image</th>
                    </thead>
                    <tbody>
                    <c:forEach items="${ListClients}" var="client">
                      <tr>
                        <td style="font-size: 18px;">${client.nom_client}</td>
                        <td style="font-size: 18px;">${client.telephone}</td>
                        <td style="font-size: 18px;">${client.address}</td>
                        <td> <img src="/${client.image_path}" height="100" width="200"></td>
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

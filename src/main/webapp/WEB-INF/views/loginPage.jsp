<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home Page</title>
<style><%@ include file="/WEB-INF/views/css/loginStyle.css"%></style>
</head>
<body>
	 <div class="parent clearfix">
    <div class="bg-illustration">
      <img src="/pics/dxcLOGO.png" alt="logo">
    </div>	
    <div class="login">
      <div class="container">
      <h1 style="text-align: center;">Bienvenue dans l'application ClickDown<br/><br>
               <img src="/pics/dxc-technology-logo-2.svg"
               height="100%" width="90%" style="display: block;margin-left: auto;margin-right: auto;"/>
        </h1>
        <div class="login-form">
          <form action="process_login" method="post">
          
            <input type="email" name="email" placeholder="E-mail Address" required="required">
            
            <input type="password" name="password" placeholder="Password" required="required">
            
            <button type="submit" style="display: block;margin-left: auto;margin-right: auto;">Connexion</button>
			<a href="motdepasseOublie" style="display: block;margin-left: auto;margin-right: auto;">Mot de passe oublié ?</a><br><br><br><br><br>
			<div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0);">
			    © 2021 Copyright: DXC Technology
			</div>
          </form>
        </div>
      </div>
      </div>  
  </div>  
</body>
</html>
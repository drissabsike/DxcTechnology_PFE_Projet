<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Creation Nouveau Mot de Passe</title>
<style><%@ include file="/WEB-INF/views/css/pwdForgotStyle.css"%></style>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="/webjars/bootstrap/css/bootstrap.min.css">
</head>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <a class="navbar-brand">Portofolio Gestion Projet</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="loginPage">Home Page</a>
        </li>
      </ul>
    </div>
  </div>
</nav>
<body>
			<div class="container register">
                <div class="row">
                    <div class="col-md-3 register-left">
                        <img src="/pics/dxc_logo_vt_blk_rgb_300.png"style="height: 160px;width: 160px"/>
                        <h3>Bienvenue dans l'application ClickDown  ,Gerer Vos Projets</h3>
                    </div>
                    
                    <div class="col-md-9 register-right">
                    
                        <div class="tab-content" id="myTabContent">
                            <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                                <h3 class="register-heading">Mot de passe oublie ?<br>
                              	&nbsp;&nbsp;saisir votre Matricule pour Modifier votre mot de passe ou contacter l'administrateur par mail : admin@gmail.com
                                </h3><br>
                                  <img src="/pics/password-img.png" height="358px" width="920px"/>
                              	<div class="row register-form">
                    			<form action="process_pwd" method="post" >
                                	<div class="col-md-5" style="margin-left: 150px;">
                                      <div class="form-group" >
                                            <input type="text" name="matricule" class="form-control" placeholder="Matricule"  required="required" />
                                      </div>
                                      <div class="form-group" style="width: 280px;">
                                            <input type="password" class="form-control"  name="pawssord1" placeholder="Nouveau Mot de passe"  required="required"/>
                                        </div>
                                        <input type="submit" class="btnRegister" value="Recuperer"/><br><br><br>
                                       	 &nbsp;&nbsp;<a aria-current="page" href="loginPage">Home Page</a>
                                    </div>	
                                  </form>
                                  </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

</body>
</html>
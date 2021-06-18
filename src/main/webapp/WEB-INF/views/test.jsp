<%@page import="java.sql.Date"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.7.2/main.min.css">
<style>
table, td, th {
  border: 1px solid black;
}

table {
  border-collapse: collapse;
  width: 30%;
  margin-left: auto; 
  margin-right: auto;
}

td {
  text-align: center;
}
body .fc { 
   font-size: 1.5em;  
}

#calendar{
background-color: #F8F8FF;
border-color: black;
border-style: solid;
border-width: thin;
height: 50%;
width: 50%;
margin-left: auto; 
margin-right: auto;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.7.2/main.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/2.9.1/lang-all.js"></script>
</head>
 <script>
 document.addEventListener('DOMContentLoaded', function() {
	    var calendarEl = document.getElementById('calendar');
	    <%
	    Class.forName("com.mysql.jdbc.Driver");
	    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/stage?serverTimezone=UTC","root","");
		String req="SELECT emp_nom,duree_t,date_debut,titre_tache,date_max,DATEDIFF(date_max, date_debut) AS days FROM taches where emp_nom='ismail bouhbal';";
		PreparedStatement ps = con.prepareStatement(req);
		ResultSet rs = ps.executeQuery();
		while(rs.next()) { 
		String emp_nom = rs.getString("emp_nom");
		Date date_debut = rs.getDate("date_debut");
		Date date_max = rs.getDate("date_max");
		int duree_t = rs.getInt("duree_t");
		int days = rs.getInt("days");
		String titre_tache = rs.getString("titre_tache");
		%>
		var titre_tache="<%=titre_tache%>";
		var duree_t ="<%=duree_t%>";
		var emp_nom ="<%=emp_nom%>";
		var date_debut="<%=date_debut%>";
		var date_max="<%=date_max%>";
		var days="<%=days%>";

		  var calendar = new FullCalendar.Calendar(calendarEl, {
		  locale: "fr",
		  initialView: 'dayGridMonth',
	      initialDate: date_debut,
	      headerToolbar: {
	        center: ''
	      },
	      events: [
	        {
	          title: emp_nom+": Charge/Jour: "+duree_t+"h, Task: "+titre_tache,
	          start: date_debut,
	          end: date_max,
	          rendering: 'background',
              color: '#A9A9A9',
              textColor: 'black'
	        }
	      ]
		});
		  console.log(parseInt(duree_t)+" h");
		  console.log(parseInt(days)+" jours");
		  var total = parseInt(duree_t)*parseInt(days);
	    <% } %>		
	    calendar.render();
	    $('#nom').html(emp_nom)
	    $('#td1').html(duree_t+"h")
	    $('#jours').html(days+"jours")
	    $('#Total').html(total+"h")
 });
    </script>	
 <body>
    <div id='calendar'></div><br>
   <aside style="font: 20px Calibri;">
<div>
<table>
  <tr>
    <th>Recource</th>
    <th>Charge/Jour</th>
    <th>Nomber des jours</th>
    <th>Total</th>
  </tr>
  <tr>
    <td id="nom"></td>
    <td id="td1"></td>
    <td id="jours"></td>
    <td id="Total"></td>
  </tr>
  </table>
</div>
   </aside>
  </body>
</html>
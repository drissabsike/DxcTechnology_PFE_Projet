<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" errorPage="error.jsp" pageEncoding="UTF-8" isELIgnored="false" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<html>
<head>
  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
  <script type="text/javascript">
    google.charts.load('current', {'packages':['gantt']});
    google.charts.setOnLoadCallback(drawChart);

    function drawChart() {

      var data = new google.visualization.DataTable();
      data.addColumn('string', 'Task ID');
      data.addColumn('string', 'Task Name');
      data.addColumn('string', 'Resource');
      data.addColumn('date', 'Start Date');
      data.addColumn('date', 'End Date');
      data.addColumn('number', 'Duration');
      data.addColumn('number', 'Percent Complete');
      data.addColumn('string', 'Dependencies');
      <%
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/stage?serverTimezone=UTC","root","");
		//System.out.print("Connected");
		String req="SELECT id_projet, daydeb_p, mdeb_p , dayfin_p, mfin_p, ydeb_p, yfin_p, titre_projet FROM projets";
		PreparedStatement ps = con.prepareStatement(req);
		ResultSet rs = ps.executeQuery();
		while(rs.next()) { 
			
		String id_projet = rs.getString("id_projet");
		String titre_projet = rs.getString("titre_projet");
		
		int daydeb_p = rs.getInt("daydeb_p");
		int mdeb_p = rs.getInt("mdeb_p");
		int ydeb_p = rs.getInt("ydeb_p");
		
		int yfin_p = rs.getInt("yfin_p");
		int mfin_p = rs.getInt("mfin_p");
		int dayfin_p = rs.getInt("dayfin_p");%>

		
		var id_projet="<%=id_projet%>";
		var titre_projet="<%=titre_projet%>";
		
		var ydeb_p="<%=ydeb_p%>";
		var mdeb_p="<%=mdeb_p%>";
		var daydeb_p="<%=daydeb_p%>";
		
		var yfin_p="<%=yfin_p%>";
		var mfin_p="<%=mfin_p%>";
		var dayfin_p="<%=dayfin_p%>";
		
	 data.addRows([
		 [id_projet, titre_projet, null,
	         new Date(ydeb_p, mdeb_p, daydeb_p), new Date(yfin_p, mfin_p, dayfin_p), null, null, null]
		 ]);
	 <% } %>	
      var options = {
        height: 500,
        gantt: {
          trackHeight: 30
        }
      };

      var chart = new google.visualization.Gantt(document.getElementById('chart_div'));

      chart.draw(data, options);
    }
  </script>
</head>
<body>
  <div id="chart_div"></div>
</body>
</html>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
</head>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<body>

		<table align="center">
		<tr>
			<td style="color: red;padding-right:600px;padding-left:400px">${message}</td>
			<td><div onclick="goHome()">Home</div></td>
		</tr>
	</table>
		<div id = "object" style = "display:none;" >${chartData}</div>
<table style="padding-top:85px;">
	<tr>
		<td style ="padding-right:400px;padding-left:300px"><div onclick="getGraphs()">Views V/S Countries</div></td>
		<td><div onclick="getGraphs()">Views V/S Countries</div></td>
	</tr>
	<tr>
		<td style ="padding-right:400px;padding-left:300px">Views V/S Countries</td>
		<td><div onclick="getGraphs()">Views V/S Countries</div></td>
	</tr>
	<tr>
		<td style ="padding-right:400px;padding-left:300px">Views V/S Countries</td>
		<td><div onclick="getGraphs()">Views V/S Countries</div></td>
	</tr>
	<tr>
		<td style ="padding-right:400px;padding-left:300px">Views V/S Countries</td>
		<td><div onclick="getGraphs()">Views V/S Countries</div></td>
	</tr>
</table>
</body>
<script type = "text/javascript">
google.charts.load('current', {'packages':['corechart']});
function goHome(){
	var path = window.location.href;
	window.location.href= path.substr(0,path.indexOf('/login'));

}
function getGraphs(){
	alert('Generating Graphs');
	var path = window.location.href;
	path= path.substr(0,path.indexOf('/login'));
	path +='/register';
	window.open(path,'xyz','location=yes,height=570,width=520,scrollbars=yes,status=yes');
}
</script>
</html>
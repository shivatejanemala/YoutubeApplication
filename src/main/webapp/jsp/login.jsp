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
<body style="background-color:#F5F5DB">

		<table align="center">
		<tr>
			<td style="color: red;padding-right:600px;padding-left:400px">${message}</td>
			<td><div onclick="goHome()">Home</div></td>
		</tr>
	</table>
		<div id = "object" style = "display:none;" >${chartData}</div>
<table style="padding-top:85px;">
	<tr>
		<td style ="padding-right:400px;padding-left:300px;border: 1px solid blue"><div onmouseover="contentDisplay(1)" onmouseout="hideContent()" onclick="getGraphs(1)">Most Active users in various Countries</div></td>
		<td style ="border: 1px solid blue;"><div onmouseover="contentDisplay(2)" onmouseout="hideContent()" onclick="getGraphs(2)">Number of Days in Trending vs Countries</div></td>
	</tr>
	<tr>
		<td style ="padding-right:400px;padding-left:300px;border: 1px solid blue"><div onmouseover="contentDisplay(3)" onmouseout="hideContent()" onclick="getGraphs(3)">Most Viewed Channel</div></td>
		<td style ="border: 1px solid blue;"><div onmouseover="contentDisplay(4)" onmouseout="hideContent()" onclick="getGraphs(4)">Most Viewed Channel</div></td>
	</tr>
	<tr>
		<td style ="padding-right:400px;padding-left:300px;border: 1px solid blue"><div onmouseover="contentDisplay(5)" onmouseout="hideContent()" onclick="getGraphs(5)">Most Popular video based on category</div></td>
		<td style ="border: 1px solid blue;"><div onmouseover="contentDisplay(6)" onmouseout="hideContent()" onclick="getGraphs(6)">Video List With Like-Comment Ratio</div></td>
	</tr>
	<tr>
		<td style ="padding-right:400px;padding-left:300px;border: 1px solid blue"><div onmouseover="contentDisplay(7)" onmouseout="hideContent()" onclick="getGraphs(7)">Number of Videos removed in different countries</div></td>
		<td style ="border: 1px solid blue;"><div onmouseover="contentDisplay(8)" onmouseout="hideContent()" onclick="getGraphs(8)">5 Most Disliked Videos</div></td>
	</tr>
</table>
<div>
<table id="aboutTable">
<tr>
<td></td>
<td></td>
</tr>
</table>
</div>
</body>
<script type = "text/javascript">
google.charts.load('current', {'packages':['corechart']});
function goHome(){
	var path = window.location.href;
	window.location.href= path.substr(0,path.indexOf('/login'));

}
function getGraphs(queryNo){
	//alert('Generating Graphs');
	var path = window.location.href;
	path= path.substr(0,path.indexOf('/login'));
	path +='/query'+queryNo;
	//window.open(path,'xyz','location=yes,height=570,width=520,scrollbars=yes,status=yes');
	window.location.href = path;
}
function  contentDisplay(queryNo){
	document.getElementById('aboutTable').innerHTML="Welcome to Query"+queryNo+"!!!";
}
function hideContent(){
	document.getElementById('aboutTable').innerHTML = "";
}
</script>
</html>
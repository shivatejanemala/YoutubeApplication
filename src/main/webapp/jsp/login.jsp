<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
<style>
.button {
  display: inline-block;
  padding: 15px 25px;
  font-size: 24px;
  cursor: pointer;
  text-align: center;
  text-decoration: none;
  outline: none;
  color: #fff;
  background-color: #4CAF50;
  border: none;
  border-radius: 15px;
  box-shadow: 0 9px #999;
}
.button:hover {background-color: #3e8e41}

.button:active {
  background-color: #3e8e41;
  box-shadow: 0 5px #666;
  transform: translateY(4px);
}
body{
background-image: url(analysis.jpg);
background-color:#F5F5DB;
}

.welcome{
position:relative;
z-index:100;
color:white;
line-height: 50px;
overflow: hidden;
z-index: 2;
}

.countryButton{
width: 395px;
height: 70px;
border: 1px solid blue;
font-family: Georgia, serif;
font-size: large;
text-align: center;
background-color:#d5e1df;
color: teal;
}

.countryButtonHover:hover{
box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24),0 17px 50px 0 rgba(0,0,0,0.19);
}
</style>
</head>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<body>

  <table class="welcome">
		<tr>
			<td style="padding-right:500px;padding-left:400px">${message}</td>
			<td><div onclick="goHome()">Home</div></td>
		</tr>
   </table>

<div id = "object" style = "display:none;" >${chartData}</div>
		
 <table style="padding-top:85px;padding-left:225px;">
	<tr>
		<td><button onmouseover="contentDisplay(1)" onmouseout="hideContent()" onclick="getGraphs(1)" class="countryButton">Most Active users in various Countries</button></td>
		<td><button onmouseover="contentDisplay(2)" onmouseout="hideContent()" onclick="getGraphs(2)" class="countryButton">Number of Days in Trending vs Countries</button></td>
	</tr>
	<tr>
			<td><button onmouseover="contentDisplay(3)" onmouseout="hideContent()" onclick="getGraphs(3)" class="countryButton">Most Viewed Channels</button></td>
			<td><button onmouseover="contentDisplay(4)" onmouseout="hideContent()" onclick="getGraphs(4)" class="countryButton">Most Viewed Channel</button></td>
	</tr>
	<tr>
			<td><button onmouseover="contentDisplay(5)" onmouseout="hideContent()" onclick="getGraphs(5)" class="countryButton">Most Popular video based on category</button></td>
			<td><button onmouseover="contentDisplay(6)" onmouseout="hideContent()" onclick="getGraphs(6)" class="countryButton">Video List With Like-Comment Ratio</button></td>
	</tr>
	<tr>
			<td><button onmouseover="contentDisplay(7)" onmouseout="hideContent()" onclick="getGraphs(7)" class="countryButton">Number of Videos removed in different countries</button></td>
			<td><button onmouseover="contentDisplay(8)" onmouseout="hideContent()" onclick="getGraphs(8)" class="countryButton">5 Most Disliked Videos</button></td>
	</tr>
</table>
<div>
<table id="aboutTable" style="color:#c1946a">
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
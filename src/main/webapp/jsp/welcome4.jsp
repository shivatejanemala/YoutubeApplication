<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Welcome</title>
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
width: 295px;
height: 70px;
border: 1px solid blue;
font-family: Georgia, serif;
font-size: x-large;
text-align: center;
background-color:#d5e1df;
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
   
	<div style="padding-left:500px;padding-top:20px">
		<div style="color:white;float:left">Selected Countries</div>
		<input type="radio" name="classification" value="countries" onclick="toggleGraphs(this)" style="color:white;float:left">
		<div style="color:white;float:left">World Wide</div>
		<input type="radio" name="classification" value="WorldWide" onclick="toggleGraphs(this)" style="color:white;float:left" checked>
	</div>
	
	<div id = "barchart" style="padding-left:370px;padding-top: 60px;"></div>
	<div id="categoryData" style="display:none;">${categoryData}</div>
	<div id="queryType" style="display:none;">${queryType}</div>
</body>
<script>
google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawChart);
function goHome(){
	var path = window.location.href;
	window.location.href= path.substr(0,path.indexOf('/query'));

}
function toggleGraphs(id){
	//alert(id);
	if(id.value=="countries"){
		var data = new google.visualization.DataTable();
		data.addColumn('string','Videos');
		data.addColumn('number','Views');
		createChart(data,1);
	}else if(id.value=="WorldWide"){
		var data = new google.visualization.DataTable();
		data.addColumn('string','Videos');
		data.addColumn('number','Views');
		createChart(data,0);
	}
}
function drawChart(){
	var data = new google.visualization.DataTable();
	data.addColumn('string','Videos');
	data.addColumn('number','Views');
	createChart(data,0);
	}
	
function createChart(data,id){
	var jsonData= JSON.parse(document.getElementById('categoryData').innerHTML);
	var queryType= document.getElementById('queryType').innerHTML;
		if(id == 1){
			jsonData = jsonData.secondList;
		}
		else{
			jsonData = jsonData.primaryList;
		}
	for (var i = 0; i < jsonData.length; i++) {
		var category = jsonData[i].Categories;
		category = category.toString();
		category = category.replace(/\&amp;/g,'and');
		data.addRow([category, parseInt(jsonData[i].Videos,10)]);
    }
	//var pieTitle = {'title':'Videos-Views', 'width':550, 'height':400};
	  var columnTitle = {'title':'Most Viewed Categories', 'width':550, 'height':400, colors:['blue','black']};
		var columnChart = new google.visualization.ColumnChart(document.getElementById('barchart'));
		columnChart.draw(data, columnTitle);
}
</script>
</html>
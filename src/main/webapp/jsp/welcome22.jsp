<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Welcome</title>
</head>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<body style="background-color:#F5F5DB">
	<table>
		<table>
		<tr>
			<td style="padding-left:550px;padding-right:300px;">${message}</td>
			<td><div onclick="goHome()">Home</div></td>
		</tr>
	</table>
	</table>
	
		<div id = "piechart"></div>
	<div id = "barchart" style="padding-left:420px;padding-top: 80px;"></div>
	<div id="categoryData" style="display:none;">${query2Data}</div>
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
		var CountryName = jsonData[i].CountryName;
		
		data.addRow([CountryName, parseInt(jsonData[i].Count,10)]);
    }
	//var pieTitle = {'title':'Videos-Views', 'width':550, 'height':400};
	  var columnTitle = {'title':'Most Viewed Categories', 'width':550, 'height':400, colors:['blue','black']};
		var columnChart = new google.visualization.ColumnChart(document.getElementById('barchart'));
		columnChart.draw(data, columnTitle);
}
</script>
</html>
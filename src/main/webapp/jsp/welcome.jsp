<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Welcome</title>
</head>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<body>
	<table>
		<tr>
			<td>${firstname}</td>
		</tr>
		<tr>
		</tr>
		<tr>
		</tr>
		<tr>
			<td><div onclick="goHome()">Home</div></td>
		</tr>
	</table>
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
function drawChart(){
	var objectData = document.getElementById('categoryData');
	console.log('object- '+objectData);
	console.log('Title- '+ objectData.Title);
	var data = new google.visualization.DataTable();
	data.addColumn('string','Videos');
	data.addColumn('number','Views');
	
	var jsonData= JSON.parse(document.getElementById('categoryData').innerHTML);
	var queryType= document.getElementById('queryType').innerHTML;
	if(queryType == 'query4'){
	for (var i = 0; i < jsonData.categoryList.length; i++) {
        data.addRow([jsonData[i].videos, jsonData[i].views]);
    }
	}
	var pieTitle = {'title':'Videos-Views', 'width':550, 'height':400};
	  var barTitle = {'title':'Videos-Views', 'width':550, 'height':400, colors:['blue','black']};
	  var piechart = new google.visualization.PieChart(document.getElementById('piechart'));
		var barchart = new google.visualization.BarChart(document.getElementById('barchart'));
		  piechart.draw(data, pieTitle);
		  barchart.draw(data, barTitle);
}
</script>
</html>
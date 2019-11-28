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
	
		<div id = "piechart"></div>
	<div id = "barchart"></div>
	<div id="categoryData" style="display:none;">${CategoryVideoList}</div>
	<div id="queryType" style="display:none;">${queryType}</div>
</body>
<script>
google.charts.load('current', {'packages':['table']});
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
	data.addColumn('string','Video URL');
	data.addColumn('string','Category Name');
	data.addColumn('string','Title');
	data.addColumn('number','Days Popular');
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
		var DaysPopular = jsonData[i].DaysPopular;
		var Video_url = jsonData[i].Video_url;
		var CategoryName = jsonData[i].CategoryName;
		var Title = jsonData[i].Title;
		data.addRow([Video_url,CategoryName, Title, parseInt(jsonData[i].DaysPopular,10)]);
    }
	//var pieTitle = {'title':'Videos-Views', 'width':550, 'height':400};
	  var tableTitle = {'title':'Most Viewed Categories', 'width':550, 'height':400, colors:['blue','black']};
		var tableChart = new google.visualization.Table(document.getElementById('barchart'));
		tableChart.draw(data, tableTitle);
		
		var selectHandler = function(e) {
	         window.open(data.getValue(tableChart.getSelection()[0]['row'], 0 ));
	        }

	        // Add our selection handler.
	        google.visualization.events.addListener(tableChart, 'select', selectHandler);
}
</script>
</html>
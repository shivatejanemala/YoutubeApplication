<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
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
	<div id = "barchart1" style="padding-left:420px;padding-top: 80px;"></div>
	<div id = "barchart2" style="padding-left:420px;padding-top: 80px;"></div>
	<div id="query8Data" style="display:none;">${query8Data}</div>
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
	var data = new google.visualization.DataTable();
	data.addColumn('string','Categories');
	data.addColumn('number','View-Comment Ratio');
	
	var data1 = new google.visualization.DataTable();
	data1.addColumn('string','Categories');
	data1.addColumn('number','Dislike-View Ratio');
	
	createChart(data,0);
	createChart(data1,1);
	}
	
function createChart(data,id){
	var jsonData= JSON.parse(document.getElementById('query8Data').innerHTML);
	var queryType= document.getElementById('queryType').innerHTML;
		if(id == 1){
			jsonData = jsonData.secondList;
		}
		else{
			jsonData = jsonData.primaryList;
		}
	for (var i = 0; i < jsonData.length; i++) {
		var category = jsonData[i].CategoryName;
		category = category.toString();
		category = category.replace(/\&amp;/g,'and');
		data.addRow([category, parseFloat(jsonData[i].vcRatio,10)]);
    }

	if(id ==0){
		var columnTitle1 = {'title':'Categories vs View-Comment Ratio', 'width':550, 'height':400, colors:['blue','black']};
		var columnChart1 = new google.visualization.ColumnChart(document.getElementById('barchart1'));
		columnChart1.draw(data, columnTitle1);
	}
	else{
		  var columnTitle2 = {'title':'Categories vs DisLike-View Ratio', 'width':550, 'height':400, colors:['blue','black']};
		  var columnChart2 = new google.visualization.ColumnChart(document.getElementById('barchart2'));
		  columnChart2.draw(data, columnTitle2);	
	}
	
		}
</script>
</html>
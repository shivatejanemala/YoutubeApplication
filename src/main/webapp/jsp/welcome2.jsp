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
		<tr>
			<td style="padding-left:550px;padding-right:300px;">${message}</td>
			<td><div onclick="goHome()">Home</div></td>
		</tr>
	</table>
	
		<div id = "piechart"></div>
	<table id = "videosTable"  align="center" style="padding-top:80px">
	
	</table>
	<div id="categoryData" style="display:none;">${query2Data}</div>
	<div id="queryType" style="display:none;">${queryType}</div>
</body>
<script>
google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(createChart);
function goHome(){
	var path = window.location.href;
	window.location.href= path.substr(0,path.indexOf('/query'));

}

	
function createChart(){
	var jsonData= JSON.parse(document.getElementById('categoryData').innerHTML);
	jsonData = jsonData.primaryList;
	for (var i = 0; i < jsonData.length; i++) {
		var VideoTitle = jsonData[i].VideoTitle;
		var table = document.getElementById("videosTable");
		var row = table.insertRow(i);
		var cell = row.insertCell(0);
		cell.innerHTML = VideoTitle;
		cell.style.border = "1px solid black";
		cell.onclick = function(){
			getVideoInfo(this);
		} 
    }
	
}

function getVideoInfo(cell){
	var videoTitle = cell.innerHTML;
	var path = window.location.href;
	window.location.href = encodeURI( path.substr(0,path.indexOf('/query')) + '/query2part2?videotitle='+videoTitle);
}
</script>
</html>
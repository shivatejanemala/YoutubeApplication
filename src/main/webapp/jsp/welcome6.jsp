<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
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
   
	<div id = "barchart1" style="padding-left:50px;padding-top: 80px;float:left"></div>
	<div id = "barchart2" style="padding-left:50px;padding-top: 80px;float:left"></div>
	<div id="query6Data" style="display:none;">${query6Data}</div>
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
	data.addColumn('number','Like-Dislike Ratio');
	
	var data1 = new google.visualization.DataTable();
	data1.addColumn('string','Categories');
	data1.addColumn('number','Like-View Ratio');
	createChart(data,0);
	createChart(data1,1);
	}
	
function createChart(data,id){
	var jsonData= JSON.parse(document.getElementById('query6Data').innerHTML);
	var queryType= document.getElementById('queryType').innerHTML;
		if(id == 1){
			jsonData = jsonData.secondList;
		}
		else{
			jsonData = jsonData.primaryList;
		}
	for (var i = 0; i < jsonData.length; i++) {
		var country = jsonData[i].CategoryName;
		country = country.toString();
		country = country.replace(/\&amp;/g,'and');
		data.addRow([country, parseInt(jsonData[i].ldRratio,10)]);
    }

	if(id ==0){
		var columnTitle1 = {'title':'Categories vs Like-Dislike Ratio', 'width':550, 'height':400, colors:['blue','black']};
		var columnChart1 = new google.visualization.ColumnChart(document.getElementById('barchart1'));
		columnChart1.draw(data, columnTitle1);
	}
	else{
		  var columnTitle2 = {'title':'Categories vs Like-View Ratio', 'width':550, 'height':400, colors:['blue','black']};
		  var columnChart2 = new google.visualization.ColumnChart(document.getElementById('barchart2'));
		  columnChart2.draw(data, columnTitle2);	
	}
	
		}
</script>
</html>
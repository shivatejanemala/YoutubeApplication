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
			<td style="font-style: italic; color: red;">${message}</td>
		</tr>
	</table>
	<div id = "piechart"></div>
	<div id = "barchart"></div>
</body>
<script type = "text/javascript">
google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawChart);

// Draw the chart and set the chart values
function drawChart() {
/*   var data = google.visualization.arrayToDataTable([
  ['Task', 'Hours per Day'],
  ['Work', 8],
  ['Friends', 2],
  ['Eat', 2],
  ['TV', 2],
  ['Gym', 2],
  ['Sleep', 8]
]); */
	
	var data = new google.visualization.DataTable();
	data.addColumn('string','Videos');
	data.addColumn('number','Views');
	
	data.addRows([['Kolavari',1000],['blue eyes',111]]);
  // Optional; add a title and set the width and height of the chart
  var pieTitle = {'title':'Videos-Views', 'width':550, 'height':400};
  var barTitle = {'title':'Videos-Views', 'width':550, 'height':400};
  // Display the chart inside the <div> element with id="piechart" ---for PieChart 
  var piechart = new google.visualization.PieChart(document.getElementById('piechart'));
  	//Display the chart inside the <div> element with id="piechart" -- for BarChart
  	var barchart = new google.visualization.BarChart(document.getElementById('barchart'));
  piechart.draw(data, pieTitle);
  barchart.draw(data, barTitle);
}
</script>
</html>
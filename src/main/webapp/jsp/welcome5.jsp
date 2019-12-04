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
<body style="background-color:#F5F5DB">
	<table class="welcome">
		<tr>
			<td style="padding-right:500px;padding-left:400px">${message}</td>
			<td><div onclick="goHome()">Home</div></td>
		</tr>
   </table>
	
	<div id = "piechart"></div>
	<table id = "headTable" style="padding-top:30px">
	<tr>
	<td style="padding-right: 250px">
		<table id = "categoryTable" style="display:inline-block;border-collapse: collapse; width:200px;height:440px;">
 			<tbody>
 				<tr style="border: 1px solid red">
 					<td style="color:teal;background-color:#d5e1df" >Categories</td>
 				</tr>
 			</tbody>
	 	 </table>
	</td>
	<td>
	<div id = "tableChart"></div>
	</td>
	</tr>
	</table>
 	
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

function drawChart(){
	
	createChart(0);
	}
	
	function createData(){
		var data = new google.visualization.DataTable();
		data.addColumn('string','Category Name');
		data.addColumn('string','Title');
		data.addColumn('number','Days Popular');
		return data;
	}
	
	var dataTables=[];
	
	
function createChart(id){
	var jsonData= JSON.parse(document.getElementById('categoryData').innerHTML);
	var queryType= document.getElementById('queryType').innerHTML;
		if(id == 1){
			jsonData = jsonData.secondList;
		}
		else{
			jsonData = jsonData.primaryList;
		}
		var categoryList = [];
	for (var i = 0; i < jsonData.length; i++) {
		var DaysPopular = jsonData[i].DaysPopular;
		var Video_url = jsonData[i].Video_url;
		var CategoryName = jsonData[i].CategoryName;
			CategoryName = CategoryName.toString();
			CategoryName = CategoryName.replace(/\&amp;/g,'and');
		var Title = jsonData[i].Title;
			Title = Title.toString();
			Title = Title.replace(/\&amp;/g,' and ');
		if(categoryList.includes(CategoryName)){
			var index = categoryList.indexOf(CategoryName);
			var dataArray = dataTables[index];
			
			var dataObject = Object();
			dataObject.cName = CategoryName;
			dataObject.Title = Title;
			dataObject.DaysPopular = DaysPopular;
			dataObject.Video_url = Video_url;
			
			dataArray.push(dataObject);
			dataTables[index] = dataArray;
		}
		else{
			categoryList.push(CategoryName);
			data = [];
			var dataObject = Object();
			dataObject.cName = CategoryName;
			dataObject.Title = Title;
			dataObject.DaysPopular = DaysPopular;
			dataObject.Video_url = Video_url;
			var dataArray = [];
			dataArray.push(dataObject);
			dataTables.push(dataArray);
			;
		}
		
    }
	
	for (var j = 0 ; j < categoryList.length ; j++){
		var table = document.getElementById("categoryTable");
		var row = table.insertRow(j+1);
		row.style.border= "1px solid red";
		var cell = row.insertCell(0);
		cell.innerHTML = '<div style="color:teal;background-color:#d5e1df" onclick="showTable('+ j+ ')" >'+ categoryList[j]+'</div>';
	}
	showTable(0);
		/* var headTable = document.getElementById("headTable");
		var headRow = headTable.rows[0];
		var headCell = headRow.insertCell(1);
		var infoTable = document.createElement('TABLE');
		var rowHeading = infoTable.insertRow(0);
		rowHeading.style.border = "1px solid red";
		var headingCell0 = rowHeading.insertCell(0);
		headingCell0.innerHTML = "Category Name";
		headingCell0.style.borderRight=": 1px solid red";
		var headingCell1 = rowHeading.insertCell(1);
		headingCell1.innerHTML = "Title";
		headingCell1.style.borderRight=": 1px solid red";
		var headingCell2 = rowHeading.insertCell(2);
		headingCell2.innerHTML = "Days Popular";
		headingCell1.style.borderRight=": 1px solid red";
		headCell.appendChild(infoTable); */
			  }
function showTable(id){
	var categoryDiv = document.getElementById("categoryInfoTable");
	var dataArray = dataTables[id];
	var table = headTable.rows[0].cells[1].getElementsByTagName("TABLE")[0];
	/* for(var i = 1; i < table.rows.length; i++){
		table.rows[i].innerHTML = "";
	}
	for(var k = 1 ; k <= dataArray.length ; k ++){
		var dataInfo = dataArray[k-1];
		var row = table.insertRow(k);
		var cell0 = row.insertCell(0);
		cell0.innerHTML = dataInfo.cName;
		var cell1 = row.insertCell(1);
		cell1.innerHTML = dataInfo.Title;
		var cell1 = row.insertCell(2);
		cell1.innerHTML = dataInfo.DaysPopular;
		
	} */
	var data = createData();
	for ( var i = 0 ; i<dataArray.length;i++){
		var dataInfo = dataArray[i];
		var cName = dataInfo.cName;
		var Title = dataInfo.Title;
		var DaysPopular = dataInfo.DaysPopular;
		data.addRow([cName, Title, parseInt(DaysPopular,10)]);
	}	
	var columnTitle = {'title':'Most Viewed Categories', 'width':550, 'height':400, colors:['blue','black']};
	var table = new google.visualization.Table(document.getElementById('tableChart'));
	table.draw(data,columnTitle);
	}

</script>
</html>
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
	<div id = "tableChart1" style="float:left; padding-right:28px;padding-top:10px"></div>
	<div id = "tableChart2" style="float:left; padding-right:28px;padding-top:10px"></div>
	<div id = "tableChart3" style="float:left; padding-right:28px;padding-top:10px"></div>
	<div id = "tableChart4" style="float:left; padding-right:28px;padding-top:10px"></div>
	<div id = "tableChart5" style="float:left; padding-right:28px;padding-top:10px"></div>
	<div id = "tableChart6" style="float:left; padding-right:28px;padding-top:10px"></div>
	<div id = "tableChart7" style="float:left; padding-right:28px;padding-top:10px"></div>
	<div id = "tableChart8" style="float:left; padding-right:28px;padding-top:10px"></div>
	<div id = "tableChart9" style="float:left; padding-right:28px;padding-top:10px"></div>
	<div id = "tableChart10" style="float:left; padding-right:28px;padding-top:10px"></div>
	<div id = "tableChart11" style="float:left; padding-right:28px;padding-top:10px"></div>
	<div id = "tableChart12" style="float:left; padding-right:28px;padding-top:10px"></div>
	<div id = "tableChart13" style="float:left; padding-right:28px;padding-top:10px"></div>
	<div id = "tableChart14" style="float:left; padding-right:28px;padding-top:10px"></div>
	<div id = "tableChart15" style="float:left; padding-right:28px;padding-top:10px"></div>
	<div id = "tableChart16" style="float:left; padding-right:28px;padding-top:10px"></div>
	<div id = "tableChart17" style="float:left; padding-right:28px;padding-top:10px"></div>
	<div id = "tableChart18" style="float:left; padding-right:28px;padding-top:10px"></div>
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
	var data = createData();
	createChart(data,0);
	}
	
	function createData(){
		var data = new google.visualization.DataTable();
		data.addColumn('string','Video URL');
		data.addColumn('string','Category Name');
		data.addColumn('string','Title');
		data.addColumn('number','Days Popular');
		return data;
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
		var dataTables=[];
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
		var data;
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
	
	  for(var i = 0 ; i < dataTables.length;i++){
		  var dataArray = dataTables[i]; 
		  var table = document.createElement("TABLE");
		 /*  var header = table.createTHead();
		  var row = header.insertRow(0);
		  var cell = row.insertCell(0);
		  cell.innerHTML = "<b>" + dataArray[0].cName+"</b>"; */

		  for(var j = 0; j < dataArray.length;j++ ){
			  var rowTable = table.insertRow(j);
			  var cell0 = rowTable.insertCell(0);
			  cell0.innerHTML = '<a href="'+ dataArray[j].Video_url + '">'+ dataArray[j].Video_url +"</a>"
			 
			  cell0.style.border = "1px solid black";
			  var cell1 = rowTable.insertCell(1);
			  cell1.innerHTML = dataArray[j].cName; 
			  cell1.style.border = "1px solid black";
			  var cell2 = rowTable.insertCell(2);
			  cell2.innerHTML =  dataArray[j].Title;
			  cell2.style.border = "1px solid black";
			  var cell3 = rowTable.insertCell(3);
			  cell3.innerHTML = dataArray[j].DaysPopular;
			  cell3.style.border = "1px solid black";
		  }
		   
		  document.getElementById('tableChart'+(i+1)).appendChild(table);
	  }
}
</script>
</html>
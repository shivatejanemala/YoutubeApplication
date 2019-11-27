<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>UTrends</title>
</head>
<body style="background-color:#F5F5DB">
<h1 style="margin-left:550px">Welcome to UTrends</h1>
<div style="margin-left:550px;margin-bottom:40px"> Please select the countries for Analysis</div>

 <div id = "countryBox" style="margin-bottom:50px">
 <table style = "display:inline-block;border: 1px solid red;width:200px;height:240px;background-color:white">
 	<tr>
 		<td>About</td>
 	</tr>
 	<tr>
 		<td>This is a youtube Trending application Which can be used to identify the patterns in the data of trending videos for about 5 countries across 12 months</td>
 	</tr>
 	
 </table>
 
 <table style="margin-left:300px;display:inline-block;">
 	<tr>
 		<td style="width: 295px;height: 70px;border: 1px solid blue;font-family: Georgia, serif;font-size: x-large;text-align: center;background-color: white;" onclick = "selectCountries(1,this);"> France</td>
 		<td style="width: 295px;height: 70px;border: 1px solid blue;font-family: Georgia, serif;font-size: x-large;text-align: center;background-color: white;" onclick = "selectCountries(2,this);">Canada</td>
 	</tr>
 	<tr>
 		<td style="width: 295px;height: 70px;border: 1px solid blue;font-family: Georgia, serif;font-size: x-large;text-align: center;background-color: white;" onclick = "selectCountries(3,this);">United States</td>
 		<td style="width: 295px;height: 70px;border: 1px solid blue;font-family: Georgia, serif;font-size: x-large;text-align: center;background-color: white;" onclick = "selectCountries(4,this);">Great Britain</td>
 	</tr>
 	<tr>
 		<td style="width: 295px;height: 70px;border: 1px solid blue;font-family: Georgia, serif;font-size: x-large;text-align: center;background-color: white;" onclick = "selectCountries(5,this);">Germany</td>
 	</tr>
 </table>
 
 </div>
 <div id = "countryList" style = "display:none;" ></div>
<div id = "CountryReg" style = "margin-left:750px;width:95px; height: 30px; border: 1px solid blue;text-align:center;background-color: white;" onclick= "setCountryList()">Enter</div>
<!-- <div><a href="register">Register</a></div> -->
</body>
<script>
function selectCountries(country,el){
	console.log('Countries added');
	var countryList = document.getElementById('countryList').innerHTML.split(',');
	if(countryList.includes(country.toString())){
		for( var i = 0; i < countryList.length; i++){ 
			   if ( countryList[i] === country.toString()) {
				   countryList.splice(i, 1); 
			   }
			}
		el.style.backgroundColor = "white";
	}else{
		countryList.push(country);
		el.style.backgroundColor = "blue";
	}
	var countryName = "";
	for(var i = 0;i< countryList.length;i++){
		var a = countryList[i];
		if (a != ""){
			countryName +=(a+",");
		}
	}

	document.getElementById('countryList').innerHTML = countryName;
	/* document.getElementById('CountryReg').children[0].href += '?countryList='+countryList.toString(); */

}
function setCountryList(country){
	if(document.getElementById('countryList').innerHTML == ""){
		alert("PLEASE SELECT ATLEAST ONE COUNTRY");
	}
	else{
		window.location.href +="/login?countryList="+document.getElementById('countryList').innerHTML;
	}
}
</script>
</html>
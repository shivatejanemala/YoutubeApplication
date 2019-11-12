<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>UTrends</title>
</head>
<body>
<h1 style="margin-left:550px">Welcome to UTrends</h1>
<div style="margin-left:550px;margin-bottom:40px"> Please select the countries for Analysis</div>
<!-- <select id = "countryID" multiple>
<option value = "1">India</option>
<option value = "2">Canada</option>
<option value = "3">United States</option>
<option value = "4">France</option>
</select> -->
<!-- <button type = "button" onclick = "selectCountries();">Select</button>
 -->
 <div id = "countryBox" style="margin-bottom:50px">
 <table style="margin-left:600px">
 	<tr>
 		<td style="width:95px; height: 30px; border: 1px solid blue;" onclick = "selectCountries(1);"> France</td>
 		<td style="width:95px; height: 30px; border: 1px solid blue;" onclick = "selectCountries(2);">Canada</td>
 	</tr>
 	<tr>
 		<td style="width:95px; height: 30px; border: 1px solid blue;" onclick = "selectCountries(3);">United States</td>
 		<td style="width:95px; height: 30px; border: 1px solid blue;" onclick = "selectCountries(4);">Great Britain</td>
 	</tr>
 	<tr>
 		<td style="width:95px; height: 30px; border: 1px solid blue;" onclick = "selectCountries(5);">Germany</td>
 	</tr>
 </table>
 <!-- <div id = "FranceBox" style = "width:55px; border: 1px solid blue;">
 France
 </div>
  <div id = "CanadaBox" style = "width:55px; border: 1px solid blue;">
 Canada
 </div>
  <div id = "USBox" style = "width:55px; border: 1px solid blue;">
 United States
 </div>
  <div id = "GBBox" style = "width:55px; border: 1px solid blue;">
 Great Britain
 </div>
  <div id = "germanyBox" style = "width:55px; border: 1px solid blue;">
 Germany
 </div> -->
 </div>
 <div id = "countryList" style = "display:none;" ></div>
	
			<!-- <div id = "CountryReg"><a href="login">Enter</a></div> -->
		<div id = "CountryReg" onclick= "setCountryList()">Enter</div>
</body>
<script>
function selectCountries(country){
	console.log('Countries added');
	var countryList = document.getElementById('countryList').innerHTML.split(',');
	if(countryList.includes(country.toString())){
		for( var i = 0; i < countryList.length; i++){ 
			   if ( countryList[i] === country.toString()) {
				   countryList.splice(i, 1); 
			   }
			}
	}else{
		countryList.push(country);
	}
	document.getElementById('countryList').innerHTML = countryList;
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
/* window.onmousedown = function (e) {
    var el = e.target;
    if (el.tagName.toLowerCase() == 'option' && el.parentNode.hasAttribute('multiple')) {
        e.preventDefault();

        // toggle selection
        if (el.hasAttribute('selected')) el.removeAttribute('selected');
        else el.setAttribute('selected', '');

        // hack to correct buggy behavior
        var select = el.parentNode.cloneNode(true);
        el.parentNode.parentNode.replaceChild(select, el.parentNode);
    }
} */
</script>
</html>
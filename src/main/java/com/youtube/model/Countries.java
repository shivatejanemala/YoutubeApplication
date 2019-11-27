package com.youtube.model;

import java.util.HashMap;

public class Countries {

     

	  private int countryid;
	  private String name;
	  HashMap<String,String> countryList = new HashMap<String,String>();  
	
	public int getCountryid() {
		return countryid;
	}
	public void setCountryid(int countryid) {
		this.countryid = countryid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	 
	public HashMap<String,String> getCountryList() {
		countryList.put("1", "\'CANADA\'");
		countryList.put("2", "\'UNITED STATES\'");
		countryList.put("3", "\'GREAT BRITAIN\'");
		countryList.put("4", "\'GERMANY\'");
		countryList.put("5", "\'FRANCE\'");
		return countryList;
	}

}

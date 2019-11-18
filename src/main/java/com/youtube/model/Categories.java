package com.youtube.model;

public class Categories {



	  public Categories(int categoryid, String name) {
		super();
		this.categoryid = categoryid;
		this.name = name;
	}
	private int categoryid;
	  private String name;
	  
	public int getCategoryid() {
		return categoryid;
	}
	public void setCategoryid(int categoryid) {
		this.categoryid = categoryid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	 

}

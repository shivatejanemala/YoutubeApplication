package com.youtube.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;

import com.youtube.model.Videos;
import com.youtube.model.query5;
import com.youtube.dao.VideoDAOImpl;
import com.youtube.dao.VideoDAO;
import com.youtube.model.Channels;


public class VideoServiceImpl implements VideoDAO{

	  @Autowired
	  public VideoDAO videoDao;
	  
	  public void register(Videos video) {
	    videoDao.register(video);
	  }

	  public Videos validateUser(Channels channel) {
	    return videoDao.validateUser(channel);
	  }
	  
	  public HashMap<String,Integer> dataQuery1() throws SQLException {
		  VideoDAOImpl tdCat = new VideoDAOImpl();
		    return tdCat.Query1();
		  }
	  
	  public ArrayList<query5> dataQuery5() throws SQLException {
		  VideoDAOImpl tdCat = new VideoDAOImpl();
		           //  Query4CntWise(countries);
		    return tdCat.Query5();
		  }
	  
	  public HashMap<String,String> dataQuery4() throws SQLException {
		  VideoDAOImpl tdCat = new VideoDAOImpl();
		           //  Query4CntWise(countries);
		    return tdCat.Query4();
		  }
	  public HashMap<String,String> dataQuery4CW(String countries) throws SQLException {
		  VideoDAOImpl tdCat = new VideoDAOImpl();
		           //  Query4CntWise(countries);
		    return tdCat.Query4CntWise(countries);
		  }
	  public HashMap<String,String> dataChannels(String countries) throws SQLException {
		  VideoDAOImpl tdCat = new VideoDAOImpl();
		    return tdCat.Query3(countries); 
		  }
	  public HashMap<String,String> dataQuery2Part2(String countries) throws SQLException {
		  VideoDAOImpl tdCat = new VideoDAOImpl();
		    return tdCat.Query2Part2(countries); 
		  }
	  public HashMap<String,String> dataQuery2(String countries) throws SQLException {
		  VideoDAOImpl tdCat = new VideoDAOImpl();
		    return tdCat.Query2(countries); 
		  }
	  public HashMap<String,String> dataQuery7(String countries) throws SQLException {
		  VideoDAOImpl tdCat = new VideoDAOImpl();
		    return tdCat.Query7(countries); 
		  }
}

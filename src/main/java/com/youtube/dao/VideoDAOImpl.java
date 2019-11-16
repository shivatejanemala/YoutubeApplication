package com.youtube.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.youtube.model.*;
public class VideoDAOImpl implements VideoDAO {

  @Autowired
  DataSource datasource;
	
 

  public void register(Videos user) {
	  System.out.println("Creating register fn");
    String sql = "insert into users values(?,?,?,?,?,?,?)";
    
    /*JdbcTemplate jdbcTemplate = createJdbcTemplate();
    jdbcTemplate.update(sql, new Object[] { user.getUsername(), user.getPassword(), user.getFirstname(),
        user.getLastname(), user.getEmail(), user.getAddress(), user.getPhone() });*/
  }

  private JdbcTemplate createJdbcTemplate() {
	  System.out.println("Creating datasource");
	  return new JdbcTemplate(datasource);
  }
  
  
  public Videos validateUser(Channels login) {
	  System.out.println("Creating Validate User fn");
	  JdbcTemplate jdbcTemplate = createJdbcTemplate();
    String sql = "select * from Country";
    Videos video = null;
    try {
   Connection conn = datasource.getConnection();
   System.out.println("DB Connection successfully established");
   PreparedStatement ps = conn.prepareStatement(sql);
	ResultSet rs = ps.executeQuery();
	if(rs.next()) {
		System.out.println("Query executed Successfully");
		 video = new Videos(); 
	}
	rs.close();
	conn.close();
    }
    catch(Exception e) {
    	System.out.println("SQL ERROR FOUND __--"+e);
    }
    
	return video;
}
  
  public HashMap<String,Integer> Query4(List<String> countries){
		 HashMap<String,Integer> result = new HashMap<String,Integer>();
		    String sql = "select * from Category  where rownum <=10;";
		    System.out.println("outside Query4"+sql);
		    try {
		    	System.out.println("inside Query4");
		    Connection conn = datasource.getConnection();
		    System.out.println("DB Connection successfully established");
		    PreparedStatement ps = conn.prepareStatement(sql);
		 	ResultSet rs = ps.executeQuery();
		 	System.out.println("after ps Query4");
		 	if(rs.next()) {
		 		System.out.println("Query executed Successfully");
		 		result.put(rs.getString("CATEGORY_NAME"),rs.getInt("CATEGORY_ID"));
		 	}
		 	rs.close();
			conn.close();
		    }catch(Exception e) {
		    	System.out.println("SQL ERROR FOUND __--"+e);
		    }
		     
		return result;
	 }

}
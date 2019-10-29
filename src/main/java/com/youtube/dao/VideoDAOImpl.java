package com.youtube.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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

    JdbcTemplate jdbcTemplate = createJdbcTemplate();
    jdbcTemplate.update(sql, new Object[] { user.getUsername(), user.getPassword(), user.getFirstname(),
        user.getLastname(), user.getEmail(), user.getAddress(), user.getPhone() });
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
    }
    catch(Exception e) {
    	System.out.println("SQL ERROR FOUND __--"+e);
    }
	return video;
}

class VideoMapper implements RowMapper<Videos> {

  public Videos mapRow(ResultSet rs, int arg1) throws SQLException {
    Videos video = new Videos();

    video.setUsername(rs.getString("username"));
    video.setPassword(rs.getString("password"));
    video.setFirstname(rs.getString("firstname"));
    video.setLastname(rs.getString("lastname"));
    video.setEmail(rs.getString("email"));
    video.setAddress(rs.getString("address"));
    video.setPhone(rs.getInt("phone"));

    return video;
  }
}
}
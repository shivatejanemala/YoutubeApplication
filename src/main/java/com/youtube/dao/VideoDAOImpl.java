package com.youtube.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

import com.youtube.model.Channels;
import com.youtube.model.Videos;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;



public class VideoDAOImpl {
	 @Autowired
	  DataSource datasource;

	  @Autowired
	  JdbcTemplate jdbcTemplate;
	  
	  public void register(Videos video) {

		    String sql = "insert into videos values(?,?,?,?,?,?,?)";

		    jdbcTemplate.update(sql, new Object[] { video.getUsername(), video.getPassword(), video.getFirstname(),
		    		video.getLastname(), video.getEmail(), video.getAddress(), video.getPhone() });
		  }

		  public Videos validateUser(Channels channel) {

		    String sql = "select * from Channels where username='" + channel.getUsername() + "' and password='" + channel.getPassword()
		        + "'";

		    List<Videos> users = jdbcTemplate.query(sql, new VideoMapper());

		    return users.size() > 0 ? users.get(0) : null;
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

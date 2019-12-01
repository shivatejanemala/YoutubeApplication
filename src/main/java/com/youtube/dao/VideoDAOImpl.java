package com.youtube.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
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
 
  HashMap<String,String> countryList = new HashMap<String,String>();

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
  
  public String countryNames(String countryId) {
	  List<String> items = Arrays.asList(countryId.split("\\s*,\\s*"));
	  String res = "";
	  Countries cn = new Countries();
	  HashMap<String,String> cRet = new HashMap<String,String>();
	  cRet = cn.getCountryList();
	  for(String i:items) {
		String temp =  cRet.get(i);
		  res = res+","+temp;
	  }
	  res = res.substring(1);
	  return res;
  }
  
  public HashMap<String,String> Query4() throws SQLException{
		 HashMap<String,String> result = new HashMap<String,String>();
		 DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
		    String sql = "SELECT CATEGORY_NAME,COUNT(DISTINCT VIDEO_ID) as cnt FROM VIDEOS V JOIN CATEGORY C ON V.CATEGORY_ID = C.CATEGORY_ID GROUP BY CATEGORY_NAME ORDER BY cnt desc ";
		    System.out.println("outside Query4"+sql);
		    try {
		    	System.out.println("inside Query4");
    	 Connection conn =  DriverManager.getConnection("jdbc:oracle:thin:@oracle.cise.ufl.edu:1521:orcl", "spujitha", "ciseORC4");
		    System.out.println("DB Connection successfully established");
		    PreparedStatement ps = conn.prepareStatement(sql);
		 	ResultSet rs = ps.executeQuery();
		 	System.out.println("after ps Query4");
		 	while(rs.next()) {
		 		System.out.println("Query executed Successfully");
		 		result.put(rs.getString("CATEGORY_NAME"),String.valueOf(rs.getInt("cnt")));
		 	}
		 	rs.close();
			conn.close();
		    }catch(Exception e) {
		    	System.out.println("SQL ERROR FOUND __--"+e);
		    }
		     
		return result;
	 }
  
  public HashMap<String,String> Query4CntWise(String countries) throws SQLException{
		 HashMap<String,String> result = new HashMap<String,String>();
		 DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
		 String inp  = countries.substring(1);
		 System.out.println("input Query4CntWise"+inp);
		    String sql = "with category_country as (SELECT COUNTRY_NAME, CATEGORY_NAME ,COUNT(DISTINCT VIDEO_ID) cnt ,RANK() OVER(partition by country_name ORDER BY COUNT(DISTINCT VIDEO_ID) DESC) rnk FROM VIDEOS V JOIN CATEGORY C ON V.CATEGORY_ID = C.CATEGORY_ID JOIN COUNTRY CR ON V.COUNTRY_ID = CR.COUNTRY_ID GROUP BY COUNTRY_NAME, CATEGORY_NAME )select COUNTRY_NAME, CATEGORY_NAME, cnt, rnk from category_country"
		    		+ " where rnk < 6 AND COUNTRY_NAME IN ("+countryNames(countries)+")";
		    System.out.println("outside Query4Cw"+sql);
		    try {
		    	System.out.println("inside Query4Cw");
 	 Connection conn =  DriverManager.getConnection("jdbc:oracle:thin:@oracle.cise.ufl.edu:1521:orcl", "spujitha", "ciseORC4");
		    System.out.println("DB Connection successfully established");
		    PreparedStatement ps = conn.prepareStatement(sql);
		 	ResultSet rs = ps.executeQuery();
		 	System.out.println("after ps Query4Cw");
		 	while(rs.next()) {
		 		System.out.println("Query4Cw executed Successfully");
		 		result.put(rs.getString("CATEGORY_NAME"),String.valueOf(rs.getInt("cnt")));
		 		
		 	}
		 	rs.close();
			conn.close();
		    }catch(Exception e) {
		    	System.out.println("SQL ERROR FOUND __--"+e);
		    }
		     
		return result;
	 }

  public HashMap<String,String> Query3(String countries) throws SQLException{
		 HashMap<String,String> result = new HashMap<String,String>();
		 DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
		 String inp  = countries.substring(1);
		 System.out.println("input Query3"+inp);
		    String sql = "with channel_country as \r\n" + 
		    		"(\r\n" + 
		    		"SELECT CR.COUNTRY_NAME, C.CHANNEL_TITLE ,COUNT(DISTINCT VIDEO_ID) cnt ,\r\n" + 
		    		"RANK() OVER(partition by country_name ORDER BY COUNT(DISTINCT VIDEO_ID) DESC) rnk\r\n" + 
		    		"FROM VIDEOS V JOIN \r\n" + 
		    		"CHANNELS C ON V.CHANNEL_ID = C.CHANNEL_ID JOIN\r\n" + 
		    		"COUNTRY CR ON V.COUNTRY_ID = CR.COUNTRY_ID \r\n" + 
		    		"GROUP BY COUNTRY_NAME, C.CHANNEL_TITLE\r\n" + 
		    		")\r\n" + 
		    		"select COUNTRY_NAME, CHANNEL_TITLE, cnt, rnk \r\n" + 
		    		"from channel_country \r\n" + 
		    		"where rnk < 6\r\n" + 
		    		"AND COUNTRY_NAME IN ("+countryNames(inp)+")\r\n" + 
		    		"";
		    System.out.println("outside Query3"+sql);
		    try {
		    	System.out.println("inside Query3");
	 Connection conn =  DriverManager.getConnection("jdbc:oracle:thin:@oracle.cise.ufl.edu:1521:orcl", "spujitha", "ciseORC4");
		    System.out.println("DB Connection successfully established");
		    PreparedStatement ps = conn.prepareStatement(sql);
		 	ResultSet rs = ps.executeQuery();
		 	System.out.println("after ps Query3");
		 	while(rs.next()) {
		 		System.out.println("Query executed Successfully");
		 		result.put(rs.getString("CHANNEL_TITLE"),String.valueOf(rs.getInt("cnt")));
		 	}
		 	rs.close();
			conn.close();
		    }catch(Exception e) {
		    	System.out.println("SQL ERROR FOUND __--"+e);
		    }
		     
		return result;
	 }

  public ArrayList<query5> Query5() throws SQLException{
		 ArrayList<query5> result = new ArrayList<query5>();
		 DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
		// String inp  = countries.substring(1);
		// System.out.println("input Query5"+inp);
		    String sql = "SELECT CATEGORY_NAME, TITLE, CNT AS DAYS_POPULAR, RNK FROM\r\n" + 
		    		"(\r\n" + 
		    		"SELECT CATEGORY_NAME, TITLE, COUNT(TRENDING_DT) CNT,\r\n" + 
		    		"RANK() OVER(partition by CATEGORY_NAME ORDER BY COUNT(TRENDING_DT) DESC) rnk\r\n" + 
		    		"FROM VIDEOS v join CATEGORY c on v.CATEGORY_ID = c.CATEGORY_ID\r\n" + 
		    		"GROUP BY CATEGORY_NAME, TITLE\r\n" + 
		    		")\r\n" + 
		    		"WHERE rnk <= 5\r\n" + 
		    		"ORDER BY CATEGORY_NAME, RNK ASC\r\n" + 
		    		"";
		    System.out.println("outside Query5"+sql);
		    try {
		    	System.out.println("inside Query5");
	 Connection conn =  DriverManager.getConnection("jdbc:oracle:thin:@oracle.cise.ufl.edu:1521:orcl", "spujitha", "ciseORC4");
		    System.out.println("DB Connection successfully established");
		    PreparedStatement ps = conn.prepareStatement(sql);
		 	ResultSet rs = ps.executeQuery();
		 	System.out.println("after ps Query5");
		 	while(rs.next()) {
		 		query5 q = new query5();
		 		System.out.println("Query5 executed Successfully");
		 		q.setDaysPop(rs.getInt("DAYS_POPULAR"));
		 		q.setName(rs.getString("CATEGORY_NAME"));
		 		q.setTitle(rs.getString("TITLE"));
		 	//	q.setVideo_id("https://www.youtube.com/watch?v="+rs.getString("VIDEO_ID"));
		 		q.setVideo_id("https://www.youtube.com/watch?v=ocZqvs7gUzc");
		 		result.add(q);
		 		
		 	}
		 	rs.close();
			conn.close();
		    }catch(Exception e) {
		    	System.out.println("SQL ERROR FOUND __--"+e);
		    }
		     
		return result;
	 }
  
  public HashMap<String,Integer> Query1() throws SQLException{
		HashMap<String,Integer> result = new HashMap<String,Integer>();
		 DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
		    String sql = "SELECT C.COUNTRY_NAME,SUM(C.CNT)as \"NO_OF_POPULAR_VIDEOS\" FROM (SELECT COUNTRY_NAME, VIDEO_ID, COUNT(DISTINCT TRENDING_DT) CNT\r\n" + 
		    		"FROM VIDEOS v join country c on v.country_id = c.country_id\r\n" + 
		    		"GROUP BY COUNTRY_NAME, VIDEO_ID\r\n" + 
		    		"ORDER BY CNT DESC)C GROUP BY COUNTRY_NAME";
		    System.out.println("outside Query1"+sql);
		    try {
		    	System.out.println("inside Query1");
	Connection conn =  DriverManager.getConnection("jdbc:oracle:thin:@oracle.cise.ufl.edu:1521:orcl", "spujitha", "ciseORC4");
		    System.out.println("DB Connection successfully established");
		    PreparedStatement ps = conn.prepareStatement(sql);
		 	ResultSet rs = ps.executeQuery();
		 	System.out.println("after ps Query1");
		 	while(rs.next()) {
		 		System.out.println("Query1 executed Successfully");
		 		result.put(rs.getString("COUNTRY_NAME"),rs.getInt("NO_OF_POPULAR_VIDEOS"));
		 		
		 	}
		 	rs.close();
			conn.close();
		    }catch(Exception e) {
		    	System.out.println("SQL ERROR FOUND __--"+e);
		    }
		     
		return result;
	}    
  
  public HashMap<String,String> Query2(String countries) throws SQLException{
		 HashMap<String,String> result = new HashMap<String,String>();
		 DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
		 String inp  = countries.substring(1);
		 System.out.println("input Query2"+inp);
		    String sql = "select title,ct from\r\n" + 
		    		"(SELECT TITLE,COUNT(DISTINCT COUNTRY_NAME) CT\r\n" + 
		    		"FROM VIDEOS v join country c on v.country_id = c.country_id\r\n" + 
		    		"GROUP BY TITLE\r\n" + 
		    		"HAVING COUNT(DISTINCT COUNTRY_NAME) = 3\r\n" + 
		    		"ORDER BY CT DESC ) subq\r\n" + 
		    		"where rownum<6\r\n" + 
		    		"";
		    System.out.println("outside Query2"+sql);
		    try {
		    	System.out.println("inside Query2");
		    	Connection conn =  DriverManager.getConnection("jdbc:oracle:thin:@oracle.cise.ufl.edu:1521:orcl", "spujitha", "ciseORC4");
		    System.out.println("DB Connection successfully established");
		    PreparedStatement ps = conn.prepareStatement(sql);
		 	ResultSet rs = ps.executeQuery();
		 	System.out.println("after ps Query2");
		 	while(rs.next()) {
		 		System.out.println("Query executed Successfully");
		 		result.put(rs.getString("TITLE"),String.valueOf(rs.getInt("ct")));
		 	}
		 	rs.close();
			conn.close();
		    }catch(Exception e) {
		    	System.out.println("SQL ERROR FOUND __--"+e);
		    }
		     
		return result;
	 }
  public HashMap<String,String> Query2Part2(String countries) throws SQLException{
		 HashMap<String,String> result = new HashMap<String,String>();
		 DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
		String inp  = ""+countries+"";
	 
	    String finalinput=inp.replace("'","\"");
	    String quotedX = quote(countries.substring(0,8)+"%");
		 System.out.println("input Query2"+countries);
		    String sql = "select country_name,sum(ct)as count from (SELECT a.Country_name ,\r\n" + 
		    		"    COUNT(DISTINCT a.trending_dt) CT\r\n" + 
		    		"FROM\r\n" + 
		    		"    ( SELECT\r\n" + 
		    		"           v. title,v.trending_dt,c.Country_name         \r\n" + 
		    		"        FROM\r\n" + 
		    		"            VIDEOS    v,\r\n" + 
		    		"            COUNTRY   c\r\n" + 
		    		"        WHERE\r\n" + 
		    		"            v.COUNTRY_ID = c.COUNTRY_ID and v.title like "+quotedX+"  ) a\r\n" + 
		    		"GROUP BY\r\n" + 
		    		"    a.title,a.country_name)\r\n" + 
		    		"    group by country_name";
		    System.out.println("outside Query2Part2"+sql);
		    try {
		    	System.out.println("inside Query2Part2");
	 Connection conn =  DriverManager.getConnection("jdbc:oracle:thin:@oracle.cise.ufl.edu:1521:orcl", "spujitha", "ciseORC4");
		    System.out.println("DB Connection successfully established");
		    PreparedStatement ps = conn.prepareStatement(sql);
		 	ResultSet rs = ps.executeQuery();
		 	System.out.println("after ps Query2Part2");
		 	while(rs.next()) {
		 		System.out.println("Query executed Successfully");
		 		result.put(rs.getString("COUNTRY_NAME"),String.valueOf(rs.getInt("count")));
		 	
		 	}
		 	rs.close();
			conn.close();
		    }catch(Exception e) {
		    	System.out.println("SQL ERROR FOUND __--"+e);
		    }
		     
		return result;
	 }
public static String quote(String s) {
	    return new StringBuilder()
	        .append('\'')
	        .append(s)
	        .append('\'')
	        .toString();
	}
}
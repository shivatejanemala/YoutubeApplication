package com.youtube.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import com.youtube.model.Channels;
import com.youtube.model.Videos;
import com.youtube.model.query5;
import com.youtube.service.VideoServiceImpl;



@Controller
public class YoutubeController {
	
	public static String cntryList;
 
	  @Autowired
	  VideoServiceImpl videoService;
	  

	  @RequestMapping(value = "/login", method = RequestMethod.GET)
	  public ModelAndView showLogin(HttpServletRequest request, HttpServletResponse response, @RequestParam(required=false) String countryList) {
	    ModelAndView mav = new ModelAndView("login");
	    cntryList = countryList;
	    mav.addObject("message","Youtube Trending Analysis");
	    System.out.println("countryList- "+countryList);
	    String json = "[{\"videos\":\"Kolavari\",\"views\":1000},{\"videos\":\"blue eyes\",\"views\":150}]";
	    Videos video = new Videos();
	    video.setCategoryid(1);
	    video.setTitle("Youtube Title");
	    mav.addObject("chartData",json);
	    return mav;
	  }

	  @RequestMapping(value = "/register", method = RequestMethod.GET)
	  public ModelAndView loginProcess(HttpServletRequest request, HttpServletResponse response,
	      @ModelAttribute("login") Channels login) {
	    ModelAndView mav = null;

	    Videos videos = videoService.validateUser(login);

	    if (null != videos) {
	      mav = new ModelAndView("welcome");
	      mav.addObject("firstname", videos.getTitle());
	    } else {
	      mav = new ModelAndView("login");
	      mav.addObject("message", "Username or Password is wrong!!");
	    }
	    return mav;
	  }
	  
	  @RequestMapping(value = "/home", method = RequestMethod.GET)
	  public ModelAndView goHome(HttpServletRequest request, HttpServletResponse response,
	      @ModelAttribute("login") Channels login) {
	    ModelAndView mav = null;

	    Videos videos = videoService.validateUser(login);

	      mav = new ModelAndView("home");
	      mav.addObject("firstname", videos.getTitle());
	    return mav;
	  }

	  @RequestMapping(value = "/query4", method = RequestMethod.GET)
	  public ModelAndView query4(HttpServletRequest request, HttpServletResponse response) throws SQLException, JSONException {
	    ModelAndView mav = null;
	    System.out.println("Into Query 4 logic");
	  //  System.out.println("countryList:"+cntryList);
	  //  List<String> items = Arrays.asList(cntryList.split("\\s*,\\s*"));
	    JSONObject jObject = new JSONObject();
	    HashMap<String,String> cR1 = videoService.dataQuery4();
	    HashMap<String,String> cR2 = videoService.dataQuery4CW(cntryList);
        Set<String> keySet1 = cR1.keySet();
        Set<String> keySet2 = cR2.keySet();
        JSONArray jArray = new JSONArray();
        for(String key: keySet1){
        	JSONObject cR1JSON = new JSONObject();
        	cR1JSON.put("Categories",key);
        	cR1JSON.put("Videos",cR1.get(key));
        	jArray.put(cR1JSON);
        }
        JSONArray jArrayCW = new JSONArray();
        for(String key: keySet2){
        	JSONObject cR2JSON = new JSONObject();
        	cR2JSON.put("Categories",key);
        	cR2JSON.put("Videos",cR2.get(key));
        	jArrayCW.put(cR2JSON);
        }
        jObject.put("primaryList", jArray);
        jObject.put("secondList", jArrayCW);
        System.out.println("query4 JSON: "+jObject);
	    if ((!cR1.isEmpty()) && (!cR2.isEmpty())) {
	    	System.out.println("data found");
	    	mav = new ModelAndView("welcome4");
	    	 mav.addObject("message", "Youtube Trending Analysis");
	      mav.addObject("categoryData", jObject);
	    } else {
	    	System.out.println("data not found");
	      mav = new ModelAndView("login");
	      mav.addObject("message", "Data doesn't exist!!");
	    }
	    return mav;
	  }
	  
	  
	  @RequestMapping(value = "/query3", method = RequestMethod.GET)
	  public ModelAndView query3(HttpServletRequest request, HttpServletResponse response) throws SQLException, JSONException {
	    ModelAndView mav = null;
	    System.out.println("Into Query 3 logic");
	  //  System.out.println("countryList:"+cntryList);
	  //  List<String> items = Arrays.asList(cntryList.split("\\s*,\\s*"));
	   // List<String> items = Arrays.asList(cn.split("\\s*,\\s*"));
	    JSONObject jObject = new JSONObject();
	    HashMap<String,String> channelRes = videoService.dataChannels(cntryList);
        Set<String> keySet = channelRes.keySet();
        JSONArray jArray = new JSONArray();
        for(String key: keySet){
        	JSONObject channelJSON = new JSONObject();
        	channelJSON.put("Channels",key);
        	channelJSON.put("Videos",channelRes.get(key));
        	jArray.put(channelJSON);
        }
        jObject.put("primaryList", jArray);
        System.out.println("query3 JSON: "+jObject);
	    if (!channelRes.isEmpty()) {
	    	mav = new ModelAndView("welcome3");
	      mav.addObject("channelData", jObject);
	      mav.addObject("message", "Youtube Trending Analysis");
	    } else {
	      mav = new ModelAndView("login");
	      mav.addObject("message", "Data doesn't exist!!");
	    }
	    return mav;
	  }
	  
	  @RequestMapping(value = "/query5", method = RequestMethod.GET)
	  public ModelAndView query5(HttpServletRequest request, HttpServletResponse response) throws SQLException, JSONException {
		  ModelAndView mav = null;
		    System.out.println("Into query5 logic");
		  //  System.out.println("countryList:"+cntryList);
		  //  List<String> items = Arrays.asList(cntryList.split("\\s*,\\s*"));
		   // List<String> items = Arrays.asList(cn.split("\\s*,\\s*"));
		    JSONObject jObject = new JSONObject();
		 //   System.out.println("countryList in query5: "+cntryList);
		    ArrayList<query5> catList = videoService.dataQuery5();
	        JSONArray jArray = new JSONArray();
	        for(query5 key: catList){
	        	JSONObject channelJSON = new JSONObject();
	        	channelJSON.put("DaysPopular",key.getDaysPop());
	        	channelJSON.put("Video_url",key.getVideo_id());
	        	channelJSON.put("CategoryName",key.getName());
	        	channelJSON.put("Title",key.getTitle());
	        	jArray.put(channelJSON);
	        }
	        jObject.put("primaryList", jArray);
	        System.out.println("query5 JSON: "+jObject);
		    if (!catList.isEmpty()) {
		    	mav = new ModelAndView("welcome5");
		    	 mav.addObject("message", "Youtube Trending Analysis");
		      mav.addObject("CategoryVideoList", jObject);
		    } else {
		      mav = new ModelAndView("login");
		      mav.addObject("message", "Data doesn't exist!!");
		    }
		    return mav;
	  }
	  
	  @RequestMapping(value = "/query2", method = RequestMethod.GET)
	  public ModelAndView query2(HttpServletRequest request, HttpServletResponse response) throws SQLException, JSONException {
	    ModelAndView mav = null;
	    System.out.println("Into Query 2 logic");
	  //  System.out.println("countryList:"+cntryList);
	  //  List<String> items = Arrays.asList(cntryList.split("\\s*,\\s*"));
	    String cn= ",1,3";
	   // List<String> items = Arrays.asList(cn.split("\\s*,\\s*"));
	    JSONObject jObject = new JSONObject();
	    HashMap<String,String> query2Res = videoService.dataQuery2(cntryList);
        Set<String> keySet = query2Res.keySet();
        JSONArray jArray = new JSONArray();
        for(String key: keySet){
        	JSONObject query2JSON = new JSONObject();
        	query2JSON.put("VideoTitle",key);
        	//query2JSON.put("VideoId",query2Res.get(key));
        	jArray.put(query2JSON);
        }
        jObject.put("primaryList", jArray);
        System.out.println("query2 JSON: "+jObject);
	    if (!query2Res.isEmpty()) {
	    	mav = new ModelAndView("welcome2");
	    	mav.addObject("message","Youtube Trending Analysis");
	      mav.addObject("query2Data", jObject);
	    } else {
	      mav = new ModelAndView("login");
	      mav.addObject("message", "Data doesn't exist!!");
	    }
	    return mav;
	  }
	  
	  @RequestMapping(value = "/query2part2", method = RequestMethod.GET)
	  public ModelAndView query2Part2(HttpServletRequest request, HttpServletResponse response,@RequestParam(required=false) String videotitle) throws SQLException, JSONException {
	    ModelAndView mav = null;
	    System.out.println("Into Query2Part2 logic");
	  //  System.out.println("countryList:"+cntryList);
	  //  List<String> items = Arrays.asList(cntryList.split("\\s*,\\s*"));
	  //  String cn= "J. Balvin - Ahora";
	   // List<String> items = Arrays.asList(cn.split("\\s*,\\s*"));
	    JSONObject jObject = new JSONObject();
	    System.out.println("Before decoding- "+videotitle);
	    try {
			videotitle = URLDecoder.decode(videotitle,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			System.out.println("Error while decoding");
		}
	    System.out.println("After decoding- "+videotitle);
	    HashMap<String,String> query2Res = videoService.dataQuery2Part2(videotitle);
        Set<String> keySet = query2Res.keySet();
        JSONArray jArray = new JSONArray();
        for(String key: keySet){
        	JSONObject query2JSON = new JSONObject();
        	query2JSON.put("CountryName",key);
        	query2JSON.put("Count",query2Res.get(key));
        	jArray.put(query2JSON);
        }
        jObject.put("primaryList", jArray);
        System.out.println("query2 JSON: "+jObject);
	    if (!query2Res.isEmpty()) {
	    	mav = new ModelAndView("welcome22");
	    	mav.addObject("message","Youtube Trending Analysis");
	      mav.addObject("query2Data", jObject);
	    } else {
	      mav = new ModelAndView("login");
	      mav.addObject("message", "Data doesn't exist!!");
	    }
	    return mav;
	  }
	  
	  @RequestMapping(value = "/query1", method = RequestMethod.GET)
	  public ModelAndView query1(HttpServletRequest request, HttpServletResponse response) throws SQLException, JSONException {
	    ModelAndView mav = null;
	    System.out.println("Into Query1 logic");
	    JSONObject jObject = new JSONObject();
	    HashMap<String,Integer> query1Res = videoService.dataQuery1();
        Set<String> keySet = query1Res.keySet();
        JSONArray jArray = new JSONArray();
        for(String key: keySet){
        	JSONObject query1JSON = new JSONObject();
        	query1JSON.put("CountryName",key);
        	query1JSON.put("PopularVideos",query1Res.get(key));
        	jArray.put(query1JSON);
        }
        jObject.put("primaryList", jArray);
        System.out.println("query1 JSON: "+jObject);
	    if (!query1Res.isEmpty()) {
	    	mav = new ModelAndView("welcome1");
	    	 mav.addObject("message","Youtube Trending Analysis");
	      mav.addObject("query1Data", jObject);
	    } else {
	      mav = new ModelAndView("login");
	      mav.addObject("message", "Data doesn't exist!!");
	    }
	    return mav;
	  }
}

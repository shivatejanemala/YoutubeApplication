package com.youtube.controller;

import java.sql.SQLException;
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
	    String cn= ",1,3";
	    List<String> items = Arrays.asList(cn.split("\\s*,\\s*"));
	    JSONObject jObject = new JSONObject();
	    HashMap<String,String> categoryRes = videoService.dataCategories(items);
        Set<String> keySet = categoryRes.keySet();
        JSONArray jArray = new JSONArray();
        for(String key: keySet){
        	JSONObject catJSON = new JSONObject();
        	catJSON.put(key,categoryRes.get(key));
        	jArray.put(catJSON);
        }
        jObject.put("categoryList", jArray);
        System.out.println("query4 JSON: "+jObject);
	    if (!categoryRes.isEmpty()) {
	    	mav = new ModelAndView("login");
	      mav.addObject("categoryData", jObject);
	    } else {
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
	    String cn= "1,3";
	   // List<String> items = Arrays.asList(cn.split("\\s*,\\s*"));
	    JSONObject jObject = new JSONObject();
	    HashMap<String,String> channelRes = videoService.dataChannels(cn);
        Set<String> keySet = channelRes.keySet();
        JSONArray jArray = new JSONArray();
        for(String key: keySet){
        	JSONObject channelJSON = new JSONObject();
        	channelJSON.put(key,channelRes.get(key));
        	jArray.put(channelJSON);
        }
        jObject.put("channelList", jArray);
        System.out.println("query3 JSON: "+jObject);
	    if (!channelRes.isEmpty()) {
	    	mav = new ModelAndView("login");
	      mav.addObject("channelData", jObject);
	    } else {
	      mav = new ModelAndView("login");
	      mav.addObject("message", "Data doesn't exist!!");
	    }
	    return mav;
	  }
}

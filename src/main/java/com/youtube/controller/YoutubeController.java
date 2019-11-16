package com.youtube.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import com.youtube.model.Channels;
import com.youtube.model.Countries;
import com.youtube.model.Videos;
import com.youtube.service.VideoServiceImpl;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;



@Controller
public class YoutubeController {
 
	  @Autowired
	  VideoServiceImpl videoService;
	  

	  @RequestMapping(value = "/login", method = RequestMethod.GET)
	  public ModelAndView showLogin(HttpServletRequest request, HttpServletResponse response, @RequestParam(required=false) String countryList) {
	    ModelAndView mav = new ModelAndView("login");
	    /*mav.addObject("login", new Channels());*/
	    mav.addObject("message","Hello Mr.Nemala!!!!");
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

	  @RequestMapping(value = "/query4", method = RequestMethod.GET)
	  public ModelAndView query4(HttpServletRequest request, HttpServletResponse response,
			  @RequestParam(required=false) String countryList) {
	    ModelAndView mav = null;
	    List<String> items = Arrays.asList(countryList.split("\\s*,\\s*"));
	    HashMap<String,Integer> categoryRes = videoService.dataCategories(items);
        GsonBuilder gsonMapBuilder = new GsonBuilder();
        Gson gsonObject  = gsonMapBuilder.create();
        String JSONObject = gsonObject.toJson(categoryRes);
        System.out.println("query4 JSON: "+JSONObject);
	    if (null != categoryRes) {
	    	mav = new ModelAndView("login");
	      mav.addObject("categoryData", JSONObject);
	    } else {
	      mav = new ModelAndView("login");
	      mav.addObject("message", "Data doesn't exist!!");
	    }
	    return mav;
	  } 
}

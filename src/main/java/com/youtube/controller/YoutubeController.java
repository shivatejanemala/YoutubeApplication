package com.youtube.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.youtube.model.Channels;
import com.youtube.model.Videos;
import com.youtube.service.VideoService;
import com.youtube.service.VideoServiceImpl;

@Controller
public class YoutubeController {
 
	  @Autowired
	  VideoServiceImpl videoService;

	  @RequestMapping(value = "/login", method = RequestMethod.GET)
	  public ModelAndView showLogin(HttpServletRequest request, HttpServletResponse response) {
	    ModelAndView mav = new ModelAndView("login");
	    /*mav.addObject("login", new Channels());*/
	    mav.addObject("message","Hello Mr.Nemala!!!!");
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


}

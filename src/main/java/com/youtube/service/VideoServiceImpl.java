package com.youtube.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.youtube.model.Videos;

import com.youtube.model.Videos;
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


}

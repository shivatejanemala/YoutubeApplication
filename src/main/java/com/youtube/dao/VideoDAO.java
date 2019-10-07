package com.youtube.dao;

import org.springframework.stereotype.Service;

import com.youtube.model.Channels;
import com.youtube.model.Videos;


public interface VideoDAO {

	  void register(Videos video);

	  Videos validateUser(Channels channel);


}

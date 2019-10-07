package com.youtube.service;

import org.springframework.stereotype.Service;

import com.youtube.model.Channels;
import com.youtube.model.Videos;


public interface VideoService {

	  void register(Videos video);

	  Videos validateUser(Channels channel);

}

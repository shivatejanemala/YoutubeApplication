package com.youtube.model;

public class Statistics {


	  private int statid;
	  private String videoid;
	  private String trendingdate;
	  private int likes;
	  private int comments;
	  private int dislikes;
	  private int views;
	  private boolean commentsDisabled;
	  private boolean ratingsDisabled;
	  private boolean videoErrRemoved;
	  //commit check
	public int getStatid() {
		return statid;
	}
	public void setStatid(int statid) {
		this.statid = statid;
	}
	public String getVideoid() {
		return videoid;
	}
	public void setVideoid(String videoid) {
		this.videoid = videoid;
	}
	public String getTrendingdate() {
		return trendingdate;
	}
	public void setTrendingdate(String trendingdate) {
		this.trendingdate = trendingdate;
	}
	public int getLikes() {
		return likes;
	}
	public void setLikes(int likes) {
		this.likes = likes;
	}
	public int getComments() {
		return comments;
	}
	public void setComments(int comments) {
		this.comments = comments;
	}
	public int getDislikes() {
		return dislikes;
	}
	public void setDislikes(int dislikes) {
		this.dislikes = dislikes;
	}
	public int getViews() {
		return views;
	}
	public void setViews(int views) {
		this.views = views;
	}
	public boolean isCommentsDisabled() {
		return commentsDisabled;
	}
	public void setCommentsDisabled(boolean commentsDisabled) {
		this.commentsDisabled = commentsDisabled;
	}
	public boolean isRatingsDisabled() {
		return ratingsDisabled;
	}
	public void setRatingsDisabled(boolean ratingsDisabled) {
		this.ratingsDisabled = ratingsDisabled;
	}
	public boolean isVideoErrRemoved() {
		return videoErrRemoved;
	}
	public void setVideoErrRemoved(boolean videoErrRemoved) {
		this.videoErrRemoved = videoErrRemoved;
	}
	
	  


}

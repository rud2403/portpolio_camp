package com.camp.like;

public class LikeBean {

	private int lnum;
	private String mid;
	private String bname;
	

	public int getNum() {
		return lnum;
	}
	public void setNum(int lnum) {
		this.lnum = lnum;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getBname() {
		return bname;
	}
	public void setBname(String bname) {
		this.bname = bname;
	}
	

	@Override
	public String toString() {
		return "likeBean [lnum=" + lnum + ", mid=" + mid + ", bname=" + bname + "]";
	}	
	
}

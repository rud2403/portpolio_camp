package com.camp.like;

public class LikeBean {

	private int num;
	private String mid;
	private String bname;
	

	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
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
		return "likeBean [num=" + num + ", mid=" + mid + ", bname=" + bname + "]";
	}	
	
}

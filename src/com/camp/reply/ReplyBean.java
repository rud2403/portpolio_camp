package com.camp.reply;

public class ReplyBean {

	private int rnum;
	private String mid;
	private String bname;
	private String coment;
	private int re_ref;
	private int re_lev;
	private int re_seq;
	
	public int getRnum() {
		return rnum;
	}
	public void setRnum(int rnum) {
		this.rnum = rnum;
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
	public String getComent() {
		return coment;
	}
	public void setComent(String coment) {
		this.coment = coment;
	}
	public int getRe_ref() {
		return re_ref;
	}
	public void setRe_ref(int re_ref) {
		this.re_ref = re_ref;
	}
	public int getRe_lev() {
		return re_lev;
	}
	public void setRe_lev(int re_lev) {
		this.re_lev = re_lev;
	}
	public int getRe_seq() {
		return re_seq;
	}
	public void setRe_seq(int re_seq) {
		this.re_seq = re_seq;
	}
	
	@Override
	public String toString() {
		return "ReplyBean [rnum=" + rnum + ", mid=" + mid + ", bname=" + bname + ", coment=" + coment + ", re_ref="
				+ re_ref + ", re_lev=" + re_lev + ", re_seq=" + re_seq + "]";
	}
	
	
	
	
}

package com.camp.board;

import java.sql.Date;

public class BoardBean {

	
	private int num;
	private String name;
	private String address;
	private String lat;
	private String lng;
	private String toilet;
	private String park;
	private String water;
	private String fishing;
	private String field;
	private String land;
	private String filename;
	private Date date;
	private String level;
	private int readcount;
	private String coment;
	
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public String getComent() {
		return coment;
	}
	public void setComent(String coment) {
		this.coment = coment;
	}
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getLat() {
		return lat;
	}
	public void setLat(String lat) {
		this.lat = lat;
	}
	public String getLng() {
		return lng;
	}
	public void setLng(String lng) {
		this.lng = lng;
	}
	public String getToilet() {
		return toilet;
	}
	public void setToilet(String toilet) {
		this.toilet = toilet;
	}
	public String getPark() {
		return park;
	}
	public void setPark(String park) {
		this.park = park;
	}
	public String getWater() {
		return water;
	}
	public void setWater(String water) {
		this.water = water;
	}
	public String getFishing() {
		return fishing;
	}
	public void setFishing(String fishing) {
		this.fishing = fishing;
	}
	public String getField() {
		return field;
	}
	public void setField(String field) {
		this.field = field;
	}
	public String getLand() {
		return land;
	}
	public void setLand(String land) {
		this.land = land;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	
	@Override
	public String toString() {
		return "BoardBean [num=" + num + ", name=" + name + ", address=" + address + ", lat=" + lat + ", lng=" + lng
				+ ", toilet=" + toilet + ", park=" + park + ", water=" + water + ", fishing=" + fishing + ", field="
				+ field + ", land=" + land + ", filename=" + filename + ", date=" + date + ", level=" + level +", readcount=" + readcount + ", coment=" + coment +"]";
	}
	
}

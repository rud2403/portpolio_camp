package com.camp.board;

import java.sql.Date;

public class BoardBean {

	
	private int num; // 게시글 번호
	private String name; // camp_camp - 캠핑지 이름,
	private String address; // camp_camp - 캠핑지 주소,
	private String lat; // 위도
	private String lng; // 경도
	private String toilet; // 화장실 유무
	private String park; // 주차 가능여부
	private String water; // 물놀이 가능여부
	private String fishing; // 낚시 가능여부
	private String field; // 캠핑지 주변환경 종류 ( ex) 바다, 강 등)
	private String land; // 캠핑지 땅바닥 종류 ( ex) 흙, 진흙 등)
	private Date date; // 게시글 작성 날짜
	private String level; // 캠핑지 난이도
	private int readcount; // 조회수
	private String coment; // 게시글 본문
	private String filename; // 사진 파일1
	private String filename2; // 사진 파일2
	private String filename3; // 사진 파일3
	private String kind; // 팝니다, 삽니다 구분
	private String ip; // 게시판 ip
	private String price; // 장터게시판 가격
	private String trade; // 직거래인지 택배거래인지 표시
	private String state; // 거래 완료인지 상태 표시
	private String id; // Session을 통해 받아오는 글쓴이 아이디
	private String pw; // 게시글 수정, 삭제를 위해 session으로 받아 올 글쓴이 비밀번호 (수정, 삭제 할 때 입력한 비밀번호와 세션에 남아있는 pw가 일치하면 글 수정, 삭제)
	
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getTrade() {
		return trade;
	}
	public void setTrade(String trade) {
		this.trade = trade;
	}
	public String getFilename2() {
		return filename2;
	}
	public void setFilename2(String filename2) {
		this.filename2 = filename2;
	}
	public String getFilename3() {
		return filename3;
	}
	public void setFilename3(String filename3) {
		this.filename3 = filename3;
	}
	public String getKind() {
		return kind;
	}
	public void setKind(String kind) {
		this.kind = kind;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
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
				+ field + ", land=" + land + ", filename=" + filename + ", date=" + date + ", level=" + level +", readcount=" 
				+ readcount + ", coment=" + coment + ", filename2=" + filename2 + ", filename3=" + filename3 + ", kind=" 
				+ kind + ", ip=" + ip + ", id=" + id + ", pw=" + pw + ", price=" + price + ", trade=" + trade +  ", state=" + state + "]";
	}
	
}

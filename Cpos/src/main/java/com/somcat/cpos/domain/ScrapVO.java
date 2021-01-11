package com.somcat.cpos.domain;

import java.sql.Date;

public class ScrapVO {
	private int scrap_no;
	private String member_id;
	private int barcode;
	private String pname;
	private int category;
	private int scrap_qnt;
	private int get_price;
	private Date scrap_date;
	private Date expire_date;
	private int ino;
	private int scrap_div;
	private String scrap_content;
	
	public ScrapVO() {}
	//폐기 추가
	public ScrapVO(String member_id, int barcode, String pname, int category, int get_price, 
			Date expire_date, int scrap_qnt, int ino, int scrap_div, String scrap_content) {
		this.member_id = member_id;
		this.barcode = barcode;
		this.pname = pname;
		this.category = category;
		this.get_price = get_price;
		this.expire_date = expire_date;
		this.scrap_qnt = scrap_qnt;
		this.ino = ino;
		this.scrap_div = scrap_div;
		this.scrap_content = scrap_content;
	}
	
	//폐기한거 볼때 사용될 것..
	public ScrapVO(int scrap_no, String member_id, int barcode, int category, int get_price, Date scrap_date,
			Date expire_date, String pname, int scrap_qnt, int ino, int scrap_div, String scrap_content) {
		this(member_id, barcode, pname, category, get_price, expire_date, scrap_qnt, ino, scrap_div, scrap_content);
		this.scrap_no = scrap_no;
		this.scrap_date = scrap_date;
	}

	public int getScrap_no() {
		return scrap_no;
	}
	public void setScrap_no(int scrap_no) {
		this.scrap_no = scrap_no;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public int getBarcode() {
		return barcode;
	}
	public void setBarcode(int barcode) {
		this.barcode = barcode;
	}
	public int getCategory() {
		return category;
	}
	public void setCategory(int category) {
		this.category = category;
	}
	public int getGet_price() {
		return get_price;
	}
	public void setGet_price(int get_price) {
		this.get_price = get_price;
	}
	public Date getScrap_date() {
		return scrap_date;
	}
	public void setScrap_date(Date scrap_date) {
		this.scrap_date = scrap_date;
	}
	public Date getExpire_date() {
		return expire_date;
	}
	public void setExpire_date(Date expire_date) {
		this.expire_date = expire_date;
	}
	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}

	public int getScrap_qnt() {
		return scrap_qnt;
	}

	public void setScrap_qnt(int scrap_qnt) {
		this.scrap_qnt = scrap_qnt;
	}

	public int getIno() {
		return ino;
	}
	public void setIno(int ino) {
		this.ino = ino;
	}
	public int getScrap_div() {
		return scrap_div;
	}
	public void setScrap_div(int scrap_div) {
		this.scrap_div = scrap_div;
	}
	public String getScrap_content() {
		return scrap_content;
	}
	public void setScrap_content(String scrap_content) {
		this.scrap_content = scrap_content;
	}
}

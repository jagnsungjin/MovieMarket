package net.movie.db;


public class Crawl {
	private String  rank		;
	private String  name	;
	private String  ticket		;
	private String	good		;
	private String src;
	private String text_info;
	
	public String getText_info() {
		return text_info;
	}
	public void setText_info(String text_info) {
		this.text_info = text_info;
	}
	public String getRank() {
		return rank;
	}
	public void setRank(String rank) {
		this.rank = rank;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTicket() {
		return ticket;
	}
	public void setTicket(String ticket) {
		this.ticket = ticket;
	}
	public String getGood() {
		return good;
	}
	public void setGood(String good) {
		this.good = good;
	}
	public String getSrc() {
		return src;
	}
	public void setSrc(String src) {
		this.src = src;
	}
	
	
}
package com.dodou.table;

import java.util.Date;

public class TEMINAL_INFO_KEY
{
	private int teminal_info_key_id;
	private String host_no;
	private int area;
	private int status;
	private Date in_time;

	public String t_area;

	public String getT_area()
	{
		return t_area;
	}

	public void setT_area(String t_area)
	{
		this.t_area = t_area;
	}

	public int getTeminal_info_key_id()
	{
		return teminal_info_key_id;
	}

	public void setTeminal_info_key_id(int teminal_info_key_id)
	{
		this.teminal_info_key_id = teminal_info_key_id;
	}

	public String getHost_no()
	{
		return host_no;
	}

	public void setHost_no(String host_no)
	{
		this.host_no = host_no;
	}

	public int getArea()
	{
		return area;
	}

	public void setArea(int area)
	{
		this.area = area;
	}

	public int getStatus()
	{
		return status;
	}

	public void setStatus(int status)
	{
		this.status = status;
	}

	public Date getIn_time()
	{
		return in_time;
	}

	public void setIn_time(Date in_time)
	{
		this.in_time = in_time;
	}

}

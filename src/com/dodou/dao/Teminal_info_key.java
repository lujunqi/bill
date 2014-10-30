package com.dodou.dao;

import javax.servlet.http.HttpServletRequest;

public class Teminal_info_key
{
	private int teminal_info_key_id;
	private String host_no;
	private int area;
	private int status;
	private String in_time;
	private String up_time;

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

	public String getIn_time()
	{
		return in_time;
	}

	public void setIn_time(String in_time)
	{
		this.in_time = in_time;
	}

	public String getUp_time()
	{
		return up_time;
	}

	public void setUp_time(String up_time)
	{
		this.up_time = up_time;
	}

	public void requestGetParameter(HttpServletRequest request)
			throws Exception
	{
		if (request.getParameter("teminal_info_key_id") != null
				&& !request.getParameter("teminal_info_key_id").equals(""))
		{
			this.setTeminal_info_key_id(Integer.parseInt(request
					.getParameter("teminal_info_key_id")));
		}
		if (request.getParameter("host_no") != null
				&& !request.getParameter("host_no").equals(""))
		{
			this.setHost_no(request.getParameter("host_no"));
		}
		if (request.getParameter("area") != null
				&& !request.getParameter("area").equals(""))
		{
			this.setArea(Integer.parseInt(request.getParameter("area")));
		}
		if (request.getParameter("status") != null
				&& !request.getParameter("status").equals(""))
		{
			this.setStatus(Integer.parseInt(request.getParameter("status")));
		}
		if (request.getParameter("in_time") != null
				&& !request.getParameter("in_time").equals(""))
		{
			this.setIn_time(request.getParameter("in_time"));
		}
		if (request.getParameter("up_time") != null
				&& !request.getParameter("up_time").equals(""))
		{
			this.setUp_time(request.getParameter("up_time"));
		}
	}
}

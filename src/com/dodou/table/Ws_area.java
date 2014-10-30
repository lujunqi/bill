package com.dodou.table;

import java.sql.Timestamp;
import javax.servlet.http.HttpServletRequest;

import com.dodou.inferface.TableBeanInterface;
import com.dodou.util.*;

public class Ws_area implements TableBeanInterface
{
	private String areaid;
	private String provice;
	private String city;
	private String memo;

	public String getAreaid()
	{
		return areaid;
	}

	public void setAreaid(String areaid)
	{
		this.areaid = areaid;
	}

	public String getProvice()
	{
		return provice;
	}

	public void setProvice(String provice)
	{
		this.provice = provice;
	}

	public String getCity()
	{
		return city;
	}

	public void setCity(String city)
	{
		this.city = city;
	}

	public String getMemo()
	{
		return memo;
	}

	public void setMemo(String memo)
	{
		this.memo = memo;
	}

	public void requestGetParameter(HttpServletRequest request)
			throws Exception
	{
		if (request.getParameter("areaid") != null
				&& !request.getParameter("areaid").equals(""))
		{
			this.setAreaid(request.getParameter("areaid"));
		}
		if (request.getParameter("provice") != null
				&& !request.getParameter("provice").equals(""))
		{
			this.setProvice(request.getParameter("provice"));
		}
		if (request.getParameter("city") != null
				&& !request.getParameter("city").equals(""))
		{
			this.setCity(request.getParameter("city"));
		}
		if (request.getParameter("memo") != null
				&& !request.getParameter("memo").equals(""))
		{
			this.setMemo(request.getParameter("memo"));
		}
	}
}

package com.dodou.table;

import java.sql.Timestamp;
import javax.servlet.http.HttpServletRequest;

import com.dodou.inferface.TableBeanInterface;
import com.dodou.util.*;

public class Bill_role implements TableBeanInterface
{
	private int bill_role_id;
	private String name;
	private String page_url;

	public int getBill_role_id()
	{
		return bill_role_id;
	}

	public void setBill_role_id(int bill_role_id)
	{
		this.bill_role_id = bill_role_id;
	}

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public String getPage_url()
	{
		return page_url;
	}

	public void setPage_url(String page_url)
	{
		this.page_url = page_url;
	}

	public void requestGetParameter(HttpServletRequest request)
			throws Exception
	{
		if (request.getParameter("bill_role_id") != null
				&& !request.getParameter("bill_role_id").equals(""))
		{
			this.setBill_role_id(Integer.parseInt(request
					.getParameter("bill_role_id")));
		}
		if (request.getParameter("name") != null
				&& !request.getParameter("name").equals(""))
		{
			this.setName(request.getParameter("name"));
		}
		if (request.getParameter("page_url") != null
				&& !request.getParameter("page_url").equals(""))
		{
			this.setPage_url(request.getParameter("page_url"));
		}
	}
}

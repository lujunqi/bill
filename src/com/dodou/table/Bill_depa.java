package com.dodou.table;

import java.sql.Timestamp;
import javax.servlet.http.HttpServletRequest;

import com.dodou.inferface.TableBeanInterface;
import com.dodou.util.*;

public class Bill_depa implements TableBeanInterface
{
	private String bank_code;
	private int bill_depa_id;
	private String depa_name;
	private String depa_area;
	private int depa_level;
	private int parent_depa_id;

	public String getBank_code()
	{
		return bank_code;
	}

	public void setBank_code(String bank_code)
	{
		this.bank_code = bank_code;
	}

	public int getBill_depa_id()
	{
		return bill_depa_id;
	}

	public void setBill_depa_id(int bill_depa_id)
	{
		this.bill_depa_id = bill_depa_id;
	}

	public String getDepa_name()
	{
		return depa_name;
	}

	public void setDepa_name(String depa_name)
	{
		this.depa_name = depa_name;
	}

	public String getDepa_area()
	{
		return depa_area;
	}

	public void setDepa_area(String depa_area)
	{
		this.depa_area = depa_area;
	}

	public int getDepa_level()
	{
		return depa_level;
	}

	public void setDepa_level(int depa_level)
	{
		this.depa_level = depa_level;
	}

	public int getParent_depa_id()
	{
		return parent_depa_id;
	}

	public void setParent_depa_id(int parent_depa_id)
	{
		this.parent_depa_id = parent_depa_id;
	}

	public void requestGetParameter(HttpServletRequest request)
			throws Exception
	{
		if (request.getParameter("bank_code") != null
				&& !request.getParameter("bank_code").equals(""))
		{
			this.setBank_code(request.getParameter("bank_code"));
		}
		if (request.getParameter("bill_depa_id") != null
				&& !request.getParameter("bill_depa_id").equals(""))
		{
			this.setBill_depa_id(Integer.parseInt(request
					.getParameter("bill_depa_id")));
		}
		if (request.getParameter("depa_name") != null
				&& !request.getParameter("depa_name").equals(""))
		{
			this.setDepa_name(request.getParameter("depa_name"));
		}
		if (request.getParameter("depa_area") != null
				&& !request.getParameter("depa_area").equals(""))
		{
			this.setDepa_area(request.getParameter("depa_area"));
		}
		if (request.getParameter("depa_level") != null
				&& !request.getParameter("depa_level").equals(""))
		{
			this.setDepa_level(Integer.parseInt(request
					.getParameter("depa_level")));
		}
		if (request.getParameter("parent_depa_id") != null
				&& !request.getParameter("parent_depa_id").equals(""))
		{
			this.setParent_depa_id(Integer.parseInt(request
					.getParameter("parent_depa_id")));
		}
	}
}

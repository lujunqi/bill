package com.dodou.table;

import java.sql.Timestamp;
import javax.servlet.http.HttpServletRequest;

import com.dodou.inferface.TableBeanInterface;
import com.dodou.util.*;

public class Bill_opera_role implements TableBeanInterface
{
	private int bill_opera_role_id;
	private int bill_role_id;
	private int bill_opera_id;

	public int getBill_opera_role_id()
	{
		return bill_opera_role_id;
	}

	public void setBill_opera_role_id(int bill_opera_role_id)
	{
		this.bill_opera_role_id = bill_opera_role_id;
	}

	public int getBill_role_id()
	{
		return bill_role_id;
	}

	public void setBill_role_id(int bill_role_id)
	{
		this.bill_role_id = bill_role_id;
	}

	public int getBill_opera_id()
	{
		return bill_opera_id;
	}

	public void setBill_opera_id(int bill_opera_id)
	{
		this.bill_opera_id = bill_opera_id;
	}

	public void requestGetParameter(HttpServletRequest request)
			throws Exception
	{
		if (request.getParameter("bill_opera_role_id") != null
				&& !request.getParameter("bill_opera_role_id").equals(""))
		{
			this.setBill_opera_role_id(Integer.parseInt(request
					.getParameter("bill_opera_role_id")));
		}
		if (request.getParameter("bill_role_id") != null
				&& !request.getParameter("bill_role_id").equals(""))
		{
			this.setBill_role_id(Integer.parseInt(request
					.getParameter("bill_role_id")));
		}
		if (request.getParameter("bill_opera_id") != null
				&& !request.getParameter("bill_opera_id").equals(""))
		{
			this.setBill_opera_id(Integer.parseInt(request
					.getParameter("bill_opera_id")));
		}
	}
}

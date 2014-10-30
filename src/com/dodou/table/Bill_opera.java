package com.dodou.table;

import java.sql.Timestamp;
import javax.servlet.http.HttpServletRequest;

import com.dodou.inferface.TableBeanInterface;
import com.dodou.util.*;

public class Bill_opera implements TableBeanInterface
{
	private int bill_opera_id;
	private int bill_depa_id;
	private String tele_no;
	private String passwd;
	private String name;
	private int opera_type;
	private int operr_status;

	public int getBill_opera_id()
	{
		return bill_opera_id;
	}

	public void setBill_opera_id(int bill_opera_id)
	{
		this.bill_opera_id = bill_opera_id;
	}

	public int getBill_depa_id()
	{
		return bill_depa_id;
	}

	public void setBill_depa_id(int bill_depa_id)
	{
		this.bill_depa_id = bill_depa_id;
	}

	public String getTele_no()
	{
		return tele_no;
	}

	public void setTele_no(String tele_no)
	{
		this.tele_no = tele_no;
	}

	public String getPasswd()
	{
		return passwd;
	}

	public void setPasswd(String passwd)
	{
		this.passwd = passwd;
	}

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public int getOpera_type()
	{
		return opera_type;
	}

	public void setOpera_type(int opera_type)
	{
		this.opera_type = opera_type;
	}

	public int getOperr_status()
	{
		return operr_status;
	}

	public void setOperr_status(int operr_status)
	{
		this.operr_status = operr_status;
	}

	public void requestGetParameter(HttpServletRequest request)
			throws Exception
	{
		if (request.getParameter("bill_opera_id") != null
				&& !request.getParameter("bill_opera_id").equals(""))
		{
			this.setBill_opera_id(Integer.parseInt(request
					.getParameter("bill_opera_id")));
		}
		if (request.getParameter("bill_depa_id") != null
				&& !request.getParameter("bill_depa_id").equals(""))
		{
			this.setBill_depa_id(Integer.parseInt(request
					.getParameter("bill_depa_id")));
		}
		if (request.getParameter("tele_no") != null
				&& !request.getParameter("tele_no").equals(""))
		{
			this.setTele_no(request.getParameter("tele_no"));
		}
		if (request.getParameter("passwd") != null
				&& !request.getParameter("passwd").equals(""))
		{
			this.setPasswd(request.getParameter("passwd"));
		}
		if (request.getParameter("name") != null
				&& !request.getParameter("name").equals(""))
		{
			this.setName(request.getParameter("name"));
		}
		if (request.getParameter("opera_type") != null
				&& !request.getParameter("opera_type").equals(""))
		{
			this.setOpera_type(Integer.parseInt(request
					.getParameter("opera_type")));
		}
		if (request.getParameter("operr_status") != null
				&& !request.getParameter("operr_status").equals(""))
		{
			this.setOperr_status(Integer.parseInt(request
					.getParameter("operr_status")));
		}
	}
}

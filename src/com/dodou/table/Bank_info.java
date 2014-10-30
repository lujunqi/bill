package com.dodou.table;

import java.sql.Timestamp;
import javax.servlet.http.HttpServletRequest;

import com.dodou.inferface.TableBeanInterface;
import com.dodou.util.*;

public class Bank_info implements TableBeanInterface
{
	private String bank_code;
	private String bank_name;
	private String qingsuanno;

	public String getBank_code()
	{
		return bank_code;
	}

	public void setBank_code(String bank_code)
	{
		this.bank_code = bank_code;
	}

	public String getBank_name()
	{
		return bank_name;
	}

	public void setBank_name(String bank_name)
	{
		this.bank_name = bank_name;
	}

	public String getQingsuanno()
	{
		return qingsuanno;
	}

	public void setQingsuanno(String qingsuanno)
	{
		this.qingsuanno = qingsuanno;
	}

	public void requestGetParameter(HttpServletRequest request)
			throws Exception
	{
		if (request.getParameter("bank_code") != null
				&& !request.getParameter("bank_code").equals(""))
		{
			this.setBank_code(request.getParameter("bank_code"));
		}
		if (request.getParameter("bank_name") != null
				&& !request.getParameter("bank_name").equals(""))
		{
			this.setBank_name(request.getParameter("bank_name"));
		}
		if (request.getParameter("qingsuanno") != null
				&& !request.getParameter("qingsuanno").equals(""))
		{
			this.setQingsuanno(request.getParameter("qingsuanno"));
		}
	}
}

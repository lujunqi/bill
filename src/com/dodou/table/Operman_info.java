package com.dodou.table;

import javax.servlet.http.HttpServletRequest;

public class Operman_info
{
	private int operman_id;
	private int post_id;
	private String operman_name;
	private String oper_pass;
	private String oper_comp;
	private int oper_status = 1;// 默认状态为1
	private String oper_address;
	private String accout;
	private int departid;
	private String city;
	private String depart;

	public String getCity()
	{
		return city;
	}

	public void setCity(String city)
	{
		this.city = city;
	}

	public String getDepart()
	{
		return depart;
	}

	public void setDepart(String depart)
	{
		this.depart = depart;
	}

	private String bank_account;

	public String getBank_account()
	{
		return bank_account;
	}

	public void setBank_account(String bank_account)
	{
		this.bank_account = bank_account;
	}

	public int getOperman_id()
	{
		return operman_id;
	}

	public void setOperman_id(int operman_id)
	{
		this.operman_id = operman_id;
	}

	public int getPost_id()
	{
		return post_id;
	}

	public void setPost_id(int post_id)
	{
		this.post_id = post_id;
	}

	public String getOperman_name()
	{
		return operman_name;
	}

	public void setOperman_name(String operman_name)
	{
		this.operman_name = operman_name;
	}

	public String getOper_pass()
	{
		return oper_pass;
	}

	public void setOper_pass(String oper_pass)
	{
		this.oper_pass = oper_pass;
	}

	public String getOper_comp()
	{
		return oper_comp;
	}

	public void setOper_comp(String oper_comp)
	{
		this.oper_comp = oper_comp;
	}

	public int getOper_status()
	{
		return oper_status;
	}

	public void setOper_status(int oper_status)
	{
		this.oper_status = oper_status;
	}

	public String getOper_address()
	{
		return oper_address;
	}

	public void setOper_address(String oper_address)
	{
		this.oper_address = oper_address;
	}

	public String getAccout()
	{
		return accout;
	}

	public void setAccout(String accout)
	{
		this.accout = accout;
	}

	public int getDepartid()
	{
		return departid;
	}

	public void setDepartid(int departid)
	{
		this.departid = departid;
	}

	public void requestGetParameter(HttpServletRequest request)
			throws Exception
	{
		if (request.getParameter("operman_id") != null
				&& !request.getParameter("operman_id").equals(""))
		{
			this.setOperman_id(Integer.parseInt(request
					.getParameter("operman_id")));
		}
		if (request.getParameter("post_id") != null
				&& !request.getParameter("post_id").equals(""))
		{
			this.setPost_id(Integer.parseInt(request.getParameter("post_id")));
		}
		if (request.getParameter("operman_name") != null
				&& !request.getParameter("operman_name").equals(""))
		{
			this.setOperman_name(request.getParameter("operman_name"));
		}
		if (request.getParameter("oper_pass") != null
				&& !request.getParameter("oper_pass").equals(""))
		{
			this.setOper_pass(request.getParameter("oper_pass"));
		}
		if (request.getParameter("oper_comp") != null
				&& !request.getParameter("oper_comp").equals(""))
		{
			this.setOper_comp(request.getParameter("oper_comp"));
		}
		if (request.getParameter("oper_status") != null
				&& !request.getParameter("oper_status").equals(""))
		{
			this.setOper_status(Integer.parseInt(request
					.getParameter("oper_status")));
		}
		if (request.getParameter("oper_address") != null
				&& !request.getParameter("oper_address").equals(""))
		{
			this.setOper_address(request.getParameter("oper_address"));
		}
		if (request.getParameter("accout") != null
				&& !request.getParameter("accout").equals(""))
		{
			this.setAccout(request.getParameter("accout"));
		}
		if (request.getParameter("departid") != null
				&& !request.getParameter("departid").equals(""))
		{
			this.setDepartid(Integer.parseInt(request.getParameter("departid")));
		}

		if (request.getParameter("bank_account") != null
				&& !request.getParameter("bank_account").equals(""))
		{
			this.setBank_account(request.getParameter("bank_account"));
		}
	}
}

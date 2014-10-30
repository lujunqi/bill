package com.dodou.table;

import javax.servlet.http.HttpServletRequest;

public class Complaints_info
{
	private int comp_id;
	private int commercial_id;
	private String comp_type;
	private String comp_cont;
	private String solve_cont;
	private int comp_status;
	private String comp_date;
	private String change_date;

	public int getComp_id()
	{
		return comp_id;
	}

	public void setComp_id(int comp_id)
	{
		this.comp_id = comp_id;
	}

	public int getCommercial_id()
	{
		return commercial_id;
	}

	public void setCommercial_id(int commercial_id)
	{
		this.commercial_id = commercial_id;
	}

	public String getComp_type()
	{
		return comp_type;
	}

	public void setComp_type(String comp_type)
	{
		this.comp_type = comp_type;
	}

	public String getComp_cont()
	{
		return comp_cont;
	}

	public void setComp_cont(String comp_cont)
	{
		this.comp_cont = comp_cont;
	}

	public String getSolve_cont()
	{
		return solve_cont;
	}

	public void setSolve_cont(String solve_cont)
	{
		this.solve_cont = solve_cont;
	}

	public int getComp_status()
	{
		return comp_status;
	}

	public void setComp_status(int comp_status)
	{
		this.comp_status = comp_status;
	}

	public String getComp_date()
	{
		return comp_date;
	}

	public void setComp_date(String comp_date)
	{
		this.comp_date = comp_date;
	}

	public String getChange_date()
	{
		return change_date;
	}

	public void setChange_date(String change_date)
	{
		this.change_date = change_date;
	}

	public void requestGetParameter(HttpServletRequest request)
			throws Exception
	{
		if (request.getParameter("comp_id") != null
				&& !request.getParameter("comp_id").equals(""))
		{
			this.setComp_id(Integer.parseInt(request.getParameter("comp_id")));
		}
		if (request.getParameter("commercial_id") != null
				&& !request.getParameter("commercial_id").equals(""))
		{
			this.setCommercial_id(Integer.parseInt(request
					.getParameter("commercial_id")));
		}
		if (request.getParameter("comp_type") != null
				&& !request.getParameter("comp_type").equals(""))
		{
			this.setComp_type(request.getParameter("comp_type"));
		}
		if (request.getParameter("comp_cont") != null
				&& !request.getParameter("comp_cont").equals(""))
		{
			this.setComp_cont(request.getParameter("comp_cont"));
		}
		if (request.getParameter("solve_cont") != null
				&& !request.getParameter("solve_cont").equals(""))
		{
			this.setSolve_cont(request.getParameter("solve_cont"));
		}
		if (request.getParameter("comp_status") != null
				&& !request.getParameter("comp_status").equals(""))
		{
			this.setComp_status(Integer.parseInt(request
					.getParameter("comp_status")));
		}
		if (request.getParameter("comp_date") != null
				&& !request.getParameter("comp_date").equals(""))
		{
			this.setComp_date(request.getParameter("comp_date"));
		}
		if (request.getParameter("change_date") != null
				&& !request.getParameter("change_date").equals(""))
		{
			this.setChange_date(request.getParameter("change_date"));
		}
	}
}

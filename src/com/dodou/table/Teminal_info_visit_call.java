package com.dodou.table;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class Teminal_info_visit_call
{
	private int teminal_info_visit_call_id;
	private String visit_date;
	private int visit_man;
	private String demo;
	private int teminal_info_id;
	private int merchantsno_id;
	private int has_col1;
	private int has_col2;
	private int has_col3;
	private int has_col4;
	private int has_col5;
	private int has_col6;
	private int has_col7;
	private int has_col8;
	private int has_col9;
	private int has_col10;

	public int getTeminal_info_visit_call_id()
	{
		return teminal_info_visit_call_id;
	}

	public void setTeminal_info_visit_call_id(int teminal_info_visit_call_id)
	{
		this.teminal_info_visit_call_id = teminal_info_visit_call_id;
	}

	public String getVisit_date()
	{
		return visit_date;
	}

	public void setVisit_date(String visit_date)
	{
		this.visit_date = visit_date;
	}

	public int getVisit_man()
	{
		return visit_man;
	}

	public void setVisit_man(int visit_man)
	{
		this.visit_man = visit_man;
	}

	public String getDemo()
	{
		return demo;
	}

	public void setDemo(String demo)
	{
		this.demo = demo;
	}

	public int getTeminal_info_id()
	{
		return teminal_info_id;
	}

	public void setTeminal_info_id(int teminal_info_id)
	{
		this.teminal_info_id = teminal_info_id;
	}

	public int getMerchantsno_id()
	{
		return merchantsno_id;
	}

	public void setMerchantsno_id(int merchantsno_id)
	{
		this.merchantsno_id = merchantsno_id;
	}

	public int getHas_col1()
	{
		return has_col1;
	}

	public void setHas_col1(int has_col1)
	{
		this.has_col1 = has_col1;
	}

	public int getHas_col2()
	{
		return has_col2;
	}

	public void setHas_col2(int has_col2)
	{
		this.has_col2 = has_col2;
	}

	public int getHas_col3()
	{
		return has_col3;
	}

	public void setHas_col3(int has_col3)
	{
		this.has_col3 = has_col3;
	}

	public int getHas_col4()
	{
		return has_col4;
	}

	public void setHas_col4(int has_col4)
	{
		this.has_col4 = has_col4;
	}

	public int getHas_col5()
	{
		return has_col5;
	}

	public void setHas_col5(int has_col5)
	{
		this.has_col5 = has_col5;
	}

	public int getHas_col6()
	{
		return has_col6;
	}

	public void setHas_col6(int has_col6)
	{
		this.has_col6 = has_col6;
	}

	public int getHas_col7()
	{
		return has_col7;
	}

	public void setHas_col7(int has_col7)
	{
		this.has_col7 = has_col7;
	}

	public int getHas_col8()
	{
		return has_col8;
	}

	public void setHas_col8(int has_col8)
	{
		this.has_col8 = has_col8;
	}

	public int getHas_col9()
	{
		return has_col9;
	}

	public void setHas_col9(int has_col9)
	{
		this.has_col9 = has_col9;
	}

	public int getHas_col10()
	{
		return has_col10;
	}

	public void setHas_col10(int has_col10)
	{
		this.has_col10 = has_col10;
	}

	public void requestGetParameter(HttpServletRequest request)
			throws Exception
	{
		System.out.println("需要删除的回访"+request.getParameter("TEMINAL_INFO_VISIT_CALL_ID"));
		if (request.getParameter("TEMINAL_INFO_VISIT_CALL_ID") != null
				&& !request.getParameter("TEMINAL_INFO_VISIT_CALL_ID").equals(
						""))
		{
			this.setTeminal_info_visit_call_id(Integer.parseInt(request
					.getParameter("TEMINAL_INFO_VISIT_CALL_ID")));
		}
		// if (request.getParameter("visit_date") != null
		// && !request.getParameter("visit_date").equals(""))
		// {

		// 回访日期为系统默认时间
		// SimpleDateFormat format = new
		// SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		// this.setVisit_date(format.format(new
		// Date(System.currentTimeMillis())));
		// }
		// if (request.getParameter("visit_man") != null
		// && !request.getParameter("visit_man").equals(""))
		// {

		// 回访人为当前用户
		int man = loadCurrUser(request);
		this.setVisit_man(man);

		// }
		if (request.getParameter("demo") != null
				&& !request.getParameter("demo").equals(""))
		{
			this.setDemo(request.getParameter("demo"));
		}
		if (request.getParameter("teminal_info_id") != null
				&& !request.getParameter("teminal_info_id").equals(""))
		{
			this.setTeminal_info_id(Integer.parseInt(request
					.getParameter("teminal_info_id")));
		}
		if (request.getParameter("merchantsno_id") != null
				&& !request.getParameter("merchantsno_id").equals(""))
		{
			this.setMerchantsno_id(Integer.parseInt(request
					.getParameter("merchantsno_id")));
		}
		if (request.getParameter("has_col1") != null
				&& !request.getParameter("has_col1").equals(""))
		{
			this.setHas_col1(Integer.parseInt(request.getParameter("has_col1")));
		}
		if (request.getParameter("has_col2") != null
				&& !request.getParameter("has_col2").equals(""))
		{
			this.setHas_col2(Integer.parseInt(request.getParameter("has_col2")));
		}
		if (request.getParameter("has_col3") != null
				&& !request.getParameter("has_col3").equals(""))
		{
			this.setHas_col3(Integer.parseInt(request.getParameter("has_col3")));
		}
		if (request.getParameter("has_col4") != null
				&& !request.getParameter("has_col4").equals(""))
		{
			this.setHas_col4(Integer.parseInt(request.getParameter("has_col4")));
		}
		if (request.getParameter("has_col5") != null
				&& !request.getParameter("has_col5").equals(""))
		{
			this.setHas_col5(Integer.parseInt(request.getParameter("has_col5")));
		}
		if (request.getParameter("has_col6") != null
				&& !request.getParameter("has_col6").equals(""))
		{
			this.setHas_col6(Integer.parseInt(request.getParameter("has_col6")));
		}
		if (request.getParameter("has_col7") != null
				&& !request.getParameter("has_col7").equals(""))
		{
			this.setHas_col7(Integer.parseInt(request.getParameter("has_col7")));
		}
		if (request.getParameter("has_col8") != null
				&& !request.getParameter("has_col8").equals(""))
		{
			this.setHas_col8(Integer.parseInt(request.getParameter("has_col8")));
		}
		if (request.getParameter("has_col9") != null
				&& !request.getParameter("has_col9").equals(""))
		{
			this.setHas_col9(Integer.parseInt(request.getParameter("has_col9")));
		}
		if (request.getParameter("has_col10") != null
				&& !request.getParameter("has_col10").equals(""))
		{
			this.setHas_col10(Integer.parseInt(request
					.getParameter("has_col10")));
		}
	}

	/**
	 * 获取当前用户id
	 * 
	 * @param request
	 * @return
	 */
	private int loadCurrUser(HttpServletRequest request)
	{
		HttpSession session = request.getSession();
		Operman_info info = (Operman_info) session.getAttribute("man");
		int man = info.getOperman_id();
		return man;
	}
}

package com.cml.zyh;

import java.sql.Timestamp;
import javax.servlet.http.HttpServletRequest;
import com.dodou.util.*;

public class Commercial_info
{
	private int commercial_id;
	private String unit_name;
	private String unit_attr;
	private String unit_add;
	private String unit_area;
	private String comm_no;
	private String comm_name;
	private String comm_ad;
	private String trade_name;
	private String contact_name_1;
	private String contact_tel_1;
	private String contact_name_2;
	private String contact_tel_2;
	private String chan_type;
	private String chan_name;
	private int service_man;
	private String comm_rating;
	private String open_busi;
	private String remark_info;
	private int unit_status;
	private String input_date;
	private String change_date;
	private String checkdigit;//验证码
	// ljn新加
	private int sales_man;

	public int getCommercial_id()
	{
		return commercial_id;
	}

	public void setCommercial_id(int commercial_id)
	{
		this.commercial_id = commercial_id;
	}

	public String getUnit_name()
	{
		return unit_name;
	}

	public void setUnit_name(String unit_name)
	{
		this.unit_name = unit_name;
	}

	public String getUnit_attr()
	{
		return unit_attr;
	}

	public void setUnit_attr(String unit_attr)
	{
		this.unit_attr = unit_attr;
	}

	public String getUnit_add()
	{
		return unit_add;
	}

	public void setUnit_add(String unit_add)
	{
		this.unit_add = unit_add;
	}

	public String getUnit_area()
	{
		return unit_area;
	}

	public void setUnit_area(String unit_area)
	{
		this.unit_area = unit_area;
	}

	public String getComm_no()
	{
		return comm_no;
	}

	public void setComm_no(String comm_no)
	{
		this.comm_no = comm_no;
	}

	public String getComm_name()
	{
		return comm_name;
	}

	public void setComm_name(String comm_name)
	{
		this.comm_name = comm_name;
	}

	public String getComm_ad()
	{
		return comm_ad;
	}

	public void setComm_ad(String comm_ad)
	{
		this.comm_ad = comm_ad;
	}

	public String getTrade_name()
	{
		return trade_name;
	}

	public void setTrade_name(String trade_name)
	{
		this.trade_name = trade_name;
	}

	public String getContact_name_1()
	{
		return contact_name_1;
	}

	public void setContact_name_1(String contact_name_1)
	{
		this.contact_name_1 = contact_name_1;
	}

	public String getContact_tel_1()
	{
		return contact_tel_1;
	}

	public void setContact_tel_1(String contact_tel_1)
	{
		this.contact_tel_1 = contact_tel_1;
	}

	public String getContact_name_2()
	{
		return contact_name_2;
	}

	public void setContact_name_2(String contact_name_2)
	{
		this.contact_name_2 = contact_name_2;
	}

	public String getContact_tel_2()
	{
		return contact_tel_2;
	}

	public void setContact_tel_2(String contact_tel_2)
	{
		this.contact_tel_2 = contact_tel_2;
	}

	public String getChan_type()
	{
		return chan_type;
	}

	public void setChan_type(String chan_type)
	{
		this.chan_type = chan_type;
	}

	public String getChan_name()
	{
		return chan_name;
	}

	public void setChan_name(String chan_name)
	{
		this.chan_name = chan_name;
	}

	public int getService_man()
	{
		return service_man;
	}

	public void setService_man(int service_man)
	{
		this.service_man = service_man;
	}

	public String getComm_rating()
	{
		return comm_rating;
	}

	public void setComm_rating(String comm_rating)
	{
		this.comm_rating = comm_rating;
	}

	public String getOpen_busi()
	{
		return open_busi;
	}

	public void setOpen_busi(String open_busi)
	{
		this.open_busi = open_busi;
	}

	public String getRemark_info()
	{
		return remark_info;
	}

	public void setRemark_info(String remark_info)
	{
		this.remark_info = remark_info;
	}

	public int getUnit_status()
	{
		return unit_status;
	}

	public void setUnit_status(int unit_status)
	{
		this.unit_status = unit_status;
	}

	public String getInput_date()
	{
		return input_date;
	}

	public void setInput_date(String input_date)
	{
		this.input_date = input_date;
	}

	public String getChange_date()
	{
		return change_date;
	}

	public void setChange_date(String change_date)
	{
		this.change_date = change_date;
	}

	public int getSales_man()
	{
		return sales_man;
	}

	public void setSales_man(int sales_man)
	{
		this.sales_man = sales_man;
	}

	public void requestGetParameter(HttpServletRequest request)
			throws Exception
	{
		if (request.getParameter("commercial_id") != null
				&& !request.getParameter("commercial_id").equals(""))
		{
			this.setCommercial_id(Integer.parseInt(request
					.getParameter("commercial_id")));
		}
		if (request.getParameter("unit_name") != null
				&& !request.getParameter("unit_name").equals(""))
		{
			this.setUnit_name(request.getParameter("unit_name"));
		}
		if (request.getParameter("unit_attr") != null
				&& !request.getParameter("unit_attr").equals(""))
		{
			this.setUnit_attr(request.getParameter("unit_attr"));
		}
		if (request.getParameter("unit_add") != null
				&& !request.getParameter("unit_add").equals(""))
		{
			this.setUnit_add(request.getParameter("unit_add"));
		}
		if (request.getParameter("unit_area") != null
				&& !request.getParameter("unit_area").equals(""))
		{
			this.setUnit_area(request.getParameter("unit_area"));
		}
		if (request.getParameter("comm_no") != null
				&& !request.getParameter("comm_no").equals(""))
		{
			this.setComm_no(request.getParameter("comm_no"));
		}
		if (request.getParameter("comm_name") != null
				&& !request.getParameter("comm_name").equals(""))
		{
			this.setComm_name(request.getParameter("comm_name"));
		}
		if (request.getParameter("comm_ad") != null
				&& !request.getParameter("comm_ad").equals(""))
		{
			this.setComm_ad(request.getParameter("comm_ad"));
		}
		if (request.getParameter("trade_name") != null
				&& !request.getParameter("trade_name").equals(""))
		{
			this.setTrade_name(request.getParameter("trade_name"));
		}
		if (request.getParameter("contact_name_1") != null
				&& !request.getParameter("contact_name_1").equals(""))
		{
			this.setContact_name_1(request.getParameter("contact_name_1"));
		}
		if (request.getParameter("contact_tel_1") != null
				&& !request.getParameter("contact_tel_1").equals(""))
		{
			this.setContact_tel_1(request.getParameter("contact_tel_1"));
		}
		if (request.getParameter("contact_name_2") != null
				&& !request.getParameter("contact_name_2").equals(""))
		{
			this.setContact_name_2(request.getParameter("contact_name_2"));
		}
		if (request.getParameter("contact_tel_2") != null
				&& !request.getParameter("contact_tel_2").equals(""))
		{
			this.setContact_tel_2(request.getParameter("contact_tel_2"));
		}
		if (request.getParameter("chan_type") != null
				&& !request.getParameter("chan_type").equals(""))
		{
			this.setChan_type(request.getParameter("chan_type"));
		}
		if (request.getParameter("chan_name") != null
				&& !request.getParameter("chan_name").equals(""))
		{
			this.setChan_name(request.getParameter("chan_name"));
		}
		if (request.getParameter("service_man") != null
				&& !request.getParameter("service_man").equals(""))
		{
			this.setService_man(Integer.parseInt(request
					.getParameter("service_man")));
		}
		if (request.getParameter("comm_rating") != null
				&& !request.getParameter("comm_rating").equals(""))
		{
			this.setComm_rating(request.getParameter("comm_rating"));
		}
		if (request.getParameter("open_busi") != null
				&& !request.getParameter("open_busi").equals(""))
		{
			this.setOpen_busi(request.getParameter("open_busi"));
		}
		if (request.getParameter("remark_info") != null
				&& !request.getParameter("remark_info").equals(""))
		{
			this.setRemark_info(request.getParameter("remark_info"));
		}
		if (request.getParameter("unit_status") != null
				&& !request.getParameter("unit_status").equals(""))
		{
			this.setUnit_status(Integer.parseInt(request
					.getParameter("unit_status")));
		}
		if (request.getParameter("input_date") != null
				&& !request.getParameter("input_date").equals(""))
		{
			this.setInput_date(request.getParameter("input_date"));
		}
		if (request.getParameter("change_date") != null
				&& !request.getParameter("change_date").equals(""))
		{
			this.setChange_date(request.getParameter("change_date"));
		}

		if (request.getParameter("sales_man") != null
				&& !request.getParameter("sales_man").equals(""))
		{
			this.setSales_man(Integer.parseInt(request
					.getParameter("sales_man")));
		}
	}

	public String getCheckdigit() {
		return checkdigit;
	}

	public void setCheckdigit(String checkdigit) {
		this.checkdigit = checkdigit;
	}

}

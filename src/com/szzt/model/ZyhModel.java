package com.szzt.model;

/**
 * 专业化模型类
 * 
 * @author 陈孟琳
 * 
 */
public class ZyhModel
{
	private String merchantsno;// 商户编号
	private String comm_name;
	private String unit_attr;//
	private String chan_name;//
	private String sales_man;//
	private String input_date;//
	private int teminal_info_serv_id;

	public String getMerchantsno()
	{
		return merchantsno;
	}

	public void setMerchantsno(String merchantsno)
	{
		this.merchantsno = merchantsno;
	}

	public String getComm_name()
	{
		return comm_name;
	}

	public void setComm_name(String comm_name)
	{
		this.comm_name = comm_name;
	}

	public String getUnit_attr()
	{
		return unit_attr;
	}

	public void setUnit_attr(String unit_attr)
	{
		this.unit_attr = unit_attr;
	}

	public String getChan_name()
	{
		return chan_name;
	}

	public void setChan_name(String chan_name)
	{
		this.chan_name = chan_name;
	}

	public String getSales_man()
	{
		return sales_man;
	}

	public void setSales_man(String sales_man)
	{
		this.sales_man = sales_man;
	}

	public String getInput_date()
	{
		return input_date;
	}

	public void setInput_date(String input_date)
	{
		this.input_date = input_date;
	}

	public int getTeminal_info_serv_id()
	{
		return teminal_info_serv_id;
	}

	public void setTeminal_info_serv_id(int teminal_info_serv_id)
	{
		this.teminal_info_serv_id = teminal_info_serv_id;
	}

}

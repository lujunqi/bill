package com.szzt.model;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

/**
 * 后台返回信息model
 * 
 * @author 陈孟琳
 * 
 */
public class TableJson<T>
{

	private int rows;
	private int total;
	private int cur_page;
	private int total_page;
	private int pageCount;
	private int rowsCount;
	private Object[] resultset;

	private String format = "yyyy-MM-dd";

	public int getRowsCount()
	{
		return rowsCount;
	}

	public void setRowsCount(int rowsCount)
	{
		this.rowsCount = rowsCount;
	}

	public int getPageCount()
	{
		return pageCount;
	}

	public void setPageCount(int pageCount)
	{
		this.pageCount = pageCount;
	}

	public TableJson(String format)
	{
		this.format = format;
	}

	public TableJson()
	{
	}

	/**
	 * 转换成json对象
	 * 
	 * @return
	 */
	public String toJson()
	{
		// Gson gson = new GsonBuilder().setDateFormat("20yy-MM-dd").create();
		Gson gson = new GsonBuilder().setDateFormat(this.format).create();
		return gson.toJson(this);
	}

	public int getRows()
	{
		return rows;
	}

	public void setRows(int rows)
	{
		this.rows = rows;
	}

	public int getTotal()
	{
		return total;
	}

	public void setTotal(int total)
	{
		this.total = total;
	}

	public int getCur_page()
	{
		return cur_page;
	}

	public void setCur_page(int cur_page)
	{
		this.cur_page = cur_page;
	}

	public int getTotal_page()
	{
		return total_page;
	}

	public void setTotal_page(int total_page)
	{
		this.total_page = total_page;
	}

	public Object[] getResultset()
	{
		return resultset;
	}

	public void setResultset(Object[] resultset)
	{
		this.resultset = resultset;
	}

}

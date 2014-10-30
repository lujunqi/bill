package com.dodou.table;

import java.util.List;

public class Page
{
	private int id;
	private String name;
	private int up_id;
	private int type;
	private String url;
	private boolean checked;

	private List<Page> child;

	public boolean isChecked()
	{
		return checked;
	}

	public void setChecked(boolean checked)
	{
		this.checked = checked;
	}

	public List<Page> getChild()
	{
		return child;
	}

	public void setChild(List<Page> child)
	{
		this.child = child;
	}

	public int getId()
	{
		return id;
	}

	public void setId(int id)
	{
		this.id = id;
	}

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public int getUp_id()
	{
		return up_id;
	}

	public void setUp_id(int up_id)
	{
		this.up_id = up_id;
	}

	public int getType()
	{
		return type;
	}

	public void setType(int type)
	{
		this.type = type;
	}

	public String getUrl()
	{
		return url;
	}

	public void setUrl(String url)
	{
		this.url = url;
	}

}

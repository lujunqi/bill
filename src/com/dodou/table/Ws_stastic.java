package com.dodou.table;

import java.sql.Timestamp;
import javax.servlet.http.HttpServletRequest;
import com.dodou.util.*;

public class Ws_stastic
{
	private int ws_stastic_id;
	private String name;
	private String val;
	private String key;

	public int getWs_stastic_id()
	{
		return ws_stastic_id;
	}

	public void setWs_stastic_id(int ws_stastic_id)
	{
		this.ws_stastic_id = ws_stastic_id;
	}

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public String getVal()
	{
		return val;
	}

	public void setVal(String val)
	{
		this.val = val;
	}

	public String getKey()
	{
		return key;
	}

	public void setKey(String key)
	{
		this.key = key;
	}

	public void requestGetParameter(HttpServletRequest request)
			throws Exception
	{
		if (request.getParameter("ws_stastic_id") != null
				&& !request.getParameter("ws_stastic_id").equals(""))
		{
			this.setWs_stastic_id(Integer.parseInt(request
					.getParameter("ws_stastic_id")));
		}
		if (request.getParameter("name") != null
				&& !request.getParameter("name").equals(""))
		{
			this.setName(request.getParameter("name"));
		}
		if (request.getParameter("val") != null
				&& !request.getParameter("val").equals(""))
		{
			this.setVal(request.getParameter("val"));
		}
		if (request.getParameter("key") != null
				&& !request.getParameter("key").equals(""))
		{
			this.setKey(request.getParameter("key"));
		}
	}
}

package com.dodou.table;

import java.sql.Timestamp;
import javax.servlet.http.HttpServletRequest;
import com.dodou.util.*;

public class Post_info
{
	private int post_id;
	private String post_name;

	public Post_info(int post_id)
	{
		this.post_id = post_id;
	}

	public Post_info()
	{
	}

	@Override
	public int hashCode()
	{
		final int prime = 31;
		int result = 1;
		result = prime * result + post_id;
		return result;
	}

	@Override
	public boolean equals(Object obj)
	{
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Post_info other = (Post_info) obj;
		if (post_id != other.post_id)
			return false;
		return true;
	}

	public int getPost_id()
	{
		return post_id;
	}

	public void setPost_id(int post_id)
	{
		this.post_id = post_id;
	}

	public String getPost_name()
	{
		return post_name;
	}

	public void setPost_name(String post_name)
	{
		this.post_name = post_name;
	}

	public void requestGetParameter(HttpServletRequest request)
			throws Exception
	{
		if (request.getParameter("post_id") != null
				&& !request.getParameter("post_id").equals(""))
		{
			this.setPost_id(Integer.parseInt(request.getParameter("post_id")));
		}
		if (request.getParameter("post_name") != null
				&& !request.getParameter("post_name").equals(""))
		{
			this.setPost_name(request.getParameter("post_name"));
		}
	}
}

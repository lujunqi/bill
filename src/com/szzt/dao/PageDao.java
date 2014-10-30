package com.szzt.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.dodou.db.DatabaseAccess;
import com.dodou.table.Page;

public class PageDao
{
	private DatabaseAccess dba = new DatabaseAccess();

	public static final String TABLE = "page";

	public void update(Page page) throws Exception
	{
		StringBuffer buffer = new StringBuffer();
		buffer.append("update ").append(TABLE).append(" set ");
		// buffer.append("(id,name,up_id,type,url) values(page_id_id.nextval");
		buffer.append("name=").append(page.getName()).append(",");
		buffer.append("up_id=").append(page.getUp_id()).append(",");
		buffer.append("type=").append(page.getType()).append(",");
		buffer.append("url=").append(page.getUrl()).append(" where id=")
				.append(page.getId());
		this.dba.executeUpdate(buffer.toString());
		this.dba.release();
		System.out.println(buffer.toString());
	}

	public void insert(Page page) throws Exception
	{
		StringBuffer buffer = new StringBuffer();
		buffer.append("insert into ").append(TABLE);
		buffer.append("(id,name,up_id,type,url) values(page_id_id.nextval");
		buffer.append(",").append(page.getName());
		buffer.append(",").append(page.getUp_id());
		buffer.append(",").append(page.getType());
		buffer.append(",").append(page.getUrl());
		buffer.append(")");
		this.dba.executeUpdate(buffer.toString());
		this.dba.release();

	}

	private List<Page> initChild(int id, String post) throws Exception
	{
		String sql = "select * from " + TABLE + " where up_id=" + id
				+ " and type=1";

		String sql2 = "select * from " + TABLE + " where up_id=" + id
				+ " and type=1 ";

		if (null != post)
		{
			sql += " and id not in(select page_id from PAGE_POST_TEMP where post_id="
					+ post + ")";
			sql2 += "and id  in(select page_id from PAGE_POST_TEMP where post_id="
					+ post + ")";
		}

		List<Page> list = new ArrayList<Page>();
		DatabaseAccess d = new DatabaseAccess();
		ResultSet rs = d.executeQuery(sql);
		wrapModel(list, rs, false, false, post);
		rs.close();
		ResultSet rs2 = d.executeQuery(sql2);
		wrapModel(list, rs2, false, true, post);
		rs2.close();
		d.release();
		return list;
	}

	/**
	 * 封装菜单页面对象
	 * 
	 * @param list
	 *            容器
	 * @param rs
	 *            结果集
	 * @param hasChild
	 *            是否查询二级菜单
	 * @param checked
	 *            是否选中
	 * @param post
	 *            岗位
	 * @throws Exception
	 */
	private void wrapModel(List<Page> list, ResultSet rs, boolean hasChild,
			boolean checked, String post) throws Exception
	{
		while (rs.next())
		{
			Page page = new Page();
			page.setId(rs.getInt("id"));
			page.setName(rs.getString("name"));
			page.setType(rs.getInt("type"));
			page.setUp_id(rs.getInt("up_id"));
			page.setUrl(rs.getString("url"));
			page.setChecked(checked);

			if (hasChild)
			{
				page.setChild(this.initChild(rs.getInt("id"), post));
			}
			list.add(page);
		}
	}

	public List<Page> findMenus() throws Exception
	{
		List<Page> list = new ArrayList<Page>();
		ResultSet rs = this.dba.executeQuery("select * from  " + TABLE
				+ " where type=0");
		this.wrapModel(list, rs, true, false, null);
		rs.close();
		this.dba.release();
		return list;
	}

	public void delete(int id) throws Exception
	{
		String del = "delete from " + TABLE + " where id=" + id + " or up_id="
				+ id;
		this.dba.executeUpdate(del);
		this.dba.release();
	}

	public Page findById(int id) throws Exception
	{
		List<Page> list = new ArrayList<Page>();
		ResultSet rs = this.dba.executeQuery("select * from  " + TABLE
				+ " where id=" + id);
		this.wrapModel(list, rs, false, false, null);
		rs.close();
		this.dba.release();
		return list.size() > 0 ? list.get(0) : null;
	}

	/**
	 * 获取所有一级菜单
	 * 
	 * @return
	 * @throws Exception
	 */
	public List<Page> findRootMenus() throws Exception
	{
		List<Page> list = new ArrayList<Page>();
		ResultSet rs = this.dba.executeQuery("select * from  " + TABLE
				+ " where type=0");
		this.wrapModel(list, rs, false, false, "");
		rs.close();
		this.dba.release();
		return list;
	}

	/**
	 * 整理Page对象，将没有子菜单的菜单栏去除
	 * 
	 * @param p
	 * @return
	 */
	public List<Page> removeWithoutItems(List<Page> p)
	{
		List<Page> list = new ArrayList<Page>(p);
		for (Page page : p)
		{
			if (page.getChild() != null && page.getChild().size() > 0)
			{
				int removeParent = 0;
				for (Page child : page.getChild())
				{
					if (!child.isChecked())
					{
						removeParent++;
					}
				}
				if (removeParent == page.getChild().size())
				{
					list.remove(page);
				}
			}
		}
		return list;
	}

	public List<Page> findAll(List<Integer> posts) throws Exception
	{
		String post = "";
		if (null != posts)
		{
			post = posts.get(0) + "";

			for (int i = 1; i < posts.size(); i++)
			{
				post += " or post_id=" + posts.get(i);
			}
		}
		System.out.println("post:" + post);
		return this.findAll(post);
	}

	public List<Page> findAll(String post) throws Exception
	{
		List<Page> list = new ArrayList<Page>();
		String sql = "select * from " + TABLE + " where type=0 ";
		ResultSet rs = dba.executeQuery(sql);
		wrapModel(list, rs, true, false, post);
		rs.close();
		this.dba.release();
		return list;
	}

	public void delete(String id) throws Exception
	{
		this.dba.executeUpdate("delete from " + TABLE + " where id=" + id);
		this.dba.release();
	}
}

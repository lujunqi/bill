package com.szzt.dao;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.dodou.db.DatabaseAccess;
import com.szzt.model.KeyValueModel;

public class UserAuthorities
{
	private DatabaseAccess dba = new DatabaseAccess();

	public boolean assign(String ids, String userId) throws Exception
	{
		if (null == ids)
		{
			return false;
		}
		try
		{
			String[] id = ids.split(",");
			// 配置事务
			// 删除用户的岗位
			String del = " delete from USE_ROLE_INFO where OPERMAN_ID="
					+ userId;
			dba.executeUpdate(del);
			// 分配用户的新岗位
			for (String s : id)
			{
				String sql = "insert into USE_ROLE_INFO values(" + userId + ","
						+ s + ")";
				dba.executeUpdate(sql);
			}
			return true;

		} catch (Exception e)
		{
			dba.rollback();
		} finally
		{
			dba.release();
		}

		return false;
	}

	/**
	 * 根据用户id获取用户的所有权限
	 * 
	 * @param id
	 * @return key:岗位ID value：岗位名称
	 * @throws Exception
	 */
	public List<KeyValueModel> userPosts(String id) throws Exception
	{
		List<KeyValueModel> list = new ArrayList<KeyValueModel>();
		String sql = "select p.POST_ID,p.POST_NAME from USE_ROLE_INFO u,POST_INFO p where u.OPERMAN_ID="
				+ id + " and p.POST_ID=u.POST_ID";
		ResultSet result = dba.executeQuery(sql);
		while (result.next())
		{
			KeyValueModel model = new KeyValueModel();
			model.setKey(result.getString("POST_ID"));
			model.setValue(result.getString("POST_NAME"));
			model.setCheck(true);
			list.add(model);
		}
		String sql2 = "select  p.POST_ID,p.POST_NAME from POST_INFO p where p.POST_ID not in (select POST_ID from USE_ROLE_INFO where OPERMAN_ID="
				+ id + ")";

		ResultSet result2 = dba.executeQuery(sql2);
		while (result2.next())
		{
			KeyValueModel model = new KeyValueModel();
			model.setKey(result2.getString("POST_ID"));
			model.setValue(result2.getString("POST_NAME"));
			model.setCheck(false);
			list.add(model);
		}
		result.close();
		result2.close();
		dba.release();
		return list;
	}
}

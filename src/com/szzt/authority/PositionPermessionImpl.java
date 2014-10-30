package com.szzt.authority;

import java.sql.ResultSet;
import java.util.List;

import javax.servlet.http.HttpSession;

import com.dodou.db.DatabaseAccess;
import com.dodou.inferface.Permission;
import com.dodou.table.Operman_info;
import com.szzt.dao.Commercial_InfoDao;

/**
 * 职位权限实现类
 * 
 * @author 陈孟琳
 * 
 */
public class PositionPermessionImpl implements Permission
{
	@SuppressWarnings("unchecked")
	public boolean hasPermission(HttpSession session, int permit)
	{
		Object obj = session.getAttribute("posts");
		if (null == obj)
			return false;
		List<Integer> posts = (List<Integer>) obj;
		return posts.contains(permit);
	}

	/**
	 * 
	 * @param session
	 * @param table
	 * @param id
	 * @return
	 */
	public boolean hasPermission(HttpSession session, String table, int id)
			throws Exception
	{
		StringBuffer sql = new StringBuffer();
		Operman_info man = (Operman_info) session.getAttribute("man");
		sql.append("select count(*) from ").append(table)
				.append(" where APPPAY_ID=").append(id).append(" and E_ID=")
				.append(man.getOperman_id());
		DatabaseAccess dba = new DatabaseAccess();
		ResultSet set = dba.executeQuery(sql.toString());
		set.next();
		int allow = set.getInt(1);
		return allow == 1;
	}

	@SuppressWarnings("unchecked")
	public List<Integer> loadPosts(HttpSession session)
	{
		return (List<Integer>) session.getAttribute(POSTS);
	}

	public String initAppayWhere(List<Integer> posts, Operman_info info)
	{
		if (null == posts)
		{
			return " and 1!=1 ";
		}

		String area = info.getOper_address();

		if (null == area)
		{
			return " 1!=1 ";
		} else if (Permission.SUPER_AMDIN.equals(area))
		{
			return null;
		}

		if (posts.contains(Permission.ADMIN_POSITION)
				|| posts.contains(Permission.CUS_SERVICE_POSITION)
				|| posts.contains(Permission.LEADER_POSITION))
		{
			return null;
		}

		StringBuffer sql = new StringBuffer();

		// 业务客户的地区查询
		sql.append(" COMMERCIAL_ID in (select COMMERCIAL_ID from ")
				.append(Commercial_InfoDao.TABLE).append(" where UNIT_AREA=")
				.append(info.getOper_address()).append(")");

		// StringBuffer extractPosition = new StringBuffer();

		// if (posts.contains(EXPAND_POSITION))
		// {
		// extractPosition.append(" or e_id=").append(info.getOperman_id());
		// }

		// if (extractPosition.length() > 0)
		// {
		// extractPosition.insert(0, " or (1!=1 ");
		// extractPosition.append(" )");
		// }
		sql.insert(0, " and (");
		// sql.append(extractPosition);
		sql.append(")");
		System.out.println("限制条件--》" + sql.toString());
		return sql.toString();
	}

	public String initCommercialWhere(List<Integer> posts, Operman_info info)
	{
		if (null == posts)
		{
			return " and 1!=1 ";
		}

		String area = info.getOper_address();

		if (null == area)
		{
			return " 1!=1 ";
		} else if (Permission.SUPER_AMDIN.equals(area))
		{
			return null;
		}

		// 自己录入的，拓展人是你的
		StringBuffer sql = new StringBuffer();

		// 自己录入的
		sql.append(" INPUT_USER_ID=").append(info.getOperman_id());
		// 我拓展的
		sql.append(
				" or COMMERCIAL_ID in(select COMMERCIAL_ID from TEMINAL_INFO where E_ID=")
				.append(info.getOperman_id())
				.append(" and UNIT_INSTALLED_CITY=")
				.append(info.getOper_address())
				.append(" union all select  t.commercial_id  from APPPAY_101 t where  t.e_id=")
				.append(info.getOperman_id())
				.append(" union all select  t.commercial_id  from APPPAY_102 t where  t.e_id=")
				.append(info.getOperman_id())
				.append(" union all select  t.commercial_id  from APPPAY_103 t where  t.e_id=")
				.append(info.getOperman_id())
				.append(" union all select  t.commercial_id  from APPPAY_105 t where  t.e_id=")
				.append(info.getOperman_id()).append(")");
				//.append(" or INPUT_USER_ID=").append(info.getOperman_id());

		// 自己拓展的
		// sql.append(" INPUT_USER_ID=").append(info.getOperman_id());

		//sql.append(" or ( UNIT_AREA=").append(info.getOper_address());

		StringBuffer extractPosition = new StringBuffer();

		for (Integer id : posts)
		{
			switch (id)
			{
			case ADMIN_POSITION:
			case CUS_SERVICE_POSITION:
			case LEADER_POSITION:
				return null;

			case OPERAT_POSITION:
			case FILE_POSITION:
			case DEBUG_POSITION:
				sql.insert(0, " UNIT_AREA=" + info.getOper_address() + " or ");
				break;
			// 维护人或拓展人或装机人只能是本地区的
			case SAFE_POSITION:
				extractPosition
						.append(" or COMMERCIAL_ID in(select COMMERCIAL_ID from TEMINAL_INFO where SAFE_MAN=")
						.append(info.getOperman_id())
//						.append(" and UNIT_INSTALLED_CITY=")
//						.append(info.getOper_address()).append(")");
						.append(")");
				break;
			case INSTALL_POSITION:
				extractPosition
						.append(" or COMMERCIAL_ID in(select COMMERCIAL_ID from TEMINAL_INFO where INST_MAN=")
						.append(info.getOperman_id())
//						.append(" and UNIT_INSTALLED_CITY=")
//						.append(info.getOper_address()).append(")");
						.append(")");
				break;
			}
		}
		if (extractPosition.length() > 0)
		{
			extractPosition.insert(0, " or (1!=1 ");
			extractPosition.append(" )");
		}
		sql.insert(0, " and (");
		sql.append(extractPosition);
		sql.append(")");
		System.out.println("限制条件--》" + sql.toString());
		return sql.toString();
	}

	public Operman_info loadCurrentId(HttpSession session)
	{
		return (Operman_info) session.getAttribute("man");
	}

	public String initTerminalWhere(List<Integer> posts, Operman_info info)
	{

		if (null == posts)
		{
			return null;
		}
		String area = info.getOper_address();

		if (null == area)
		{
			return " 1!=1 ";
		} else if (Permission.SUPER_AMDIN.equals(area))
		{
			return null;
		}
		
		StringBuffer sql = new StringBuffer();
		// 拓展人不需要地区
		sql.append("  E_ID=").append(info.getOperman_id()).append(" or ");
		sql.append(" (UNIT_INSTALLED_CITY=").append(area);

		// sql.append(" and(1!=1 ");调试人可以查看到本地区的人员
		StringBuffer extractPosition = new StringBuffer();

		if (posts.contains(Permission.ADMIN_POSITION)
				|| posts.contains(Permission.CUS_SERVICE_POSITION)
				|| posts.contains(Permission.LEADER_POSITION))
		{
			return null;
		} else
		{
			for (Integer id : posts)
			{
				switch (id)
				{
				// 只能看本地区的信息

				// break;
				// case EXPAND_POSITION:
				// // 获取拓展人员的ID TEMINAL_INFO_ID
				// extractPosition.append(" or E_ID=")
				// .append(info.getOperman_id());
				// break;
				// case ADMIN_POSITION:
				// case CUS_SERVICE_POSITION:
				// case LEADER_POSITION:
				// break;
				case OPERAT_POSITION:
				case FILE_POSITION:
				case DEBUG_POSITION:
					sql.insert(0,
							" UNIT_INSTALLED_CITY=" + info.getOper_address()
									+ " or ");
					break;
				// 安装人 维护人不需要地区限制
				case SAFE_POSITION:
					extractPosition.append(" or SAFE_MAN=").append(
							info.getOperman_id());
					break;
				case INSTALL_POSITION:
					extractPosition.append(" or INST_MAN=").append(
							info.getOperman_id());
					break;
				}
			}
		}

		if (extractPosition.length() > 0)
		{
			extractPosition.insert(0, " and (1!=1 ");
			extractPosition.append(" )");
		}
		sql.insert(0, " and (");
		sql.append(extractPosition);
		sql.append("))");
		System.out.println("限制条件--》" + sql.toString());
		return sql.toString();
	}

	public boolean onlyPosition(HttpSession session, int position)
	{
		Object obj = session.getAttribute("posts");
		if (null == obj)
			return false;
		List<Integer> posts = (List<Integer>) obj;
		return posts.contains(position) && posts.size() == 1;
	}

}

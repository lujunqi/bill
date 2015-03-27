package com.dodou.inferface;

import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.dodou.db.DatabaseAccess;

public class LogService
{
	private StringBuffer sql = new StringBuffer();

	public void updateMan(String old, String update, String alias)
			throws Exception
	{
		DatabaseAccess acc = new DatabaseAccess();

		String sql = "select operman_name from OPERMAN_INFO where operman_id=";

		ResultSet rs = acc.executeQuery(sql + old);
		if (rs.next())
		{
			old = rs.getString("operman_name");
		}
		rs = acc.executeQuery(sql + update);
		if (rs.next())
		{
			update = rs.getString("operman_name");
		}
		rs.close();
		acc.release();
		this.appendDirty(old, update, alias);
	}

	public void appendAccountBank(String old, String update) throws Exception
	{
		DatabaseAccess acc = new DatabaseAccess();
		String sql = "select bank_name from BANK_INFO where BANK_CODE="
				+ update;
		ResultSet rs = acc.executeQuery(sql);
		String v = "";
		if (rs.next())
		{
			v = rs.getString("bank_name");
		}
		rs.close();
		acc.release();
		this.appendDirty(old, update, "账户银行改为:" + v);
	}

	/**
	 * 插入新记录
	 * 
	 * @param table
	 * @param who
	 * @param target
	 * @param type
	 * @return
	 */
	public String insertLog(String table, String who, int target, int type)
	{
		StringBuffer buffer = new StringBuffer();
		buffer.append("insert into common_log(id,target_id,table_name,do_type,who,do_what) ");
		buffer.append("values(common_log_id.nextval").append(",");
		buffer.append(target).append(",");
		buffer.append("'" + table + "'").append(",");
		buffer.append(type).append(",");
		buffer.append("'" + who + "'").append(",");
		buffer.append("'").append(this.sql).append("'").append(")");

		return buffer.toString();
	}

	public String newLog(String table, String who, int target, int type,
			String doWhat)
	{
		StringBuffer buffer = new StringBuffer();
		buffer.append("insert into common_log(id,target_id,table_name,do_type,who,do_what) ");
		buffer.append("values(common_log_id.nextval").append(",");
		buffer.append(target).append(",");
		buffer.append("'" + table + "'").append(",");
		buffer.append(type).append(",");
		buffer.append("'" + who + "'").append(",");
		buffer.append("'").append(doWhat).append("'").append(")");

		return buffer.toString();

	}

	/**
	 * 去除数据的前后单引号（'）
	 * 
	 * @param str
	 * @return
	 */
	public String replaceDirty(String str)
	{
		if (null != str)
		{
			return str.replace("'", "").trim();
		}
		return null;
	}

	public void appendAccountType(int old, int update)
	{
		String v = "";
		String vv = "";
		if (update == 2)
		{
			v = "结算行入账";
		} else
		{
			v = "银联小额入账";
		}
		if (old == 2)
		{
			vv = "结算行入账";
		} else
		{
			vv = "银联小额入账";
		}
		this.appendDirty(vv, v, "账户账号");
	}

	public void appendChargeCycle(int old, int update)
	{
		String v = (update == 1 ? "日结" : "月结");
		String vv = (old == 1 ? "日结" : "月结");
		this.appendDirty(vv, v, "收费周期" + v);
	}

	public void appendFeeType(String old, String update)
	{
		old = this.replaceDirty(old);
		update = this.replaceDirty(update);
		this.appendFeeType(Integer.parseInt(old), Integer.parseInt(update));
	}

	public void appendFeeType(int old, int update)
	{
		String v = "";
		String vv = "";
		if (update == 1)
		{
			v = "固定收费";
		} else if (update == 2)
		{
			v = "百分比";
		} else
		{
			v = "百分比封顶";
		}
		if (old == 1)
		{
			vv = "固定收费";
		} else if (old == 2)
		{
			vv = "百分比";
		} else
		{
			vv = "百分比封顶";
		}
		this.appendDirty(vv, v, "扣率类型改为:" + v);
	}

	public void appendCity(String old, String update)
	{
		old = this.replaceDirty(old);
		update = this.replaceDirty(update);

		String v = loadCityName(update);
		String vv = loadCityName(old);
		this.appendDirty(vv, v, "城市改为：" + v);
	}

	private String loadCityName(String update)
	{
		if (null == update)
		{
			return "空";
		}
		String v;
		switch (Integer.parseInt(update))
		{
		case 4301:
			v = "长沙市";
			break;
		case 4302:
			v = "株洲市";
			break;
		case 4303:
			v = "湘潭市";
			break;
		case 4304:
			v = "衡阳市";
			break;
		case 4305:
			v = "邵阳市";
			break;
		case 4306:
			v = "岳阳市";
			break;
		case 4307:
			v = "常德市";
			break;
		case 4308:
			v = "张家界市";
			break;
		case 4309:
			v = "益阳市";
			break;
		case 4310:
			v = "郴州市";
			break;
		case 4311:
			v = "永州市";
			break;
		case 4312:
			v = "怀化市";
			break;
		case 4325:
			v = "娄底市";
			break;
		case 4326:
			v = "湘西自治州";
			break;
		default:
			v = "未知 ";
		}
		return v;
	}

	/**
	 * 判断数据是否修改过，如果数据修改过则记录到日志中
	 * 
	 * @param old
	 * @param orig
	 * @param alias
	 */
	public void appendDirty(String old, String update, String alias)
	{
		update = this.replaceDirty(update);
		// 原始数据为空
		if (null == old)
		{
			if (null != update)
			{
				this.append(alias, old, update);
			}
		} else
		{
			if (null != update)
			{
				if (!update.equals(old))
				{
					this.append(alias, old, update);
				}
			} else if (null == update)
			{
				this.append(alias, old, " ");
			}
		}
	}

	/**
	 * 判断数据是否修改过，如果数据修改过则记录到日志中
	 * 
	 * @param old
	 * @param orig
	 * @param alias
	 */
	public void appendDirty(Date old, Date update, String alias)
	{
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		// 原始数据为空
		if (null == old)
		{
			if (null != update)
			{
				this.append(alias, format.format(old), format.format(update));
			}
		} else
		{
			if (null != update)
			{
				if (old.compareTo(update) != 0)
				{
					this.append(alias, format.format(old),
							format.format(update));
				}
			} else if (null == update)
			{
				this.append(alias, format.format(old), " ");
			}
		}
	}

	/**
	 * 判断数据是否修改过，如果数据修改过则记录到日志中
	 * 
	 * @param old
	 * @param orig
	 * @param alias
	 */
	public void appendDirty(int old, int update, String alias)
	{
		if (old != update)
		{
			this.append(alias, old + "", " update + ");
		}

	}

	/**
	 * 
	 * @param str
	 *            提示信息
	 * @param update
	 *            更改后的信息
	 * @param old
	 *            原始数据
	 */
	private void append(String alias, String old, String update)
	{
		this.sql.append(alias).append(":由【").append(old).append("】 改成  【")
				.append(update).append("】,");
	}

	public void append(String u)
	{
		this.sql.append(u + ",");
	}
}

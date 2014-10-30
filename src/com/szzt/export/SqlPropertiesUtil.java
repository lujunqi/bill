package com.szzt.export;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

public class SqlPropertiesUtil
{
	private Properties pro;
	public static final String SHANG_HU = "shanghu";
	public static final String FENG_DIAN = "zhongduan";
	public static final String ZHONG_DUAN = "fendian";

	public static void main(String[] args)
	{
		SqlPropertiesUtil util = new SqlPropertiesUtil();
		System.out.println(util.load(FENG_DIAN));
		System.out.println(util.load(ZHONG_DUAN));
		System.out.println(util.load(SHANG_HU));
	}

	public SqlPropertiesUtil()
	{
		pro = new Properties();
		try
		{
			pro.load(this.getClass().getResourceAsStream("sql.properties"));
		} catch (IOException e)
		{
			e.printStackTrace();
		}
	}

	public String load(String key)
	{
		return pro.getProperty(key, "获取错误");
	}

}

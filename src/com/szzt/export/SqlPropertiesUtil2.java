package com.szzt.export;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

public class SqlPropertiesUtil2
{
	private Properties pro;
	public static final String SHANG_HU = "shanghu";
	public static final String FENG_DIAN = "fendian";
	public static final String ZHONG_DUAN = "zhongduan";

	public static void main(String[] args)
	{
		SqlPropertiesUtil2 util = new SqlPropertiesUtil2();
		System.out.println(util.load(FENG_DIAN));
		System.out.println(util.load(ZHONG_DUAN));
		System.out.println(util.load(SHANG_HU));
	}

	public SqlPropertiesUtil2()
	{
		pro = new Properties();
		try
		{
			pro.load(this.getClass().getResourceAsStream("sql2.properties"));
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

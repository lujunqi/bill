package com.cml.zyh;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateConvert
{
	public static String currentDate()
	{
		return currentDate("yyyy-MM-dd hh24:mi:ss");
	}

	public static String currentDate(String format)
	{
		SimpleDateFormat f = new SimpleDateFormat(format);
		return f.format(new Date(System.currentTimeMillis()));
	}
}

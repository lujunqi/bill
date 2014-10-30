package com.szzt.util;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * 时间-字符 转换帮助类
 * 
 * @author
 * 
 */
public class DateConventer
{

	public static Date strNoTimeToDate(String str)
	{
		Date date = null;
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

		try
		{
			date = new Date(format.parse(str).getTime());
		} catch (ParseException e)
		{
			// System.out.println("非法的日期！");
			e.printStackTrace();
		}
		return date;
	}

	public static Date strWithTimeToDate(String str)
	{
		Date date = null;
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try
		{
			date = new Date(formatter.parse(str).getTime());
		} catch (ParseException e)
		{
			// System.out.println("非法的日期！");
			e.printStackTrace();
		}
		return date;
	}

	public static String dateNoTimeNoSplitToStr(Date date)
	{
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		if (date != null)
		{
			return formatter.format(date);
		} else
		{
			return null;
		}
	}

	public static String dateNoTimeToStr(Date date)
	{
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		if (date != null)
		{
			return formatter.format(date);
		} else
		{
			return null;
		}
	}

	public static String dateWithTimeToStr(Date date)
	{
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return formatter.format(date);
	}

	/**
	 * 把字符串转换为java.sql.Timestamp对象
	 * 
	 * @param str
	 * @return
	 */
	public static Timestamp strToTimestampWithTime(String str)
	{
		return Timestamp.valueOf(str);
	}

	/**
	 * 把java.sql.Timestamp对象转换为字符串
	 * 
	 * @param timestamp
	 * @return
	 */
	public static String timestampToStrWithTime(Timestamp timestamp)
	{
		String str = null;
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		str = formatter.format(timestamp);
		return str;
	}

	public static String addDay(String s, int n)
	{
		try
		{
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");

			Calendar cd = Calendar.getInstance();
			cd.setTime(sdf.parse(s));
			cd.add(Calendar.DATE, n);// 增加一天
			// cd.add(Calendar.MONTH, n);//增加一个月
			return sdf.format(cd.getTime());
		} catch (Exception e)
		{
			return null;
		}
	}

	public static String addMonth(String s, int n)
	{
		try
		{
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");

			Calendar cd = Calendar.getInstance();
			cd.setTime(sdf.parse(s));
			// cd.add(Calendar.DATE, n);//增加一天
			cd.add(Calendar.MONTH, n);// 增加一个月
			return sdf.format(cd.getTime());
		} catch (Exception e)
		{
			return null;
		}
	}

	public static String parseStringtoDate(String str)
	{

		Date date = null;
		try
		{
			date = new SimpleDateFormat("yyyyMMdd").parse(str);
		} catch (ParseException e)
		{
			e.printStackTrace();
		}
		return new SimpleDateFormat("yyyy-MM-dd").format(date);
	}

	public static String parseStringtoDates(String str)
	{

		Date date = null;
		try
		{
			date = new SimpleDateFormat("yyyy-MM-dd").parse(str);
		} catch (ParseException e)
		{
			e.printStackTrace();
		}
		return new SimpleDateFormat("yyyyMMdd").format(date);
	}

	public static String parseStringtoDates2(String str)
	{

		Date date = null;
		try
		{
			date = new SimpleDateFormat("yyyy-MM").parse(str);
		} catch (ParseException e)
		{
			e.printStackTrace();
		}
		return new SimpleDateFormat("yyyyMM").format(date);
	}

	public static Date getDateCounts()
	{
		String s = getDates(new Date());
		String sk = getDates(new Date()).substring(0, 4);
		String sb = String.valueOf((Integer.parseInt(sk) + 50));
		String sc = sb + s.substring(4, s.length());
		return DateConventer.strNoTimeToDate(sc);
	}

	public static String getDates(Date date)
	{

		SimpleDateFormat sim = new SimpleDateFormat("yyyy-MM-dd");

		if (date != null)
		{
			return sim.format(date);
		}
		return null;

	}

	public static String getNowYYYYMMDDHHmmss()
	{
		SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
		return bartDateFormat.format(new Date(System.currentTimeMillis()));
	}

	public static long getSecond(String time)
	{
		String[] _time = time.split(":");
		int second = Integer.parseInt(_time[0]) * 3600
				+ Integer.parseInt(_time[1]) * 60 + Integer.parseInt(_time[2]);
		return second;
	}

	public static String getNowTimeWithoutDate()
	{
		SimpleDateFormat bartDateFormat = new SimpleDateFormat("HH:mm:ss");
		return bartDateFormat.format(new Date(System.currentTimeMillis()));
	}

	public static String getLastday()
	{
		Date today = new Date();
		Date yesterday = new Date(today.getTime() - 24 * 3600 * 1000);
		return dateNoTimeNoSplitToStr(yesterday);
	}

	public static void main(String[] args) throws ParseException
	{
		// getNextReportTime("2012-02-25","2",2);
		System.out.println(addMonth(dateNoTimeNoSplitToStr(new Date()), -1));
	}
}
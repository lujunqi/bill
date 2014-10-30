package com.szzt.util;

import java.util.Date;

public class User
{
	private int id=11111;
	private String name;
	private int age;
	private Date date;
	private long l;
	private float f;
	private double d;

	public long getL()
	{
		return l;
	}

	public void setL(long l)
	{
		this.l = l;
	}

	public float getF()
	{
		return f;
	}

	public void setF(float f)
	{
		this.f = f;
	}

	public double getD()
	{
		return d;
	}

	public void setD(double d)
	{
		this.d = d;
	}

	public Date getDate()
	{
		return date;
	}

	public void setDate(Date date)
	{
		this.date = date;
	}

	public int getId()
	{
		return id;
	}

	public void setId(int id)
	{
		this.id = id;
	}

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public int getAge()
	{
		return age;
	}

	public void setAge(int age)
	{
		this.age = age;
	}

	@Override
	public String toString()
	{
		return "User [id=" + id + ", name=" + name + ", age=" + age + ", date="
				+ date + ", l=" + l + ", f=" + f + ", d=" + d + "]";
	}

}

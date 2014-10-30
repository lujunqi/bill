<%@page import="com.szzt.authority.PositionPermessionImpl"%>
<%@page import="com.dodou.inferface.Permission"%>
<%@page import="com.szzt.util.BindRequest"%>
<%@page import="com.szzt.model.TableJson"%>
<%@page import="com.dodou.table.Terminal_Info"%>
<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ include file="../../import.jsp"%>
<%@page import="com.szzt.dao.*"%>
<%
	/**
	 *判断商户编码是否存在，存在则返回-1，不存在转向业务更新
	 */
	try
	{
		String no = request.getParameter("TERM_ID1");
		String no2 = request.getParameter("TERM_ID2");
		String apppay_id = request.getParameter("APPPAY_ID");
		System.out.println("进入商户编号唯一判断action!");
		if (null != no)
		{
			String sql = "select * from (select count(*) from APPPAY_106 where trim(TERM_ID1)=trim('"+no+"') and apppay_id!="+apppay_id+")t2,(select count(*) from APPPAY_102 where trim(TERM_ID1)=trim('"+no+"') and apppay_id!="+apppay_id+")t3 ";
			DatabaseAccess dba = new DatabaseAccess();
			System.out.println(sql);
			ResultSet set = dba.executeQuery(sql);
			if (set.next())
			{
				int a_106 = set.getInt(1);
				int a_102 = set.getInt(2);
				//商户编号不存在
				if (a_106 == 0 && a_102 == 0)
				{
				    //判断16位终端号是否重复
				    if(no2 != null && no2.length() == 16){
						String sql2 = "select count(*) from TERM_APP_TABLE where trim(TERM_ID2)=trim('"+no2+"')";
						DatabaseAccess dba2 = new DatabaseAccess();
						ResultSet set2 = dba2.executeQuery(sql2);
						if(set2.next()){
						    int isExists = set2.getInt(1);
						    if(isExists == 0){
								request.getRequestDispatcher("BussinessOperate.jsp").forward(request, response);
								System.out.print("《《《《《《《《16位终端编号不存在！》》》》》》");
								set2.close();
								dba2.release();
								set.close();
								dba.release();
								return;
						    }else{
								System.out.print("《《《《《《《《16位终端编号已经存在！》》》》》》");
								set2.close();
								dba2.release();
								set.close();
								dba.release();
								out.println(-11);
								return;
						    }
						}
					}
					request.getRequestDispatcher("BussinessOperate.jsp")
							.forward(request, response);
					System.out.print("《《《《《《《《商户编号不存在！》》》》》》");
					set.close();
					dba.release();
					return;
				}
			}
			System.out.print("《《《《《《《《商户编号已经存在！》》》》》》");
			set.close();
			dba.release();
			out.println(-11);
		}

	} catch (Exception e)
	{
		out.print(-1);
		response.setStatus(500);
		e.printStackTrace(response.getWriter());
		e.printStackTrace();
	}
%>
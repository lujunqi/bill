<%@page import="com.szzt.util.Encode"%><%@ page import="java.sql.*"%><%@ page import="java.util.*"%><%@ page import="java.io.*"%><%@ page import="com.dodou.log.*"%><%@ page import="com.dodou.util.*"%><%@ page import="com.dodou.db.*"%><%@ page import="com.dodou.table.*"%><%@ page import="com.dodou.dao.*"%><%@ page import="net.sf.json.*"%><%@ page import="java.security.*"%><%if(null==session.getAttribute("man")){String path = request.getContextPath();String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";response.sendRedirect(basePath+"/login.jsp?info=-2");return;} request.setCharacterEncoding("UTF-8");%>

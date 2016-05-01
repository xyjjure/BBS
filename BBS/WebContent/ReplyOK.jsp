<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<%@ page import="java.sql.*"%>
<%
 request.setCharacterEncoding("gbk");
 int id = Integer.parseInt(request.getParameter("id"));
 int rootid = Integer.parseInt(request.getParameter("rootid"));
 String title = request.getParameter("title");
 String cont = request.getParameter("cont");
 
 cont=cont.replaceAll("\n", "<br>");
 Class.forName("com.mysql.jdbc.Driver");
 Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/bbs","root","");
 
 conn.setAutoCommit(false);
 
 String sql = "insert into article values (null, ?, ?, ?, ?, now(), 0)";
 PreparedStatement pstat = conn.prepareStatement(sql);
 Statement stat = conn.createStatement();
 pstat.setInt(1,id);
 pstat.setInt(2, rootid);
 pstat.setString(3,title);
 pstat.setString(4, cont);
 pstat.executeUpdate();
 
 stat.executeUpdate("update article set isleaf = 1 where id = "+id);
 
 conn.commit();
 conn.setAutoCommit(true);
 
 stat.close();
 pstat.close();
 conn.close();
 response.sendRedirect("ArticleTree.jsp");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>Insert title here</title>
</head>
<body>

</body>
</html>
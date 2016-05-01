<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<%@ page import="java.sql.*"%>

<%!
private void del(Connection conn,int id){
	Statement stat = null;
	ResultSet rs = null;
	try{
		stat = conn.createStatement();
		rs = stat.executeQuery("select * from article where pid = " + id);
		while(rs.next()){
			del(conn,rs.getInt("id"));
					 		   
		}
		stat.executeUpdate("delete from article where id=" + id);
		
	}catch(SQLException e){
		e.printStackTrace();
	}finally {
		try{
			if(rs!= null){
				rs.close();
				rs = null;
			}
			if(stat != null){
				stat.close();
				stat = null;
			}
			}catch(SQLException e){
				e.printStackTrace();
			}
		}
	}



%>
<%
String admin = (String)session.getAttribute("admin");
if(admin == null || !admin.equals("true")){
	out.println("NO WAY");
	return ;
}
%>
<% 
int id = Integer.parseInt(request.getParameter("id"));
int pid = Integer.parseInt(request.getParameter("pid"));
Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/bbs","root","");
conn.setAutoCommit(false);

del(conn,id);
Statement stat = conn.createStatement();
ResultSet rs = stat.executeQuery("select count(*) from article where pid = "+pid);
rs.next();
int count = rs.getInt(1);
rs.close();
stat.close();
if(count <= 0){
	Statement stmt = conn.createStatement();
	stmt.executeUpdate("update article set isleaf = 0 where id ="+pid);
	stmt.close();
}
conn.commit();
conn.setAutoCommit(true);
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
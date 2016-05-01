<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<%@ page import="java.sql.*" %>
<%
String admin = (String)session.getAttribute("admin");
  if(admin != null && admin.equals("true")){
	  login = true;
  }

%>
<%!
String str = "";
boolean login = false;
private void tree(Connection conn,int id,int level){
	Statement stat = null;
	ResultSet rs = null;
	String pstr = "";
	for(int i=0;i<level;i++){
		pstr += "----";
	}
	try{
		stat = conn.createStatement();
		rs = stat.executeQuery("select * from article where pid = "+id);
		String strlogin ="";

		while (rs.next()){
			if(login){
				strlogin = "</td><td><a href = 'Delete.jsp?id="+
				           rs.getInt("id")+"&pid="+rs.getInt("pid")+"'>É¾³ı </a>";
			}
			str += "<tr><td>"+rs.getInt("id")+"</td><td>"+
		           pstr + "<a href = 'ArticalDetail.jsp?id="+rs.getInt("id")+"'>" +
			       rs.getString("title")+ "</a>"+strlogin+"</td></tr>";
		    if(rs.getInt("isleaf") != 0){
		    	tree(conn,rs.getInt("id"),level+1);
		    }
					 		   
		}
		
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
Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/bbs","root","");

Statement stat = conn.createStatement();
ResultSet rs = stat.executeQuery("select * from article where pid = 0");
String strlogin = "";

while (rs.next()){
	  if(login){
		  strlogin = "</td><td><a href = 'Delete.jsp?id="+
		         rs.getInt("id")+"&pid="+rs.getInt("pid")+"'>É¾³ı </a>";
	  }
	  str += "<tr><td>"+rs.getInt("id")+"</td><td>"+
	         "<a href = 'ArticalDetail.jsp?id="+rs.getInt("id")+"'>" +
		     rs.getString("title")+ "</a>" +strlogin+"</td></tr>";
     if(rs.getInt("isleaf") != 0){
            	tree(conn,rs.getInt("id"),1);
            }
}
rs.close();
stat.close();
conn.close();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>Insert title here</title>
</head>
<body>
<a href = "Post.jsp" >·¢±íĞÂÌû</a>
<table border = "1">
<%= str %>
<% str="";
   login = false;
%>
</table>
</body>


</html>
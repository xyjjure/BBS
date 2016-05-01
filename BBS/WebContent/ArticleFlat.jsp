<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<%@ page import="java.sql.*" %>
<%
int pagesize = 3;
String Strpage = request.getParameter("pageNO");
int pageNO;
if(Strpage == null || Strpage ==""){
	pageNO=1;
} else {
	try{
		pageNO = Integer.parseInt(Strpage);	
	}catch(NumberFormatException e){
		pageNO=1;
	}
	if(pageNO <= 0){
		pageNO = 1;
	}
}
%>
<%
Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/bbs","root","");
Statement statCount = conn.createStatement();
ResultSet rsCount = statCount.executeQuery("select count(*) from article where pid = 0");
rsCount.next();
int totalrecords = rsCount.getInt(1);
int totalpages = totalrecords % pagesize == 0 ? totalrecords / pagesize : totalrecords /pagesize + 1;
if(pageNO > totalpages) pageNO = totalpages;
int startnum = (pageNO-1) * pagesize;
Statement stat = conn.createStatement();
ResultSet rs = stat.executeQuery("select title from article where pid = 0 order by pdate desc limit "+startnum+","+pagesize);


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>Insert title here</title>
</head>
<body>
<a href = "Post.jsp" >发表新帖</a>
<table border = "1">
<% while (rs.next()){
	%>
	<tr>
	    <td>
	    <%= rs.getString("title") %>
	    </td>
	</tr>

<%
}
rs.close();
stat.close();
conn.close();
%>
</table> 
共<%= totalpages%>页   第<%=pageNO %>页
<a href = "ArticleFlat.jsp?pageNO=1">首页</a>
<a href = "ArticleFlat.jsp?pageNO=<%=pageNO-1%>">上一页</a> &nbsp;&nbsp;
<a href = "ArticleFlat.jsp?pageNO=<%=pageNO+1%>">下一页</a>
<a href = "ArticleFlat.jsp?pageNO=<%=totalpages%>">尾页</a>

<form name="form1" action ="ArticleFlat.jsp">
     <select name = "pageNO" onchange="document.form1.submit()">
        <% for(int i=1;i<=totalpages;i++){ 
        %>
       <option value=<%=i%> <%=(pageNO == i)? "selected": ""%>>第<%=i%>页
        <%
        }
        %>
     </select>
</form>
<form name ="form2" action="ArticleFlat.jsp">
      <input type ="text" size=4 name="pageNO" value=<%=pageNO%>>
      <input type = "submit" value="go">

</form>


</body>


</html>
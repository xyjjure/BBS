<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<%
String action = request.getParameter("action");
if(action != null && action.equals("login")) {
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	if(username == null || !username.equals("admin")) {
		out.println("username not correct");
	}else if(password == null || !password.equals("admin")){
		out.println("password not correct");
	}else {
		session.setAttribute("admin","true");
		response.sendRedirect("ArticleTree.jsp");
	}
}

%>
<!DOCTYPE html>
<head>
<meta charset="gbk">
<title>Slick Login</title>
<meta name="description" content="slick Login">
<meta name="author" content="Webdesigntuts+">
<link rel="stylesheet" type="text/css" href="style.css" />
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="http://www.modernizr.com/downloads/modernizr-latest.js"></script>
<script type="text/javascript" src="placeholder.js"></script>
</head>
<body>
<form id="slick-login">
<input type="hidden" name ="action" value= "login">
<label for="username">username</label><input type="text" name="username" class="placeholder" placeholder="me@tutsplus.com">
<label for="password">password</label><input type="password" name="password" class="placeholder" placeholder="password">
<input type="submit" value="Log In">
</form>
</body>
</html>
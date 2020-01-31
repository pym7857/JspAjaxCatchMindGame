<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Do Catch Mind!</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		
		session.invalidate();
		
		new UserDAO().setPresentOn(userID, false);
	%>
	<script>
		location.href = 'index.jsp';
	</script>
</body>
</html>
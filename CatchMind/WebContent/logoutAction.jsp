<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Do Catch Mind!</title>
</head>
<body>
	<%
		session.invalidate();
	%>
	<script>
		location.href = 'index.jsp';
	</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%
	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	
%>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css?ver=1">
<link rel="stylesheet" href="css/styles.css">
<title>Do Catch Mind!</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
</head>

<body>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="index.jsp">CATCHMIND</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="index.jsp">메인</a></li>
				<li class="active"><a href="gameServer.jsp">게임서버</a></li>
			</ul>
			<%
				if(userID == null) { // 로그인이 안된 유저한테만 보여지는 페이지 
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<%
				} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="profileUpdate.jsp">프로필 수정</a></li>
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	<canvas id="jsCanvas" class="canvas"></canvas>
	<div class="controls">
		<div class="controls__range">
			<input type="range"
			id="jsRange"
			min="0.1"
			max="5.0"
			value="2.5"
			step="0.1">
		</div>
		<div class="controls_btns">
			<button id="jsMode">Fill</button>
			<button id="jsClear">Clear</button>
			<button id="jsSave">Save</button>
		</div>
		<div class="colors" id="jsColors">
			<div class="color jsColor" style="background-color: black;"></div>
			<div class="color jsColor" style="background-color: white;"></div>
			<div class="color jsColor" style="background-color: red;"></div>
			<div class="color jsColor" style="background-color: orange;"></div>
			<div class="color jsColor" style="background-color: yellow;"></div>
			<div class="color jsColor" style="background-color: green;"></div>
			<div class="color jsColor" style="background-color: blue;"></div>
			<div class="color jsColor" style="background-color: #e128eb;"></div>
			<div class="color jsColor" style="background-color: #7d868a;"></div>
		</div>
	</div>
	<script src="js/app.js"></script>
</body>
</html>
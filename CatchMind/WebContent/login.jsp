<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%
	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if (userID != null) {
		session.setAttribute("messageType", "오류 메세지");
		session.setAttribute("messageContent", "이미 로그인된 회원입니다.");
		response.sendRedirect("index.jsp");
		return;
	}
%>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css?ver=1">
<title>Do Catch Mind!</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<!------ Include the above in your HEAD tag ---------->

<link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet">
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
				<li class="active"><a href="index.jsp">메인</a></li>
				<li><a href="gameServer.jsp">게임서버</a></li>
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
				} 
			%>
		</div>
	</nav>
	
	<!-- 부트스트랩 로그인 폼 -->
	<div class="container">
	    <div class="omb_login">
	    	<h3 class="omb_authTitle">Login or <a href="#">Sign up</a></h3>
			<div class="row omb_row-sm-offset-3 omb_socialButtons">
	    	    <div class="col-xs-4 col-sm-2">
			        <a href="#" class="btn btn-lg btn-block omb_btn-facebook">
				        <i class="fa fa-facebook visible-xs"></i>
				        <span class="hidden-xs">Facebook</span>
			        </a>
		        </div>
	        	<div class="col-xs-4 col-sm-2">
			        <a href="#" class="btn btn-lg btn-block omb_btn-twitter">
				        <i class="fa fa-twitter visible-xs"></i>
				        <span class="hidden-xs">Twitter</span>
			        </a>
		        </div>	
	        	<div class="col-xs-4 col-sm-2">
			        <a href="#" class="btn btn-lg btn-block omb_btn-google">
				        <i class="fa fa-google-plus visible-xs"></i>
				        <span class="hidden-xs">Google+</span>
			        </a>
		        </div>	
			</div>
	
			<div class="row omb_row-sm-offset-3 omb_loginOr">
				<div class="col-xs-12 col-sm-6">
					<hr class="omb_hrOr">
					<span class="omb_spanOr">or</span>
				</div>
			</div>
	
			<div class="row omb_row-sm-offset-3">
				<div class="col-xs-12 col-sm-6">	
				    <form class="omb_loginForm" action="./userLogin" autocomplete="off" method="POST">
						<div class="input-group">
							<span class="input-group-addon"><i class="fa fa-user"></i></span>
							<input type="text" class="form-control" name="userID" placeholder="아이디">
						</div>
						<span class="help-block"></span>
											
						<div class="input-group">
							<span class="input-group-addon"><i class="fa fa-lock"></i></span>
							<input  type="password" class="form-control" name="userPassword" placeholder="비밀번호">
						</div>
	                    <span class="help-block"> </span>
	
						<button class="btn btn-lg btn-success btn-block" type="submit">Login</button>
					</form>
				</div>
	    	</div>
			<div class="row omb_row-sm-offset-3">
				<div class="col-xs-12 col-sm-3">
					<label class="checkbox">
						<input type="checkbox" value="remember-me">Remember Me
					</label>
				</div>
				<div class="col-xs-12 col-sm-3">
					<p class="omb_forgotPwd">
						<a href="#">Forgot password?</a>
					</p>
				</div>
			</div>	    	
		</div>
	</div>
	
<!--  
	<div class="container">
		<form method="post" action="./userLogin">
			<table class="table table-bordered table-hover" 
			style="text-align: center; border: 1px solid black">
				<thead>
					<tr>
						<th colspan="2"><h4>로그인 양식</h4></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 110px;"><h5>아이디</h5></td>
						<td>
						<input class="form-control" type="text" name="userID"
						maxlength="20" placeholder="아이디를 입력하세요"></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>비밀번호</h5></td>
						<td>
						<input class="form-control" type="password" 
						name="userPassword" maxlength="20" placeholder="비밀번호를 입력하세요"></td>
					</tr>
					<tr>
						<td style="text-align: left;" colspan="2">
							<input class="btn btn-primary pull-right" type="submit"
							value="로그인">
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
-->
	<%
		String messageContent = null;
		if (session.getAttribute("messageContent") != null) {
			messageContent = (String) session.getAttribute("messageContent");
		}
		String messageType = null;
		if (session.getAttribute("messageType") != null) {
			messageType = (String) session.getAttribute("messageType");
		}
		if (messageContent != null) {
	%>
	<!-- messageModal -->
	<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="vertical-alignment-helper">
			<div class="modal-dialog vertical-align-center">
				<div class="modal-content <% if(messageType.equals("오류 메세지")) out.println("panel-warning"); else out.println("panel-success");%>">
					<div class="modal-header panel-heading">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">&times</span>	<!-- x버튼 -->
							<span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">
							<%= messageType %>
						</h4>
					</div>
					<div class="modal-body">
						<%= messageContent %>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-dismiss="modal">
							확인
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- checkModal -->
	<div class="modal fade" id="checkModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="vertical-alignment-helper">
			<div class="modal-dialog vertical-align-center">
				<div id="checkType" class="modal-content panel-info">
					<div class="modal-header panel-heading">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">&times</span>
							<span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">
							확인메세지
						</h4>
					</div>
					<div class="modal-body" id="checkMessage">
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-dismiss="modal">
							확인
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%
		session.removeAttribute("messageContent");
		session.removeAttribute("messageType");
		}
	%>
	<script>
		$('#messageModal').modal("show");
	</script>
</body>
</html>
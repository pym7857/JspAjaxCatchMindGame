<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.UserDTO" %>
<%@ page import="java.util.ArrayList" %>
<html>
<%
	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null) {
		session.setAttribute("messageType", "오류 메세지");
		session.setAttribute("messageContent", "로그인을 먼저 하세요!");
		response.sendRedirect("login.jsp");
		return;
	}
	// getProfile함수에서  프로필 가져오기
	String myProfile = new UserDAO().getProfile(userID);
	
	// 게임서버에 접속하면 해당 userID의 present를 true로 변경
	new UserDAO().setPresentOn(userID, true);
	
	// 현재 접속중인 유저 리스트 가져오기 
	ArrayList<String> userList = new UserDAO().getPresentUser();
	
	// 메모: 로그아웃을 정상적으로 눌러야 userList에서 삭제되게 해놧음 (logoutAction.jsp)
	// 메모: 그냥 창 나가버리면 present=true 유지되는 상태
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
<script type="text/javascript">
	function getInfReload() {
		setInterval( function () {
			$("#example").load("gameServer.jsp #example");
		}, 3000);
	}
</script>
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
		<div class="container">
			<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
					<li><a href="index.jsp">메인</a></li>
					<li class="active"><a href="gameServer.jsp">게임서버</a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown">
						<a href="#" class="dropdown-toggle"
								data-toggle="dropdown" role="button" aria-haspopup="true"
								aria-expanded="false" >마이 페이지<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="profileUpdate.jsp">프로필 수정</a></li>
							<li><a href="logoutAction.jsp">로그아웃</a></li>
						</ul>
					</li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li>
						<img class=".media-object img-circle" 
						style="media-object: display:none; 
						margin: 0 auto; max-width: 45px; max-height: 45px;" 
						src="<%= myProfile %>"></img>
					</li>
				</ul>
			</div>
		</div>
	</nav>
	
	<iframe src="music/silence.mp3" allow="autoplay" 
	id="audio" style="display:none"></iframe>
	<audio id="audio" autoplay>
		<source src="music/catchMind.mp3">
	</audio>
	
	<div class="container">
		<div class="row">
			<div class="media">
				<a class="pull-left" href="#">
					<img class="media-object img-circle" 
					style="width:150px; height: 150px;"
					src="<%= myProfile %>" alt="">
				</a>
				<br>
			</div>
		</div>
		<br>
		<a class="pull-left" href="#"><p style="font-weight:bold;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;나3</p></a>
	</div>
	
	<table id="example" class="table table-bordered">
		<thead>
			<tr><th>현재 접속중인 유저</th></tr>
		</thead>
		<tbody>
			<%
				// 예외처리: 최대인원 2명 
				if (userList.size() > 2) {
					session.setAttribute("messageType", "오류 메세지");
					session.setAttribute("messageContent", "정원이 꽉 찼습니다!");
					response.sendRedirect("index.jsp");
					return;
				}
				
				for(int i=0; i<userList.size(); i++) {
					String user = userList.get(i);
			%>
					<tr><td style="text-align:center;"><%= user %></td></tr>
			<%
				}
			%>
		</tbody>
	</table>
	
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
	<script src="js/app.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			getInfReload();
		});
	</script>
</body>
</html>
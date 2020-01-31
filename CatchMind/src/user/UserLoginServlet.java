package user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UserLoginServlet")
public class UserLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String userID = request.getParameter("userID");
		String userPassword = request.getParameter("userPassword");
		
		/* 예외처리 1 */
		if(userID == null || userID.equals("") || userPassword == null || userPassword.equals("")) {
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "모든 내용을 입력하세요!");
			response.sendRedirect("login.jsp");
			return;
		}
		/* 예외처리를 통과한 후 .. */
		int result = new UserDAO().login(userID, userPassword);
		
		if(result == 1) { // 실제로 로그인이 이루어지는 부분
			request.getSession().setAttribute("userID", userID);
			request.getSession().setAttribute("messageType", "성공 메세지");
			request.getSession().setAttribute("messageContent", "로그인에 성공하였습니다!");
			response.sendRedirect("index.jsp");
		} else {
			if (result == 2) {
				request.getSession().setAttribute("messageType", "오류 메세지");
				request.getSession().setAttribute("messageContent", "비밀번호를 다시 확인하세요!");
				response.sendRedirect("login.jsp");
			}
			else if (result == 0) {
				request.getSession().setAttribute("messageType", "오류 메세지");
				request.getSession().setAttribute("messageContent", "해당 아이디가 존재하지 않습니다!");
				response.sendRedirect("login.jsp");
			}
			else if (result == -1) {
				request.getSession().setAttribute("messageType", "오류 메세지");
				request.getSession().setAttribute("messageContent", "데이터베이스 오류!");
				response.sendRedirect("login.jsp");
			}
		}
	}

}

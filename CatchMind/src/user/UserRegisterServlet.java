package user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UserRegisterServlet
 */
@WebServlet("/UserRegisterServlet")
public class UserRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String userID = request.getParameter("userID");
		String userPassword1 = request.getParameter("userPassword1");
		String userPassword2 = request.getParameter("userPassword2");
		String userName = request.getParameter("userName");
		String userAge = request.getParameter("userAge");
		String userGender = request.getParameter("userGender");
		String userEmail = request.getParameter("userEmail");
		String userProfile = request.getParameter("userProfile");
		
		/* 예외처리 1 */
		if(userID == null || userID.equals("") || userPassword1 == null || userPassword1.equals("") || userPassword2 == null || userPassword2.equals("") || userName == null || userName.equals("") || userAge == null || userAge.equals("") || userGender == null || userGender.equals("") ||userEmail == null || userEmail.equals("")) {
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "모든 내용을 입력하세요!");
			response.sendRedirect("join.jsp");
			return;
		}
		/* 예외처리 2*/
		if(!userPassword1.equals(userPassword2)) {
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "비밀번호가 서로 다릅니다!");
			response.sendRedirect("join.jsp");
			return;
		}
		/* 모든 예외처리를 통과한 후 .. */
		int result = new UserDAO().register(userID, userPassword1, userName, userAge, userGender, userEmail, "");
		if(result == 1) {
			request.getSession().setAttribute("userID", userID); // 회원가입이 성공했을때, 자동으로 로그인 되도록 session값으로 userID를 넣어줌 (로그인을 하면 각자의 session이 생기는 원리)
			request.getSession().setAttribute("messageType", "성공 메세지");
			request.getSession().setAttribute("messageContent", "회원가입에 성공하였습니다!");
			response.sendRedirect("index.jsp");
		} else {
			request.getSession().setAttribute("messageType", "오류 메세지");
			request.getSession().setAttribute("messageContent", "이미 존재하는 회원입니다!");
			response.sendRedirect("join.jsp");
		}
	}

}

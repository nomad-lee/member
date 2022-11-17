<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%
	// 1
	if(session.getAttribute("loginMemberId") == null) {
		// 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/memberIndex.jsp");
		return;
	} //비번확인 후 삭제
	
	//인코딩 (한글)
	request.setCharacterEncoding("utf-8");
	String memberPw = request.getParameter("memberPw");
	
	if(memberPw == null || memberPw == "") {
		String msg = URLEncoder.encode("모든 정보를 입력하세요", "utf-8"); //미입력 방지, get방식 주소창에 문자열 인코딩
		response.sendRedirect(request.getContextPath()+"/deleteMemberForm.jsp?msg="+msg);
		return;
	}
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/gdj58","root","java1234");
	
	String delSql = "DELETE FROM member WHERE (member_id = ? AND member_pw = PASSWORD(?))";
	PreparedStatement delStmt = conn.prepareStatement(delSql);
	delStmt.setString(1, (String)(session.getAttribute("loginMemberId")));
	delStmt.setString(2, memberPw);
	System.out.println((String)(session.getAttribute("loginMemberId")));
	
	int row = delStmt.executeUpdate(); // 반환되는 데이터가 0 or 1이라 row가 변경 되었는지 확인
	if(row == 1) {
	    response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		System.out.println("삭제성공");
	} else {
		String msgPw = URLEncoder.encode("비밀번호를 확인하세요", "utf-8");
		response.sendRedirect(request.getContextPath()+"/deleteMemberForm.jsp?msg="+msgPw);
		System.out.println("삭제실패");
	}
	
	delStmt.close();
	conn.close();
%>
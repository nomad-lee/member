<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%
	// 1
	if(session.getAttribute("loginMemberId") == null) {
		// 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/memberIndex.jsp");
		return;
	}

	request.setCharacterEncoding("utf-8");
	String memberId = request.getParameter("memberId");
	String memberName = request.getParameter("memberName");

	if(memberName == null || memberId == null || memberName == "" || memberId == "") {
		String msg = URLEncoder.encode("모든 정보를 입력하세요", "utf-8"); //미입력 방지, get방식 주소창에 문자열 인코딩
		response.sendRedirect(request.getContextPath()+"/updateMemberForm.jsp?msg="+msg);
		return;
	}
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/gdj58","root","java1234");
	
	String newPwSql = "UPDATE member SET member_name = ? WHERE member_id = ?";
	PreparedStatement newPwStmt = conn.prepareStatement(newPwSql);
	newPwStmt.setString(1, memberName);
	newPwStmt.setString(2, memberId);
	
	int row = newPwStmt.executeUpdate(); // 반환되는 데이터가 0 or 1이라 row가 변경 되었는지 확인
	if(row == 1) {
		System.out.println("수정성공");
		response.sendRedirect(request.getContextPath()+"/memberOne.jsp");
	} else {
		System.out.println("수정실패");
		String msg = URLEncoder.encode("ERROR", "utf-8");
		response.sendRedirect(request.getContextPath()+"/updateMemberForm.jsp?msg="+msg);
	}
	
	newPwStmt.close();
	conn.close();
%>
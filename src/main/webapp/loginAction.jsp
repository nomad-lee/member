<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "java.sql.*" %>
<%
	request.setCharacterEncoding("utf-8");

	if(request.getParameter("memberId") == null
			|| request.getParameter("memberPw") == null 
			|| request.getParameter("memberId") == "" 
			|| request.getParameter("memberPw") == "") {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	Member member = new Member();
	member.memberId = request.getParameter("memberId");
	member.memberPw = request.getParameter("memberPw");
	System.out.println(member.memberId + " <--- ID");
	System.out.println(member.memberPw + " <--- PW");
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost/gdj58","root","java1234"); //dbUrl, dbUser, dbPw
	
	String sql = "SELECT member_id memberId FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, member.memberId);
	stmt.setString(2, member.memberPw);	
	ResultSet rs = stmt.executeQuery();
	/* 
	String targetPage = "/loginForm.jsp";
	if(rs.next()) {
		targetPage = "/memberIndex.jsp";
		// 로그인 성공했다는 값 session에 저장
		session.setAttribute("loginMemberId", rs.getString("memberId"));
		// object loginMemberId = rs.getString("memberId") //다형성
		// String loginMemberId(String)(session.getAttribute("loginMemberId"))
		System.out.println("입력성공");
	}
	else {
		System.out.println("입력실패");
	}
	rs.close();
	stmt.close();
	conn.close();
	response.sendRedirect(request.getContextPath()+targetPage);	  */ 


	String targetPage = "/loginForm.jsp";
	
	if(rs.next()) {
		// 로그인 성공
		System.out.println("success");
		targetPage = "/memberIndex.jsp";
		// 로그인 성공했다는 값을 저장 -> session 
		session.setAttribute("loginMemberId", rs.getString("memberId"));
		// Object loginMemberId = rs.getString("memberId"); // 다형성
		// String loginMemberId = (String)(session.getAttribute("loginMemberId"));		
				
	}	
	rs.close();
	stmt.close();
	conn.close();
	response.sendRedirect(request.getContextPath()+targetPage);
%>
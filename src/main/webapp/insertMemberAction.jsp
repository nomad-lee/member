<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "java.sql.*" %>
<%@ page import = "java.net.*" %>
<%
	//인코딩 (한글)
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("memberId");
	String pw = request.getParameter("memberPw");
	String pw2 = request.getParameter("memberPw2");
	String name = request.getParameter("memberName");
	System.out.println(pw+""+pw2);

	if(id == null || pw == null || pw2 == null || name == null || id == "" || pw == "" || pw2 == "" || name == "") {
		String msg = URLEncoder.encode("모든 정보를 입력하세요", "utf-8"); //미입력 방지, get방식 주소창에 문자열 인코딩
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?msg="+msg);
		return;
	}  else if(!pw.equals(pw2)){
		String msgPwError = URLEncoder.encode("비밀번호를 확인해주세요", "utf-8"); //미입력 방지, get방식 주소창에 문자열 인코딩
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?msg="+msgPwError);
		return;
	}
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/gdj58","root","java1234");
	String sql = "insert into member(member_id, member_pw, member_name) values(?,PASSWORD(?),?)";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, id);
	stmt.setString(2, pw);
	stmt.setString(3, name);
	
	int row = stmt.executeUpdate();
	if(row ==1) {
		System.out.println("입력성공");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	} else {
		System.out.println("입력실패");
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp");
	}	

	stmt.close();
	conn.close();	
	
%>
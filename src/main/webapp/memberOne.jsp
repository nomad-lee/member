<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "java.sql.*" %>
<%
	// 1
	if(session.getAttribute("loginMemberId") == null) {
		// 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/memberIndex.jsp");
		return;
	}
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost/gdj58","root","java1234"); //dbUrl, dbUser, dbPw
	
	String sql = "SELECT member_name memberName FROM member WHERE member_id = ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, (String)(session.getAttribute("loginMemberId")));
	ResultSet rs = stmt.executeQuery();

	if(rs.next()) {
		session.setAttribute("loginMemberName", rs.getString("memberName"));
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberOne</title>
	<!-- 부트스트랩5 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<h1 class="text-center mt-3">내 정보</h1>
	<div class="container">
		<form action="<%=request.getContextPath()%>/loginAction.jsp" method="post">
			<table class = "table">
				<tr>
					<td>회원아이디</td>
					<td><input type="text" class="form-control" name="memberId" value="<%=(String)(session.getAttribute("loginMemberId"))%>" readonly></td>
				</tr>
				<tr>
					<td>회원이름</td>
					<td><input type="text" class="form-control" name="memberName" value="<%=(String)(session.getAttribute("loginMemberName"))%>" readonly></td>
				</tr>
			</table>
		</form>
	</div>
	<div class="container">
		<div class="row">
			<div class = "col-auto">
				<a class="btn btn-dark" href="<%=request.getContextPath()%>/updateMemberPwForm.jsp">비밀번호수정</a>
				<!-- updateMemberPwAction.jsp 수정 전 비밀번호, 변경할 비밀번호 -->
			</div>
			<div class = "col-auto">
				<a class="btn btn-dark" href="<%=request.getContextPath()%>/updateMemberForm.jsp">개인정보수정</a>
				<!-- updateMemberAction.jsp 비밀번호 수정은 X -->
			</div>
			<div class = "col-auto">
				<a class="btn btn-danger" href="<%=request.getContextPath()%>/deleteMemberForm.jsp">회원탈퇴</a>
				<!-- deleteMemberAction.jsp 비밀번호 확인 후 삭제 후 session.invalidate() -->
			</div>
		</div>
	</div>
</body>
</html>
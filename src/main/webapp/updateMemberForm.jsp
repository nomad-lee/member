<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 1
	if(session.getAttribute("loginMemberId") == null) {
		// 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/memberIndex.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateMemberPwForm</title>
	<!-- 부트스트랩5 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<h1 class="text-center mt-3">내정보 수정</h1>
	<!-- msg parameter값이 있으면 출력 -->
	<%
		String msg = request.getParameter("msg");
		if(msg != null) {
	%>
			<div class="text-red text-center" id="msg"><%=msg%></div> <!-- 제목을 입력하시오, 내용을 입력하시오 -->
	<%
		}
	%>
	<div class="container">
		<form action="<%=request.getContextPath()%>/updateMemberAction.jsp" method="post">
			<table class = "table">
				<tr>
					<td>아이디</td>
					<td><input type="text" class="form-control" name="memberId" value="<%=(String)(session.getAttribute("loginMemberId"))%>" readonly></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" class="form-control" name="memberName" value="<%=(String)(session.getAttribute("loginMemberName"))%>"></td>
				</tr>		
			</table>
			<button type="submit" class="btn btn-dark">수정완료</button>
		</form>
	</div>

</body>
</html>
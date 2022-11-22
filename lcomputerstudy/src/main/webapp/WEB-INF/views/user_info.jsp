<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>마이 페이지</h1>
	<hr>
		<div>
			<sec:authorize access="isAuthenticated()">
				<sec:authentication property="principal" var="principal"/>
					<h2>${principal }</h2>
					현재 권한 : ${principal.authorities }
			</sec:authorize>
			<br>
			<c:if test="${principal.authorities eq '[ROLE_USER]'}">
				<button onclick="location.href='/user/levelUp?uId=${principal.username}'">관리자 권한 변경</button>
			</c:if>
			<c:if test="${principal.authorities eq '[ROLE_ADMIN]'}">
				<button onclick="down()">관리자 권한 해제</button>
			</c:if>
			<br>
			<a href="/">돌아가기</a>
		</div>
</body>
</html>
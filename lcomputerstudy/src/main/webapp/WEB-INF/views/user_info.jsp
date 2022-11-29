<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유저 정보</title>
<script src="//code.jquery.com/jquery-3.6.1.min.js"></script>
</head>
<body>
	<h1>마이 페이지</h1>
	<hr>
		<div id="userInfo">
			<sec:authorize access="isAuthenticated()">
				<sec:authentication property="principal" var="principal"/>
					<h2>${principal }</h2>
					현재 권한 : ${principal.authorities }
					<input type="hidden" name="username" id="username" value="${principal.username }">
					<input type="hidden" name="password" id="password" value="${principal.password }">
			</sec:authorize>
			<br>
			<c:if test="${principal.authorities eq '[ROLE_USER]'}">
				<button id="levelUp">관리자 권한 변경</button>
			</c:if>
			<c:if test="${principal.authorities eq '[ROLE_ADMIN]'}">
				<button id="levelDown">관리자 권한 해제</button>
			</c:if>
			<br>
			<a href="/">돌아가기</a>
		</div>
</body>
<script>
	//관리자 권한 부여
	$(document).on('click', '#levelUp', function () {

		let username = $('#username').val();
		let password = $('#password').val();
		console.log(username);
		console.log(password);
		
		$.ajax({
			  method: "POST",
			  url: "/user/levelUp",
			  data: { username: username, password: password }
		})
		.done(function( msg ) {
		});
		
	});

	//관리자 권한 해제
	$(document).on('click', '#levelDown', function () {

		let username = $('#username').val();
		let password = $('#password').val();
		
		console.log(username);
		console.log(password);
		
		$.ajax({
			  method: "POST",
			  url: "/user/levelDown",
			  data: { username: username, password: password }
		})
		.done(function( msg ) {
		});
		
	});
</script>
</html>
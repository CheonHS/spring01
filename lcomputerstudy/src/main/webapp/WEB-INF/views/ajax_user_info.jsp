<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
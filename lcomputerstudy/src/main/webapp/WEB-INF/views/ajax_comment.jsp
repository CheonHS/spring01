<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<c:if test="${empty list}">댓글이 없습니다.</c:if>
<c:if test="${!empty list}">
   	<c:forEach var="list" items="${list }">
    	<div>
			<textarea name="cContent" class="cContentList" rows="2" readonly>${list.cContent }</textarea>
			<b style="font-size: 0.8em;">${list.cWriter } / ${list.cDateTime }</b>
    	</div>
   	</c:forEach>
</c:if>
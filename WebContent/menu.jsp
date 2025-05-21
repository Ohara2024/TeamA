<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../tool/header.jsp" %>
<%@ include file="../tool/sidebar.jsp" %>
    <h2>ようこそ、${sessionScope.name}さん！</h2>
    <a href="/TeamA/scoremanager/main/LogoutAction.action">ログアウト</a>
<%@ include file="../tool/footer.jsp" %>
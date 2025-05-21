<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../tool/header.jsp" %>
    <h2>ログイン</h2>
    <form action="${pageContext.request.contextPath}/scoremanager/LoginExecute.action" method="POST">
        <label for="id">ID:</label>
        <input type="text" id="id" name="id" required><br><br>

        <label for="password">パスワード:</label>
        <input type="password" id="password" name="password" required><br><br>

        <input type="submit" value="ログイン">
    </form>
<%@ include file="../tool/footer.jsp" %>
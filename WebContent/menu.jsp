<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../tool/header.jsp" %>
<%@ include file="../tool/sidebar.jsp" %>

<%
    // セッションからTeacherオブジェクトを取得
    bean.Teacher teacher = (bean.Teacher) session.getAttribute("user");
    String teacherName = (teacher != null) ? teacher.getName() : "ゲスト";
%>

<div class="content">
    <h2>ようこそ、<%= teacherName %>さん！</h2>
    <a href="<%= request.getContextPath() %>/scoremanager/main/LogoutAction.action">ログアウト</a>
</div>

<%@ include file="../tool/footer.jsp" %>

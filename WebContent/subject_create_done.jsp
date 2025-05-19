<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="bean.Subject" %>
<%
    Subject subject = (Subject) request.getAttribute("subject");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>登録完了</title>
</head>
<body>
    <h1>科目登録完了</h1>
    <p>以下の科目を登録しました。</p>
    <ul>
        <li>科目コード：<%= subject.getCd() %></li>
        <li>科目名：<%= subject.getName() %></li>
    </ul>
    <a href="SubjectListServlet">科目一覧へ</a>
</body>
</html>

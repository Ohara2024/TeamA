<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="bean.Subject,bean.School,dao.SubjectDao" %>

<%
    String cd = request.getParameter("cd");

    School school = new School();
    school.setCd("S001");

    SubjectDao dao = new SubjectDao();
    Subject subject = dao.get(cd, school);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>科目変更</title>
</head>
<body>
    <h2>科目情報変更</h2>
    <form action="subject_update_done.jsp" method="post">
        <input type="hidden" name="cd" value="<%= subject.getCd() %>">
        科目コード：<%= subject.getCd() %><br>
        科目名：<input type="text" name="name" value="<%= subject.getName() %>"><br>
        <input type="submit" value="変更">
        <button onclick="history.back()">戻る</button>

    </form>
</body>
</html>

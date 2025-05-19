<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="bean.Subject" %>
<%
    List<Subject> subjectList = (List<Subject>) request.getAttribute("subjectList");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>科目管理</title>
</head>
<body>
    <h1>科目管理</h1>
    <a href="subject_create.jsp">科目登録</a>
    <table border="1">
        <tr>
            <th>科目コード</th>
            <th>科目名</th>
            <th>変更</th>
            <th>削除</th>
        </tr>
        <%
            for (Subject subject : subjectList) {
        %>
        <tr>
            <td><%= subject.getCd() %></td>
            <td><%= subject.getName() %></td>
            <td><a href="subject_update.jsp?code=<%= subject.getCd() %>">変更</a></td>
            <td><a href="subject_delete.jsp?code=<%= subject.getCd() %>">削除</a></td>
        </tr>
        <%
            }
        %>
    </table>
</body>
</html>

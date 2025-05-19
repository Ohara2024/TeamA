<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="bean.Subject, bean.School, dao.SubjectDao" %>
<%
    request.setCharacterEncoding("UTF-8");

    String cd = request.getParameter("cd");

    School school = (School) session.getAttribute("school");

    Subject subject = new Subject();
    subject.setCd(cd);
    subject.setSchool(school);

    SubjectDao dao = new SubjectDao();
    boolean success = dao.delete(subject);
%>
<html>
<head>
    <title>削除完了</title>
</head>
<body>
    <h1>削除完了</h1>
    <% if (success) { %>
        <p>削除が完了しました。</p>
    <% } else { %>
        <p>削除に失敗しました。</p>
    <% } %>
    <a href="subject_list.jsp">一覧に戻る</a>
</body>
</html>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="bean.Subject, bean.School, dao.SubjectDao" %>
<%
    request.setCharacterEncoding("UTF-8");

    String cd = request.getParameter("cd");

    // 学校はセッションから取得（例: schoolという属性名）
    School school = (School) session.getAttribute("school");

    SubjectDao dao = new SubjectDao();
    Subject subject = dao.get(cd, school);
%>
<html>
<head>
    <title>科目情報削除</title>
</head>
<body>
    <h1>科目情報削除</h1>
    <p>以下の科目を削除します。よろしいですか？</p>
    <form action="subject_delete_done.jsp" method="post">
        <input type="hidden" name="cd" value="<%= subject.getCd() %>">
        <p>科目コード: <%= subject.getCd() %></p>
        <p>科目名: <%= subject.getName() %></p>
        <input type="submit" value="削除">
    </form>
    <button onclick="location.href='subject_list.jsp'">戻る</button>
</body>
</html>

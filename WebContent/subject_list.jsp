<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*,java.util.*" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>得点管理システム - 科目一覧</title>
<style>
    body { font-family: Arial, sans-serif; margin: 0; padding: 0; }
    .content { margin-left: 220px; padding: 20px; }
    h1 { color: #000; margin-top: 0; font-size: 26px; background-color: #f0f0f0; padding: 10px; }
    table { width: 100%; border-collapse: collapse; margin-top: 10px; }
    th, td { padding: 0.5em; text-align: left; border: 1px solid #CCCCCC; font-size: 14px; }
    th { background-color: #ffffff; font-weight: bold; }
    a { color: #007bff; text-decoration: underline; font-size: 14px; }
    a:hover { color: #0056b3; text-decoration: underline; }
    .error { color: red; font-size: 14px; }
    .top-actions { margin-bottom: 10px; display: flex; justify-content: flex-end; }
</style>
</head>
<body>
<div class="content">
<br><br><br><br>
<h1>科目一覧</h1>

<!-- 新規登録リンク -->
<div class="top-actions">
    <a href="subject_create.jsp">新規登録</a>
</div>

<%
    String url = "jdbc:h2:tcp://localhost/~/exam;LOCK_TIMEOUT=10000";
    String user = "sa";
    String password = "";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    List<Map<String, String>> subjects = new ArrayList<>();

    try {
        Class.forName("org.h2.Driver");
        conn = DriverManager.getConnection(url, user, password);

        String query = "SELECT CD, NAME FROM SUBJECT ORDER BY CD";
        pstmt = conn.prepareStatement(query);
        rs = pstmt.executeQuery();

        while (rs.next()) {
            Map<String, String> subject = new HashMap<>();
            subject.put("cd", rs.getString("CD"));
            subject.put("name", rs.getString("NAME"));
            subjects.add(subject);
        }
%>

<% if (subjects.isEmpty()) { %>
<p>科目情報が存在しませんでした</p>
<% } else { %>

<table>
<thead>
<tr>
    <th>科目コード</th>
    <th>科目名</th>

</tr>
</thead>
<tbody>
<%
    for (Map<String, String> subject : subjects) {
        String subjectCd = subject.get("cd");
        String subjectName = subject.get("name");
%>
<tr>
    <td><%= subjectCd %></td>
    <td><%= subjectName %></td>
    <td>
        <a href="SubjectUpdateAction?cd=<%= subjectCd %>">変更</a>　
        <a href="SubjectDeleteAction?cd=<%= subjectCd %>">削除</a>
    </td>
</tr>
<%
    }
%>
</tbody>
</table>
<% } %>

<%
    } catch (Exception e) {
        out.println("<p class='error'>エラー: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
    }
%>

</div>
</body>
</html>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>科目削除</title>
    <style>
        .delete-button {
            background-color: red;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
        }
        .delete-button:hover { opacity: 0.8; }
        .error { color: red; }
    </style>
</head>
<body>
    <h2>科目削除</h2>

    <%
        String error = (String) request.getAttribute("error");
        String name = (String) request.getAttribute("name");
        String cd = (String) request.getAttribute("cd");
    %>

    <% if (error != null) { %>
        <p class="error"><%= error %></p>
    <% } else { %>
        <p>「<strong><%= name != null ? name : "不明" %>（<%= cd != null ? cd : "不明" %>）</strong>」を削除してもよろしいですか？</p>
        <form action="SubjectDeleteExecuteAction" method="post">
            <input type="hidden" name="cd" value="<%= cd != null ? cd : "" %>">
            <input type="submit" class="delete-button" value="削除">
        </form>
    <% } %>

    <p><a href="subject_list.jsp">戻る</a></p>
</body>
</html>
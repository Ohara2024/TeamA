<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>科目変更</title>
    <style>
        .update-button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
        }
        .update-button:hover { opacity: 0.8; }
        .error { color: red; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; }
        input { width: 200px; padding: 5px; }
    </style>
</head>
<body>
    <h2>科目変更</h2>

    <%
        String error = (String) request.getAttribute("error");
        String currentCd = (String) request.getAttribute("currentCd");
        String name = (String) request.getAttribute("name");
    %>

    <% if (error != null) { %>
        <p class="error"><%= error %></p>
    <% } else { %>
        <form action="SubjectUpdateExecuteAction" method="post">
            <div class="form-group">
                <label for="cd">科目コード:</label>
                <input type="text" id="cd" name="cd" value="<%= currentCd != null ? currentCd : "" %>" required>
            </div>
            <div class="form-group">
                <label for="name">科目名:</label>
                <input type="text" id="name" name="name" value="<%= name != null ? name : "" %>" required>
            </div>
            <input type="submit" class="update-button" value="変更">
        </form>
    <% } %>

    <p><a href="subject_list.jsp">戻る</a></p>
</body>
</html>
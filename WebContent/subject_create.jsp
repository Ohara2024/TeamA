<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<% response.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>得点管理システム</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #fafafa;
        margin: 0;
        padding: 20px;
    }
    .container {
        width: 400px;
        margin: 40px auto;
        background-color: #fff;
        border: 1px solid #ddd;
        border-radius: 6px;
        padding: 30px;
        box-shadow: 0 2px 6px rgba(0,0,0,0.1);
    }
    h2 {
        background-color: #e0e0e0;
        padding: 10px;
        border-bottom: 1px solid #ccc;
        margin: -30px -30px 30px -30px;
    }
    label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
    }
    .form-control {
        width: 100%;
        padding: 10px;
        margin-bottom: 15px;
        border: 1px solid #ccc;
        border-radius: 4px;
    }
    .text-warning {
        color: #dc3545;
        margin-bottom: 10px;
    }
    .btn-primary {
        background-color: #007bff;
        color: #fff;
        padding: 10px 25px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }
    .btn-primary:hover {
        background-color: #0056b3;
    }
    .mx-auto {
        text-align: center;
    }
    .back-link {
        text-decoration: none;
        color: #007bff;
        font-size: 14px;
        display: block;
        text-align: center;
        margin-top: 10px;
    }
    .back-link:hover {
        text-decoration: underline;
    }
</style>
</head>
<body>
<div class="container">
    <h2 class="h3 mb-3 fw-normal bg-secondary bg-opacity-10 py-2 px-4">科目情報登録</h2>
    <form action="/test/SubjectCreateExecuteAction" method="post">
        <div>
            <label for="cd">科目コード</label><br>
            <input class="form-control" type="text" name="cd" id="cd" value="<%= request.getParameter("cd") != null ? request.getParameter("cd") : "" %>" required maxlength="3" placeholder="科目コードを入力してください" />
        </div>
        <div class="text-warning"><%= request.getAttribute("cdLengthError") != null ? request.getAttribute("cdLengthError") : "" %></div>
        <div class="text-warning"><%= request.getAttribute("cdDuplicateError") != null ? request.getAttribute("cdDuplicateError") : "" %></div>
        <div class="text-warning"><%= request.getAttribute("emptyError") != null ? request.getAttribute("emptyError") : "" %></div>
        <div>
            <label for="name">科目名</label><br>
            <input class="form-control" type="text" id="name" name="name" value="<%= request.getParameter("name") != null ? request.getParameter("name") : "" %>" required maxlength="20" placeholder="科目名を入力してください" />
        </div>
        <div class="mx-auto py-2">
            <button class="btn btn-primary" type="submit">登録</button>
        </div>
    </form>
    <a href="/test/subject_list.jsp" class="back-link">戻る</a>
</div>
</body>
</html>

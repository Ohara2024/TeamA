<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% response.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
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
    .success-message {
        color: green;
        margin-bottom: 15px;
    }
    .back-link {
        text-decoration: none;
        color: #007bff;
        font-size: 14px;
        display: block;
        text-align: center;
    }
    .back-link:hover {
        text-decoration: underline;
    }
</style>
</head>
<body>
<div class="container">
    <h2 class="h3 mb-3 fw-normal bg-secondary bg-opacity-10 py-2 px-4">科目情報登録完了</h2>
    <p class="success-message">科目情報が登録されました。</p>
    <a href="subject_list.jsp">戻る</a>
</div>
</body>
</html>
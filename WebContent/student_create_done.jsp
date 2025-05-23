<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, bean.Student" %>
<%@ include file="../tool/header.jsp" %>

<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        margin: 0;
    }

    html, body {
        height: 100%;
    }

    .main-content-area {
        flex-grow: 1;
        padding: 20px;
    }

    .page-title {
        font-size: 20px;
        font-weight: bold;
        margin-bottom: 20px;
        border-bottom: 1px solid #ccc;
        padding-bottom: 10px;
        color: #333;
    }

    .success-message-container {
        background-color: #dff0d8;
        color: #3c763d;
        border: 1px solid #d6e9c6;
        padding: 15px 20px;
        margin-bottom: 20px;
        border-radius: 4px;
        font-size: 16px;
        text-align: left;
    }

    .back-to-list-link {
        display: inline-block;
        margin-top: 20px;
        font-size: 14px;
        color: #337ab7;
        text-decoration: none;
    }

    .back-to-list-link:hover {
        text-decoration: underline;
    }
</style>

<div class="main-content-area">
    <h1 class="page-title">学生情報変更</h1>

    <div class="success-message-container">
        <p>変更が完了しました</p>
    </div>

    <a href="studentSearch" class="back-to-list-link">学生一覧</a>
</div>

<%@ include file="../tool/footer.jsp" %>
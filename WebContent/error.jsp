<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

    .error-message-container {
        background-color: #f2dede;
        color: #a94442;
        border: 1px solid #ebccd1;
        padding: 15px 20px;
        margin-bottom: 20px;
        border-radius: 4px;
        font-size: 16px;
        text-align: left;
    }

    .back-link {
        display: inline-block;
        margin-top: 20px;
        font-size: 14px;
        color: #337ab7;
        text-decoration: none;
    }

    .back-link:hover {
        text-decoration: underline;
    }
</style>

<div class="main-content-area">
    <h1 class="page-title">エラーページ</h1>

    <div class="error-message-container">
        <p>エラーが発生しました</p>
    </div>

    <a href="javascript:history.back()" class="back-link">戻る</a>
</div>

<%@ include file="../tool/footer.jsp" %>
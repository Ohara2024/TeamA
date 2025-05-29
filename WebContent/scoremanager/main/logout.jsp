<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>得点管理システム</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
        }
        header {
        	background-color: #e8f1ff;
        	padding: 10px 20px;
        	border-bottom: 1px solid #ccc;
        	margin: 0;
        }
        main {
            padding: 40px 20px;
            text-align: center;
        }
        .logout {
        	text-align: left;
        	background-color: #d3d3d3;
        }
        .logout-message {
            background-color: #d4edda;
            color: #155724;

        }
        .logout-url {
        	text-align: left;
        }
    </style>
</head>
<body>
    <header>
        得点管理システム
    </header>

    <main>
    	<div class="logout"><h1>ログアウト</h1></div>
        <div class="logout-message">ログアウトしました。</div><br><br>
        <div class="logout-url"><a href="/TeamA/scoremanager/login.jsp">ログイン</a></div>
    </main>

<%@ include file="/tool/footer.jsp" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String user="越澤"; %>
<style>
    header {
        background-color: #e8f1ff;
        padding: 10px 20px;
        border-bottom: 1px solid #ccc;
        margin: 0;
    }

    .header-title {
        font-size: 36px;
        font-weight: bold;
        margin: 0;
    }

    .header-sub {
        text-align: right;
        font-size: 14px;
        color: #333;
        margin-top: 5px;
    }
</style>

<header>
    <div class="header-title">得点管理システム</div>
    <% if (user != null) { %>
        <div class="header-sub">
             <%= user %> 様　<a href="">ログアウト</a>
        </div>
    <% } %>
</header>
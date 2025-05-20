<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String userName = (String) session.getAttribute("userName");
%>
<main>
	<div class="sidebar">
	    <ul>
	    	<% if (userName != null) { %>
	        <li><a href="">メニュー</a></li>
	        <li><a href="">学生管理</a></li>
	        <li><a href="">成績管理</a></li>
	        <li><a href="">成績登録</a></li>
	        <li><a href="">成績参照</a></li>
	        <li><a href="">科目管理</a></li>
	        <% } %>
	    </ul>
	</div>

	<style>
	.sidebar {
	    text-align: left;
    	background-color: #fff;
    	width: 250px;
    	border-right: 1px solid #ccc;
	}
	ul {
	    list-style-type: none;
	    padding: 0;
	}
	li {
	    margin: 10px 0;
	}
	</style>
</main>

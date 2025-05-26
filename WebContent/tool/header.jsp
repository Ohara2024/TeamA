<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    // セッションからTeacherオブジェクトを取得
    bean.Teacher teacher = (bean.Teacher) session.getAttribute("user");
    String teacherName = (teacher != null) ? teacher.getName() : "ゲスト";
%>
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
    .sidebar {
	    text-align: left;
    	background-color: #fff;
    	width: 250px;
    	border-right: 1px solid #ccc;
    	padding: 10px;
    	box-sizing: border-box;
	}
	ul {
	    list-style-type: none;
	    padding: 0;
	    margin: 0
	}
	li {
	    margin: 10px 0;
	}
	main{
    display: flex;
    min-height: 100vh;
    margin: 10px 0;
	}
	main h2{
		background-color:#f0f1f2;

	}
.content {
    flex: 1;
    padding: 20px;
    background-color: #f9f9f9;
    box-sizing: border-box;
}
</style>

<header>
    <div class="header-title">得点管理システム</div>
    <% if (teacherName != null) { %>
        <div class="header-sub">
             <%= teacherName %> 様　<a href="/TeamA/scoremanager/main/Logout.action">ログアウト</a>
        </div>
    <% } %>
</header>
<main>
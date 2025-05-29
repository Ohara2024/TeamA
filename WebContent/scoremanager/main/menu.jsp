<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/tool/header.jsp" %>
<%@ include file="/tool/sidebar.jsp" %>

<style>
	.menu-box1 {
		border: 2px solid #333; /* 枠線 */
    	padding: 20px; /* 内側の余白 */
    	width: 200px; /* ボックスの幅 */
    	text-align: center; /* テキストを中央揃え */
    	display: flex; /* ボックスを横並びにする */
	}
	.menu-box2 {
		border: 2px solid #333; /* 枠線 */
    	padding: 20px; /* 内側の余白 */
    	width: 200px; /* ボックスの幅 */
    	text-align: center; /* テキストを中央揃え */
    	display: flex; /* ボックスを横並びにする */
	}
	.menu-box3 {
		border: 1px solid #333; /* 枠線 */
    	padding: 20px; /* 内側の余白 */
    	width: 200px; /* ボックスの幅 */
    	text-align: center; /* テキストを中央揃え */
    	display: flex; /* ボックスを横並びにする */
	}
</style>



<div class="content">
    <h2>メニュー</h2>
    <div class="menu-box1">
    	<a href="/TeamA/scoremanager/main/StudentList.action">学生管理</a>
    </div>
    <div class="menu-box2">
    	<a href="#">成績管理</a>
    	<a href="#">成績登録</a>
    	<a href="#">成績参照</a>
    </div>
    <div class="menu-box3">
    	<a href="#">科目管理</a>
    </div>
</div>
<%@ include file="/tool/footer.jsp" %>

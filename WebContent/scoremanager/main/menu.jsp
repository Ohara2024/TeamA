<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>
<%@ include file="/tool/header.jsp" %>
<%@ include file="/tool/sidebar.jsp" %>

<style>
	.menu-box1 {
		font-size: 24px;
		float: left;
		border: 2px solid #ddbbbb; /* 枠線 */
		background-color:#ddbbbb;
		height: 100px;
		border-radius: 10px;
		margin-right: 20px;
		justify-content: center;      /* 横方向の中央揃え */
      	align-items: center;          /* 縦方向の中央揃え */
    	padding: 20px; /* 内側の余白 */
    	width: 200px; /* ボックスの幅 */
    	text-align: center; /* テキストを中央揃え */
    	display: flex; /* ボックスを横並びにする */
	}
	.menu-box2 {
		font-size: 24px;
		float: left;
		border: 2px solid #bbddbb; /* 枠線 */
		background-color:#bbddbb;
		height: 100px;
		border-radius: 10px;
		margin-right: 20px;
		justify-content: center;      /* 横方向の中央揃え */
      	align-items: center;          /* 縦方向の中央揃え */
    	padding: 20px; /* 内側の余白 */
    	width: 200px; /* ボックスの幅 */
    	text-align: center; /* テキストを中央揃え */
    	display: flex; /* ボックスを横並びにする */
		flex-direction: column;
	}
	.menu-box2 > * {
  white-space: nowrap;
  margin: 5px 0;
}
.menu-box2 > div,
.menu-box2 > a {
	display: block;
}
	.menu-box3 {
		font-size: 24px;
		float: left;
		border: 2px solid #bbbbdd; /* 枠線 */
		background-color:#bbbbdd;
		height: 100px;
		border-radius: 10px;
		justify-content: center;      /* 横方向の中央揃え */
      	align-items: center;          /* 縦方向の中央揃え */
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
<div>成績管理</div>
<a href="#">成績登録</a>
<a href="#">成績参照</a>
</div>
<div class="menu-box3">
<a href="#">科目管理</a>
</div>
</div>
<%@ include file="/tool/footer.jsp" %>
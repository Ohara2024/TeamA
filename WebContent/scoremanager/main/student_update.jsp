<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/tool/header.jsp" %>
<%@ include file="/tool/sidebar.jsp" %>

<div class="content">
<form action="StudentUpdateExecute.action" method="get">
<h2>学生情報変更</h2>
<label for="ent_year">入学年度</label><br>
<input type="text" name="ent_year" required><br>
<label for="no">学生番号</label><br>
<input type="text" name="no" required><br>

	<label for="name">氏名</label><br>
<input type="text" name="name" required><br>
<label for="class_num">クラス</label>
<select class="class"id="class" name="class_num">
  <option value="" selected>---</option>
  <option value="131">131</option>
  <option value="201">201</option>
</select>
<label for="attend">在学中</label>
<input type="checkbox" name="is_attend">
<button class="" id="">登録して終了</button>


</form>
</div>

<%@ include file="/tool/footer.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/tool/header.jsp" %>
<%@ include file="/tool/sidebar.jsp" %>
<style>

.main-content {

    padding: 20px 20px 20px 20px; /* 内側の余白 (上下左右) */
    margin-top: 20px; /* 上部の余白 */
    border-radius: 8px; /* 角丸 */
}
.col-filter { /* 検索フィルターの各カラムに適用するクラス */
    display: flex;
    flex-direction: column;
    align-items: flex-start; /* ラベルとセレクトボックスを左揃えにする */
    margin-bottom: 10px; /* 各フィルター項目の下部に余白 */
}

.form-label {
    font-weight: bold; /* ラベルを太字に */
    margin-bottom: 5px; /* ラベルとセレクトボックスの間の余白 */
    white-space: nowrap; /* ラベルが改行されないようにする */
}

/* 検索ボタンと登録ボタンのスタイル */
/* 画像の検索ボタンは少し明るいグレー */
.btn-secondary {
    border-color: #e0e0e0;
    color: #333;
    font-weight: bold;
    padding: 5px 15px;
    border-radius: 8px; /* 角丸 */
}

.form-select{
    padding:4px 12px;
    border-radius: 4px;
    text-align-last: left;
}


</style>
<div class="content">
<section>
<h2>成績管理</h2>

		<div class="main-content">

			<form method="get">
<div class="row border mb-3 py-2 align-items-end rounded" id="filter" style="border: 1px solid #e8e8e8;  padding: 15px; border-radius: 8px; margin: 0; display: flex;">

					<div class="col-auto col-filter" style="width: 150px;"> <label class="form-label" for="student-f1-select">入学年度</label>
<select class="form-select" id="student-f1-select" name="f1">
<option value="0">--------</option>
<c:forEach var="year" items="${entYearList }">
<%-- 現在のyearと選択されていたf1が一致していた場合selectedを追記 --%>
<option value="${year }" ${year eq f1 ? "selected" : "" }>${year }</option>
</c:forEach>
</select>
</div>

					<div class="col-auto col-filter" style="width: 150px;"> <label class="form-label" for="student-f2-select">クラス</label>
<select class="form-select" id="student-f2-select" name="f2">
<option value="0">--------</option>
<c:forEach var="num" items="${cNumList }">
<%-- 現在のnumと選択されていたf2が一致していた場合selectedを追記 --%>
<option value="${num }" ${num eq f2 ? "selected" : "" }>${num }</option>
</c:forEach>
</select>
</div>

					<div class="col-auto col-filter" style="width: 250px;"> <label class="form-label" for="student-f2-select">科目</label>
<select class="form-select" id="student-f2-select" name="f3">
<option value="0">--------</option>
<c:forEach var="subject" items="${list }">
<%-- 現在のsubject.cdと選択されていたf3が一致していた場合selectedを追記 --%>
<option value="${subject.cd }" ${subject.cd eq f3 ? "selected" : "" }>${subject.name }</option>
</c:forEach>
</select>
</div>

					<div class="col-auto col-filter" style="width: 150px;"> <label class="form-label" for="student-f2-select">回数</label>
<select class="form-select" id="student-f2-select" name="f4">
<option value="0">--------</option>
<c:forEach var="num" items="${countList }">
<%-- 現在のnumと選択されていたf4が一致していた場合selectedを追記 --%>
<option value="${num }" ${num eq f4 ? "selected" : "" }>${num }</option>
</c:forEach>
</select>
</div>

					<div class="col-auto text-center align-self-end ms-auto" style="margin-bottom: 10px;"> <button class="btn btn-secondary" id="filter-button">検索</button>
</div>

					<div class="mt-2 text-warning">${errors.get("a") }</div>

				</div>
</form>

			<form action="TestRegistExecute.action" method="get">
<c:choose>
<c:when test="${testlist.size()>0 }">

						<div>科目：${subject_name }（${f4 }回）</div>

						<table class="table table-hover mt-3" style="  overflow: hidden; width: 100%;">

								<tr class="table-name">
<th>入学年度</th>
<th>クラス</th>
<th>学生番号</th>
<th>氏名</th>
<th>点数</th>
</tr>

							<c:forEach var="test" items="${testlist }" varStatus="st">
<tr  class="table-score">
<td>${test.student.entYear }</td>
<td>${test.classNum }</td>
<td>${test.student.no }</td>
<td>${test.student.name }</td>
<td>
<input type="text" class="form-control" name="point_${test.student.no }" style="width: 80px;"
<c:if test="${test.no != 0}">value="${test.point }"</c:if>
											value="">
<div class="mt-2 text-warning">${errors.get(st.count) }</div>
</td> </tr>
<input type="hidden" name="regist" value="${test.student.no }">
</c:forEach>
</table>

						<input type="hidden" name="count" value="${f4 }">
<input type="hidden" name="subject" value="${f3 }">

						<div class="col-12 text-center mt-3 mb-3"> <button class="btn btn-secondary" id="filter-button">登録して終了</button>
</div>

					</c:when>
</c:choose>
</form>

			<%-- 条件に一致する学生が見つからなかった場合のメッセージ --%>
<c:if test="${testlist.size() == 0 && f1 != null && f1 != '0'}">
<div class="mt-3 text-center text-secondary">条件に一致する学生が見つかりませんでした。</div>
</c:if>
</div>
</section>
</div>
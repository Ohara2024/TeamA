<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, bean.Student" %>
<%@ include file="/tool/header.jsp" %>
<%@ include file="/tool/sidebar.jsp" %>

<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        margin: 0;
        background-color: #f0f2f5;
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

    .form-container {
        background-color: #ffffff;
        padding: 30px;
        border-radius: 5px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        max-width: 600px;
        margin: 0 auto;
    }

    .form-group {
        margin-bottom: 25px;
    }

    .form-group label {
        display: block;
        font-size: 14px;
        color: #555;
        margin-bottom: 8px;
        font-weight: bold;
    }

    .form-control {
        width: 100%;
        padding: 10px 12px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 16px;
        box-sizing: border-box;
    }

    .form-control::placeholder {
        color: #aaa;
    }

    .hint-text {
        font-size: 12px;
        color: #777;
        margin-top: 5px;
        display: block;
    }

    .submit-button {
        background-color: gray;
        color: white;
        padding: 12px 25px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
        margin-top: 20px;
        display: inline-block;
    }

    .back-link {
        display: block;
        margin-top: 15px;
        color: #337ab7;
        text-decoration: none;
        font-size: 14px;
    }

    .back-link:hover {
        text-decoration: underline;
    }
</style>

<div class="main-content-area">
    <h1 class="page-title">学生情報登録</h1>

    <div class="form-container">
        <form id="studentForm" action="StudentCreateExecute.action" method="post" onsubmit="return validateForm()">
            <div class="form-group">
                <label for="entYear">入学年度</label>
                <select name="ent_year" id="ent_year" class="form-control select-dropdown" required>
                    <option value="">--------</option>
                    <option value="2021">2021</option>
                    <option value="2022">2022</option>
                    <option value="2023">2023</option>
                    <option value="2024">2024</option>
                </select>
                <span class="hint-text"></span>
            </div>

            <div class="form-group">
                <label for="no">学生番号</label>
                <input type="text" id="no" name="no" class="form-control" placeholder="学生番号を入力してください" required />
                <span class="hint-text"></span>
            </div>

            <div class="form-group">
                <label for="name">氏名</label>
                <input type="text" id="name" name="name" class="form-control" placeholder="氏名を入力してください" required />
                <span class="hint-text"></span>
            </div>

            <div class="form-group">
                <label for="classNum">クラス</label>
                <select name="class_num" id="class_num" class="form-control select-dropdown" required>
                    <option value="101">101</option>
                    <option value="102">102</option>
                    <option value="201">201</option>
                    <option value="202">202</option>
                </select>
                <span class="hint-text"></span>
            </div>

            <button type="submit"  name="end" class="submit-button">登録して終了</button>
        </form>
        <a href="/TeamA/scoremanager/main/StudentList.action" class="back-link">戻る</a>
    </div>
</div>

<script>
    function validateForm() {
        const entYear = document.getElementById("ent_year").value;
        const no = document.getElementById("no").value.trim();
        const name = document.getElementById("name").value.trim();

        if (entYear === "") {
            alert("入学年度を選択してください。");
            return false;
        }

        if (no === "") {
            alert("学生番号を入力してください。");
            return false;
        }

        if (name === "") {
            alert("氏名を入力してください。");
            return false;
        }

        return true;
    }
</script>

<%@ include file="/tool/footer.jsp" %>

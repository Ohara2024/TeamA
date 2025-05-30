<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, bean.Student" %>
<%@ include file="/tool/header.jsp" %>
<%@ include file="/tool/sidebar.jsp" %>

<style>

    /* ページタイトル */
    .page-title {
        font-size: 20px;
        font-weight: bold;
        margin-bottom: 20px;
        border-bottom: 1px solid #ccc;
        padding-bottom: 10px;
        color: #333; /* タイトル色 */
    }

    /* 検索フォームと新規登録ボタンのコンテナ */
    .search-form-container {
        display: flex;
        justify-content: space-between; /* 検索フォームと新規登録ボタンを左右に配置 */
        align-items: flex-end; /* 下端揃え */
        margin-bottom: 20px;
        padding: 20px;
        border-radius: 5px;
        flex-wrap: wrap; /* レスポンシブ対応 */
    }

    /* 検索フォーム */
    .search-form {
        display: flex;
        align-items: flex-end; /* 下端揃え */
        flex-wrap: wrap; /* レスポンシブ対応 */
        gap: 15px; /* 各フォーム要素間の間隔 */
    }

    /* 各フォームグループ（ラベルと入力欄） */
    .form-group {
        margin-bottom: 10px; /* 小さい画面で折り返した際に間隔をあける */
    }

    .form-group label {
        display: block;
        margin-bottom: 5px;
        font-size: 14px;
    }

    /* ドロップダウンと入力フィールドの共通スタイル */
    .form-control {
        padding: 8px 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 14px;
        width: 120px; /* ある程度幅を指定 */
        box-sizing: border-box; /* パディングとボーダーを幅に含める */
    }

    /* チェックボックスのグループ */
    .checkbox-group {
        display: flex;
        align-items: center; /* チェックボックスとラベルを縦方向中央揃え */
        margin-top: 5px; /* ラベルとの位置調整 */
    }

    .form-checkbox {
        margin-right: 5px; /* チェックボックスとラベルの間隔 */
        /* チェックボックスのデフォルトスタイルをリセットし、カスタムスタイルを適用する場合 */
        /* appearance: none; */
        /* -webkit-appearance: none; */
        /* width: 16px; */
        /* height: 16px; */
        /* border: 1px solid #ccc; */
        /* border-radius: 3px; */
        /* background-color: #f0f0f0; */
        /* cursor: pointer; */
    }

    /* .form-checkbox:checked { */
    /* background-color: #337ab7; */
    /* border-color: #337ab7; */
    /* } */

    /* .form-checkbox:checked::before { */
    /* content: '✔'; */
    /* display: block; */
    /* color: white; */
    /* font-size: 12px; */
    /* text-align: center; */
    /* line-height: 16px; */
    /* } */


    .checkbox-label {
        font-size: 14px;
        color: #555;
    }

    /* 絞り込みボタン */
    .search-button {
        background-color: gray;
        color: white;
        padding: 10px 15px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 14px;
        margin-left: 20px; /* 他のフォーム要素との間隔 */
    }

    /* 検索結果件数表示 */
    .result-info {
        margin-bottom: 10px;
        padding: 0 5px; /* 左右の余白 */
    }

    .result-count {
        font-size: 14px;
        color: #333;
    }

.new-registration-button {
    float: right; /* 要素を右に浮かせる */
    margin-left: 20px; /* 左側にスペースが必要なら */
    /* 既存のボタンのCSSスタイル */
    display: inline-block;
    padding: 10px 20px;
    text-decoration: none;
}

    /* 学生リストテーブル */
    .student-table {
        width: 100%;
        border-collapse: collapse;
        background-color: #ffffff;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        border-radius: 5px;
        overflow: hidden; /* 角丸を効かせるため */
    }

    .student-table th, .student-table td {
        padding: 12px 15px;
        text-align: left;
        border-bottom: 1px solid #ddd;
        font-size: 14px;
        color: #333;
    }

    .student-table th {
        font-weight: bold;
        color: #555;
    }

    .student-table tr:nth-child(even) {
        background-color: #f9f9f9; /* 偶数行の背景色 */
    }

    .student-table tr:hover {
        background-color: #f1f1f1; /* ホバー時の背景色 */
    }

    /* 変更リンク */
    .action-link {
        color: #337ab7; /* リンク色（青系） */
        text-decoration: none;
    }

    .action-link:hover {
        text-decoration: underline;
    }
</style>

<div class="content">
    <h1 class="page-title">学生管理</h1>
    <a href="StudentCreate.action" class="new-registration-button">新規登録</a>
    <div class="search-form-container">
        <form method="get" action="/TeamA/scoremanager/main/StudentList.action" class="search-form">
            <div class="form-group">
                <label for="f1">入学年度:</label>
                <select name="f1" id="f1" class="form-control">
                    <option value="">----</option>
                    <%
                        List<Integer> entYears = (List<Integer>) request.getAttribute("entYears");
                        String selectedEntYear = request.getParameter("entYear");
                        if (entYears != null) {
                            for (Integer year : entYears) {
                    %>
                                <option value="<%= year %>" <%= (String.valueOf(year).equals(selectedEntYear)) ? "selected" : "" %>><%= year %></option>
                    <%
                            }
                        }
                    %>
                </select>
            </div>

            <div class="form-group">
                <label for="f2">クラス:</label>
                <select name="f2" id="f2" class="form-control">
                    <option value="">----</option>
                    <%
                        List<String> classNums = (List<String>) request.getAttribute("classNums");
                        String selectedClass = request.getParameter("classNum");
                        if (classNums != null) {
                            for (String cNum : classNums) {
                    %>
                                <option value="<%= cNum %>" <%= (cNum.equals(selectedClass)) ? "selected" : "" %>><%= cNum %></option>
                    <%
                            }
                        }
                    %>
                </select>
            </div>

            <div class="form-group checkbox-group">
                <input type="checkbox" name="f3" value="true" id="f3" class="form-checkbox"
                    <%= ("true".equals(request.getParameter("isAttend"))) ? "checked" : "" %>>
                <label for="f3" class="checkbox-label">在学中</label>
            </div>

            <button type="submit" class="search-button">絞り込み</button>
        </form>
    </div>

    <div class="result-info">
        <span class="result-count">検索結果：
        <%
            List<Student> students = (List<Student>) request.getAttribute("students");
            if (students != null) {
                out.print(students.size());
            } else {
                out.print("0");
            }
        %>件</span>
    </div>

    <table class="student-table">
        <thead>
            <tr>
                <th>入学年度</th>
                <th>学生番号</th>
                <th>氏名</th>
                <th>クラス</th>
                <th>在学中</th>
            </tr>
        </thead>
        <tbody>
            <%
                if (students != null && !students.isEmpty()) {
                    for (Student s : students) {
            %>
            <tr>
                <td><%= s.getEntYear() %></td>
                <td><%= s.getNo() %></td>
                <td><%= s.getName() %></td>
                <td><%= s.getClassNum() %></td>
                <td><%= s.isAttend() ? "〇" : "×" %></td>
                <td><a href="StudentUpdate.action?No=<%= s.getNo() %>" class="action-link">変更</a></td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr><td colspan="6" style="text-align: center;">学生情報が存在しませんでした</td></tr>
            <%
                }
            %>
        </tbody>
    </table>
</div>
<%@ include file="/tool/footer.jsp" %>
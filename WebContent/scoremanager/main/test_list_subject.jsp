<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>成績一覧（科目）</title>
    <style>
        body {
            font-family: sans-serif;
            margin: 0;
            background-color: #ffffff; /* bodyの背景色（ページ全体の背景） */
        }
        .main {
            flex: 1;
            padding: 20px;
            background-color: #ffffff; /* mainコンテンツの背景色を白にする */
            margin-bottom: 120px;
        }
        /* 新しくフォーム全体を囲むコンテナ */
        .combined-form-container {
            border: 1px solid #ddd; /* 外枠のボーダー */
            border-radius: 6px;
            background: #ffffff;
            margin-bottom: 20px;
            padding: 16px; /* 内部のパディング */
            width: fit-content; /* コンテンツに合わせて幅を調整 */
            min-width: 600px; /* ある程度の最小幅を確保 */
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            display: flex; /* 内部のフォームをflexで配置 */
            flex-direction: column; /* フォームを縦に並べる */
        }
        .form-box {
            border: none; /* 個別のフォームボックスのボーダーを削除 */
            background: none; /* 個別のフォームボックスの背景を削除 */
            padding: 0; /* 個別のフォームボックスのパディングを削除 */
            margin-bottom: 0; /* 個別のフォームボックスのマージンを削除 */
            width: auto; /* 幅を自動調整 */
        }

        /* フォーム間の区切り線 */
        .combined-form-container > form:first-of-type {
            padding-bottom: 15px; /* 上のフォームの下にスペース */
            margin-bottom: 15px; /* 上のフォームの下にスペース */
            border-bottom: 1px solid #eee; /* 区切り線 */
        }
        .combined-form-container > form:last-of-type {
            padding-top: 15px; /* 下のフォームの上にスペース */
        }


        .form-section {
            display: flex;
            align-items: baseline;
            /* margin-bottom: 15px; を削除、親のflexコンテナで制御 */
        }
        .form-label {
            font-weight: bold;
            display: inline-block;
            margin-right: 20px;
            white-space: nowrap;
            min-width: 80px;
            text-align: left; /* ラベルを左揃えにする */
            /* align-self: flex-start; */ /* 親のflexコンテナで制御 */
        }

        /* 科目情報フォームのレイアウト */
        .subject-form-fields {
            display: flex;
            align-items: flex-end;
            gap: 20px;
            flex-wrap: wrap;
        }
        .subject-form-field {
            display: flex;
            flex-direction: column;
        }
        .subject-form-field label {
            margin-bottom: 4px;
        }

        /* 学生情報フォームのレイアウト */
        .student-form-row {
            display: flex;
            align-items: flex-end;
            gap: 10px;
            flex-wrap: wrap;
        }
        .student-input-group {
            display: flex;
            flex-direction: column;
        }

        .select,
        input[type="text"] {
            padding: 4px 6px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }
        input[type="text"] {
            width: 200px;
        }
        .submit-btn {
            background-color: #4a5568;
            color: #fff;
            border: none;
            padding: 6px 10px;
            border-radius: 4px;
            cursor: pointer;
            height: fit-content;
            align-self: flex-end;
            margin-left: 20px; /* 検索ボタンの左マージンを調整 */
        }

        .error-msg {
            color: #d9534f;
            margin-top: 12px;
            font-size: 0.95em;
            margin-bottom: 20px; /* エラーメッセージの下にもスペース */
        }
        .main .title-bar {
            background: #f0f0f0;
            font-size: 18px;
            font-weight: bold;
            padding: 10px;
            margin-bottom: 16px;
            border-radius: 4px; /* タイトルバーも少し丸める */
        }
        .note {
            color: #00a1e9;
            margin-top: 20px;
            font-size: 0.9em;
        }
        .subject-name-display {
            font-weight: bold;
            margin-top: 20px;
            margin-bottom: 10px;
            padding-bottom: 5px; /* 下線とのスペース */
            border-bottom: 1px solid #eee; /* 下線 */
            font-size: 1.1em;
        }

        table {
            border-collapse: collapse;
            width: 90%;
            margin-top: 16px;
            background-color: #fff; /* テーブルの背景色を白に */
        }

        th, td {
            border: 1px solid #e0e0e0; /* 線の色を薄く */
            padding: 10px 12px; /* パディングを調整 */
            text-align: center;
        }

        th {
            background-color: #f8f8f8; /* ヘッダの背景色 */
            font-weight: bold;
            color: #333;
        }
        /* 成績テーブルの奇数行の背景色を少し変える */
        tbody tr:nth-child(odd) {
            background-color: #ffffff;
        }
        /* 成績テーブルの偶数行の背景色 */
        tbody tr:nth-child(even) {
            background-color: #ffffff;
        }

        /* エラーメッセージ、タイトルバー、ノートのスタイルは維持 */
        .error-msg {
            color: #d9534f;
            margin-top: 12px;
            font-size: 0.95em;
            margin-bottom: 20px;
        }
        .main .title-bar {
            background: #f0f0f0;
            font-size: 18px;
            font-weight: bold;
            padding: 10px;
            margin-bottom: 16px;
            border-radius: 4px;
        }
        .message { /* 検索結果がない場合のメッセージ */
            margin-top: 20px;
            padding: 10px;
            border: 1px solid #ccc;
            background-color: #f9f9f9;
            text-align: center;
            color: #555;
        }
    </style>
</head>
<body>

<%@ include file="/tool/header.jsp" %>
    <div class="sidebar">
        <%@ include file="/tool/sidebar.jsp" %>
    </div>

    <div class="main">
        <div class="title-bar">成績一覧（科目）</div>

        <%
            String lackError = (String)request.getAttribute("lackError");
            String nothingError = (String)request.getAttribute("nothingError");
            String errorMessage = (String)request.getAttribute("error_message");

            if (lackError != null) {
        %>
            <div class="error-msg"><%= lackError %></div>
        <%
            } else if (nothingError != null) {
        %>
            <div class="error-msg"><%= nothingError %></div>
        <%
            } else if (errorMessage != null) {
        %>
            <div class="error-msg"><%= errorMessage %></div>
        <%
            }
        %>

        <div class="combined-form-container">
            <form action="TestListSubjectExecute.action" method="get" class="form-box">
                <div class="form-section">
                    <span class="form-label">科目情報</span>
                    <div class="subject-form-fields">
                        <div class="subject-form-field">
                            <label for="ent_year">入学年度</label>
                            <select name="ent_year" id="ent_year" class="select">
                                <option value="">--------</option>
                                <%
                                List<Integer> entYearSet = (List<Integer>)request.getAttribute("ent_year_set");
                                String selectedEntYear = request.getParameter("ent_year");
                                if (entYearSet != null) {
                                    for (Integer y : entYearSet) {
                                        String selected = "";
                                        if (selectedEntYear != null && String.valueOf(y).equals(selectedEntYear)) {
                                            selected = "selected";
                                        }
                                %>
                                        <option value="<%= y %>" <%= selected %>><%= y %></option>
                                <%
                                    }
                                }
                                %>
                            </select>
                        </div>

                        <div class="subject-form-field">
                            <label for="class_num">クラス</label>
                            <select name="class_num" id="class_num" class="select">
                                <option value="">--------</option>
                                <%
                                List<String> classNumList = (List<String>)request.getAttribute("class_num_set");
                                String selectedClassNum = request.getParameter("class_num");
                                if (classNumList != null) {
                                    for (String c : classNumList) {
                                        String selected = "";
                                        if (selectedClassNum != null && c.equals(selectedClassNum)) {
                                            selected = "selected";
                                        }
                                %>
                                        <option value="<%= c %>" <%= selected %>><%= c %></option>
                                <%
                                    }
                                }
                                %>
                            </select>
                        </div>

                        <div class="subject-form-field">
                            <label for="subject_cd">科目</label>
                            <select name="subject_cd" id="subject_cd" class="select">
                                <option value="">--------</option>
                                <%
                                List<bean.Subject> subjectList = (List<bean.Subject>)request.getAttribute("subjects");
                                String selectedSubjectCd = request.getParameter("subject_cd");
                                if (subjectList != null) {
                                    for (bean.Subject sbj : subjectList) {
                                        String selected = "";
                                        if (selectedSubjectCd != null && sbj.getCd().equals(selectedSubjectCd)) {
                                            selected = "selected";
                                        }
                                %>
                                        <option value="<%= sbj.getCd() %>" <%= selected %>><%= sbj.getName() %></option>
                                <%
                                    }
                                }
                                %>
                            </select>
                        </div>
                        <input type="hidden" name="action" value="subjectSearch">
                        <input type="submit" value="検索" class="submit-btn">
                    </div>
                </div>
            </form>

            <form action="TestListStudentExecute.action" method="get" class="form-box">
                <div class="form-section">
                    <span class="form-label">学生情報</span>
                    <div class="student-form-row">
                        <div class="student-input-group">
                            <label for="student_no">学生番号</label>
                            <%
                                String selectedStudentNo = (String)request.getAttribute("selected_student_no");
                                if (selectedStudentNo == null) {
                                    selectedStudentNo = request.getParameter("student_no");
                                }
                            %>
                            <input type="text" name="student_no" id="student_no" maxlength="10"
                                   placeholder="学生番号を入力してください"
                                   value="<%= (selectedStudentNo != null ? selectedStudentNo : "") %>">
                        </div>
                        <input type="hidden" name="action" value="studentSearch">
                        <input type="submit" value="検索" class="submit-btn">
                    </div>
                </div>
            </form>
        </div>

        <%
        String subjectName = (String)request.getAttribute("subjectName");
        if (subjectName != null && !subjectName.isEmpty()) {
        %>
            <p class="subject-name-display">科目：<%= subjectName %></p>
        <%
        }
        %>

        <%
        List<bean.TestListSubject> resultList = (List<bean.TestListSubject>)request.getAttribute("resultList");
        if (resultList != null && !resultList.isEmpty()) {
        %>
            <table>
                <thead>
                    <tr>
                        <th>入学年度</th>
                        <th>クラス</th>
                        <th>学生番号</th>
                        <th>氏名</th>
                        <th>1回</th>
                        <th>2回</th>
                    </tr>
                </thead>
                <tbody>
                <%
                for (bean.TestListSubject row : resultList) {
                    java.util.Map<Integer, Integer> pointMap = row.getPoints();
                %>
                    <tr>
                        <td><%= row.getEntYear() %></td>
                        <td><%= row.getClassNum() %></td>
                        <td><%= row.getStudentNo() %></td>
                        <td><%= row.getStudentName() %></td>
                        <td><%= (pointMap != null && pointMap.containsKey(1) ? (pointMap.get(1) != null ? pointMap.get(1) : "-") : "-") %></td>
                        <td><%= (pointMap != null && pointMap.containsKey(2) ? (pointMap.get(2) != null ? pointMap.get(2) : "-") : "-") %></td>
                    </tr>
                <%
                }
                %>
                </tbody>
            </table>
        <%
        } else {
            if (request.getAttribute("nothingError") == null && request.getAttribute("lackError") == null && request.getAttribute("error_message") == null) {
        %>
                <div class="message">検索結果がありません。</div>
        <%
            }
        }
        %>

    </div>

<%@ include file="/tool/footer.jsp" %>
</body>
</html>
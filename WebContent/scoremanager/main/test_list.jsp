<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, bean.Subject" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>成績参照</title>
    <style>
        body {
            font-family: sans-serif;
            margin: 0;
            background-color: #ffffff; /* bodyの背景色（ページ全体の背景） */
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
    </style>
</head>
<body>

<%@ include file="/tool/header.jsp" %>

        <%@ include file="/tool/sidebar.jsp" %>

    <div class="content">
        <h2>成績参照</h2>

        <%
            String lackError = (String)request.getAttribute("lackError");
            String nothingError = (String)request.getAttribute("nothingError");
            String errorMessage = (String)request.getAttribute("error_message");
            if (lackError != null) {
        %>
            <div class="error-msg"><%= lackError %></div>
        <% } else if (nothingError != null) { %>
            <div class="error-msg"><%= nothingError %></div>
        <% } else if (errorMessage != null) { %>
            <div class="error-msg"><%= errorMessage %></div>
        <% } %>

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
                                    String selectedEntYearStr = (String)request.getAttribute("selected_ent_year");
                                    if (selectedEntYearStr == null) {
                                        selectedEntYearStr = request.getParameter("ent_year");
                                    }
                                    if (entYearSet != null) {
                                        for (Integer y : entYearSet) {
                                            String selected = (selectedEntYearStr != null && String.valueOf(y).equals(selectedEntYearStr)) ? "selected" : "";
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
                                    List<String> classNumSet = (List<String>)request.getAttribute("class_num_set");
                                    String selectedClassNum = (String)request.getAttribute("selected_class_num");
                                    if (selectedClassNum == null) {
                                        selectedClassNum = request.getParameter("class_num");
                                    }
                                    if (classNumSet != null) {
                                        for (String c : classNumSet) {
                                            String selected = (selectedClassNum != null && c.equals(selectedClassNum)) ? "selected" : "";
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
                                    List<Subject> subjects = (List<Subject>)request.getAttribute("subjects");
                                    String selectedSubjectCd = (String)request.getAttribute("selected_subject_cd");
                                    if (selectedSubjectCd == null) {
                                        selectedSubjectCd = request.getParameter("subject_cd");
                                    }
                                    if (subjects != null) {
                                        for (Subject sbj : subjects) {
                                            String selected = (selectedSubjectCd != null && sbj.getCd().equals(selectedSubjectCd)) ? "selected" : "";
                                %>
                                            <option value="<%= sbj.getCd() %>" <%= selected %>><%= sbj.getName() %></option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>
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
                        <input type="submit" value="検索" class="submit-btn">
                    </div>
                </div>
            </form>
        </div>

        <p class="note">科目情報を選択または学生情報を入力して検索ボタンをクリックしてください</p>
    </div>

<%@ include file="/tool/footer.jsp" %>
</body>
</html>
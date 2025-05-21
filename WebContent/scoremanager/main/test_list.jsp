<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="bean.Subject" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>成績参照・一覧</title>
</head>
<body>
    <h1>成績参照</h1>

    <%-- 科目情報による検索フォーム --%>
    <form action="TestListSubjectExecuteAction" method="post">
        <table>
            <tr>
                <th>科目情報</th>
                <th>入学年度</th>
                <td>
                    <select name="ent_year">
                        <option value="">-- 選択 --</option>
                        <%
                            List<Integer> yearList = (List<Integer>) request.getAttribute("yearList");
                            String selectedYear = (String) request.getAttribute("ent_year_selected");
                            if (yearList != null) {
                                for (Integer year : yearList) {
                        %>
                                    <option value="<%= year %>" <%= (selectedYear != null && selectedYear.equals(String.valueOf(year))) ? "selected" : "" %>>
                                        <%= year %>
                                    </option>
                        <%
                                }
                            }
                        %>
                    </select>
                </td>
                <th>クラス</th>
                <td>
                    <select name="class_num">
                        <option value="">-- 選択 --</option>
                        <%
                            List<String> classNumList = (List<String>) request.getAttribute("classNumList");
                            String selectedClassNum = (String) request.getAttribute("class_num_selected");
                            if (classNumList != null) {
                                for (String classNum : classNumList) {
                        %>
                                    <option value="<%= classNum %>" <%= (selectedClassNum != null && selectedClassNum.equals(classNum)) ? "selected" : "" %>>
                                        <%= classNum %>
                                    </option>
                        <%
                                }
                            }
                        %>
                    </select>
                </td>
                <th>科目</th>
                <td>
                    <select name="subject_cd">
                        <option value="">-- 選択 --</option>
                        <%
                            List<bean.Subject> subjectList = (List<bean.Subject>) request.getAttribute("subjectList");
                            String selectedSubjectCd = (String) request.getAttribute("subject_cd_selected");
                            if (subjectList != null) {
                                for (bean.Subject subject_option : subjectList) {
                        %>
                                    <option value="<%= subject_option.getCd() %>" <%= (selectedSubjectCd != null && selectedSubjectCd.equals(subject_option.getCd())) ? "selected" : "" %>>
                                        <%= subject_option.getName() %>
                                    </option>
                        <%
                                }
                            }
                        %>
                    </select>
                </td>
                <td><input type="submit" value="検索"></td>
            </tr>
        </table>
    </form>

    <%-- 学生情報による検索フォーム --%>
    <form action="TestListStudentExecuteAction" method="post">
        <table>
            <tr>
                <th>学生情報</th>
                <th>学籍番号</th>
                <td colspan="5">
                    <input type="text" name="student_no" value="<%= request.getAttribute("student_no_selected") != null ? (String) request.getAttribute("student_no_selected") : "" %>" placeholder="学籍番号を入力してください">
                </td>
                <td><input type="submit" value="検索"></td>
            </tr>
        </table>
    </form>

    <%-- エラーメッセージ表示エリア --%>
    <%
        List<String> errorMsg = (List<String>) request.getAttribute("errorMsg");
        if (errorMsg != null && !errorMsg.isEmpty()) {
    %>
        <div style="color: red;">
            <ul>
                <% for (String msg : errorMsg) { %>
                    <li><%= msg %></li>
                <% } %>
            </ul>
        </div>
    <%
        }
    %>

    <%-- 検索結果の表示を条件分岐でインクルード --%>
    <%
        // TestListSubjectExecuteActionがフォワードした場合
        if (request.getAttribute("testListSubject") != null) {
            // testListSubjectResult は、TestListSubjectExecuteActionがセットする任意のフラグやオブジェクト
            // 例: request.setAttribute("testListSubjectResult", true);
    %>
        <jsp:include page="test_list_subject.jsp" />
    <%
        // TestListStudentExecuteActionがフォワードした場合
        } else if (request.getAttribute("testListStudent") != null) {
    %>
        <jsp:include page="test_list_student.jsp" />
    <%
        }
    %>

    <br>
<th>科目情報を選択または学生情報を入力して検索ボタンをクリックしてください</th>
</body>
</html>
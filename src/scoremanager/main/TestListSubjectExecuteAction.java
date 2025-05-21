package scoremanager.main;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.School;
import bean.Subject;
import bean.Teacher;
import bean.TestListSubject;
import dao.SubjectDao;
import dao.TestListSubjectDao;

@WebServlet("/scoremanager/main/TestListSubjectExecuteAction")
public class TestListSubjectExecuteAction extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Teacher teacher = (Teacher) session.getAttribute("teacher");

        List<String> errorMsg = new ArrayList<>(); // エラーメッセージ格納用リスト

        // ログイン状態の確認
        if (teacher == null) {
            errorMsg.add("教員情報が取得できませんでした。ログインしてください。");
            request.setAttribute("errorMsg", errorMsg);
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }

        School school = teacher.getSchool();
        // 学校情報の確認
        if (school == null) {
            errorMsg.add("学校情報が取得できませんでした。");
            request.setAttribute("errorMsg", errorMsg);
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }

        // リクエストパラメータの取得
        String entYearStr = request.getParameter("ent_year");
        String classNum = request.getParameter("class_num");
        String subjectCd = request.getParameter("subject_cd");

        int entYear = 0;
        // 入学年度の文字列を数値に変換（変換できない場合は0のまま）
        if (entYearStr != null && !entYearStr.isEmpty()) {
            try {
                entYear = Integer.parseInt(entYearStr);
            } catch (NumberFormatException e) {
                // 数値変換失敗時のエラー処理
                errorMsg.add("入学年度の形式が不正です。");
            }
        }

        // 検索条件のバリデーション
        if (entYear == 0 || classNum == null || classNum.isEmpty() || subjectCd == null || subjectCd.isEmpty()) {
            // エラーメッセージを追加
            errorMsg.add("入学年度、クラス、科目をすべて選択してください。");
        }

        List<TestListSubject> testList = null;
        Subject subject = null;

        // エラーがない場合のみDBアクセス
        if (errorMsg.isEmpty()) {
            try {
                SubjectDao subjectDao = new SubjectDao();
                subject = subjectDao.get(subjectCd, school); // 選択された科目情報を取得

                // 科目が見つからない場合
                if (subject == null) {
                    errorMsg.add("指定された科目が見つかりませんでした。");
                } else {
                    TestListSubjectDao testListSubjectDao = new TestListSubjectDao();
                    testList = testListSubjectDao.filter(entYear, classNum, subject, school);
                }

            } catch (Exception e) {
                e.printStackTrace(); // 開発中はログ出力。本番では適切なロギングフレームワークを使用。
                errorMsg.add("成績データの取得に失敗しました。");
            }
        }

        // 検索条件をJSPに送り返してフォームの値を保持させる
        // 入学年度は文字列として保持
        request.setAttribute("ent_year_selected", entYearStr);
        request.setAttribute("class_num_selected", classNum);
        request.setAttribute("subject_cd_selected", subjectCd);

        // 検索結果をJSPに送る
        request.setAttribute("subject", subject); // 取得した科目情報をJSPに渡す
        request.setAttribute("testList", testList); // 成績リストをJSPに渡す

        // 科目検索の結果であることを示すフラグをセット
        // test_list.jsp でこのフラグを見て、test_list_subject_result.jsp をインクルードするか判断する
        request.setAttribute("testListSubjectResult", true);

        // エラーメッセージがあればセット
        if (!errorMsg.isEmpty()) {
            request.setAttribute("errorMsg", errorMsg);
        }

        // 初期表示画面（test_list.jsp）にフォワード
        request.getRequestDispatcher("/scoremanager/main/test_list.jsp").forward(request, response);
    }
}
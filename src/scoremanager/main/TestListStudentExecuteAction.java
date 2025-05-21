package scoremanager.main;

import java.io.IOException;
import java.util.ArrayList; // ArrayList をインポート
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession; // HttpSession をインポート

import bean.Student;
import bean.Teacher; // Teacher をインポート
import bean.TestListStudent;
import dao.StudentDao;
import dao.TestListStudentDao;

@WebServlet("/scoremanager/main/TestListStudentExecuteAction")
public class TestListStudentExecuteAction extends HttpServlet {
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

        // フォームから送信されたパラメータを取得
        String studentNo = request.getParameter("student_no");

        Student student = null;
        List<TestListStudent> studentTestList = null;

        try {
            // バリデーション: 学籍番号が入力されているか確認
            if (studentNo == null || studentNo.isEmpty()) {
                errorMsg.add("学籍番号を入力してください。");
            }

            if (errorMsg.isEmpty()) { // ここまでのバリデーションでエラーがなければDBアクセス
                // StudentDaoのインスタンス生成
                StudentDao studentDao = new StudentDao();

                // 学籍番号からStudentオブジェクトを取得（学校情報も内部で取得される）
                student = studentDao.get(studentNo);

                // 学生が存在しない場合のエラー処理
                if (student == null) {
                    errorMsg.add("指定された学籍番号の学生は存在しません。");
                } else {
                    // TestListStudentDaoのインスタンス生成
                    TestListStudentDao testListStudentDao = new TestListStudentDao();

                    // データベースから学生の成績リストを取得
                    // Studentオブジェクトには所属校情報も含まれているため、filterメソッドにそのまま渡せます
                    studentTestList = testListStudentDao.filter(student);
                }
            }

        } catch (Exception e) {
            // 予期せぬエラーが発生した場合
            e.printStackTrace(); // 開発中はログ出力。本番では適切なロギングフレームワークを使用。
            errorMsg.add("成績情報の取得に失敗しました。");
        }

        // 検索条件をJSPに送り返してフォームの値を保持させる
        request.setAttribute("student_no_selected", studentNo);

        // 検索結果をリクエスト属性に格納
        request.setAttribute("student", student); // 取得した学生情報をJSPに渡す
        request.setAttribute("testListStudent", studentTestList); // 成績リストをJSPに渡す

        // 学生検索の結果であることを示すフラグをセット
        // test_list.jsp でこのフラグを見て、test_list_student_result.jsp をインクルードするか判断する
        request.setAttribute("testListStudentResult", true);

        // エラーメッセージがあればセット
        if (!errorMsg.isEmpty()) {
            request.setAttribute("errorMsg", errorMsg);
        }

        // 初期表示画面（test_list.jsp）にフォワード
        request.getRequestDispatcher("/scoremanager/main/test_list.jsp").forward(request, response);
    }
}
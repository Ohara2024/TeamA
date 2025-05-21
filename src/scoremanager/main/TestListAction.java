package scoremanager.main;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Subject;
import dao.ClassNumDao;
import dao.SubjectDao;

/**
 * 成績照会画面の初期表示を行うサーブレット
 */
@WebServlet("/scoremanager/main/TestList.action")
public class TestListAction extends HttpServlet {
    public TestListAction() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //   セッションからTeacherインスタンスを取得
        HttpSession session = request.getSession();
        bean.Teacher teacher = (bean.Teacher) session.getAttribute("teacher");

        //   エラーメッセージ格納用リスト
        List<String> errorMsg = new ArrayList<>();

        // ★★★ teacher オブジェクトの null チェック ★★★
        if (teacher == null) {
            errorMsg.add("教員情報が取得できませんでした。ログインしてください。");
            request.setAttribute("errorMsg", errorMsg);
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return; // 処理を中断
        }

        // ★★★ teacher.getSchool() の null チェック ★★★
        if (teacher.getSchool() == null) {
            errorMsg.add("学校情報が取得できませんでした。");
            request.setAttribute("errorMsg", errorMsg);
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return; // 処理を中断
        }

        //   年リストを作成
        List<Integer> yearList = new ArrayList<>();
        int currentYear = Calendar.getInstance().get(Calendar.YEAR);
        for (int i = currentYear; i >= 2000; i--) {
            yearList.add(i);
        }
        request.setAttribute("yearList", yearList);

        try {
            //   クラス一覧を取得
            ClassNumDao classNumDao = new ClassNumDao();
            List<String> classNumList = classNumDao.filter(teacher.getSchool());
            request.setAttribute("classNumList", classNumList);
        } catch (Exception e) {
            e.printStackTrace();
            errorMsg.add("クラス一覧の取得に失敗しました。");
        }

        try {
            //   科目一覧を取得
            SubjectDao subjectDao = new SubjectDao();
            List<Subject> subjectList = subjectDao.filter(teacher.getSchool());
            request.setAttribute("subjectList", subjectList);
        } catch (Exception e) {
            e.printStackTrace();
            errorMsg.add("科目一覧の取得に失敗しました。");
        }

        if (!errorMsg.isEmpty()) {
            request.setAttribute("errorMsg", errorMsg);
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/scoremanager/main/test_list.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
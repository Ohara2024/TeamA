package scoremanager.main;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.School;
import bean.Student;
import bean.Teacher;
import dao.StudentDao;
import tool.Action;

public class StudentCreateExecuteAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // セッション取得（セッションがなければログイン画面へリダイレクト）
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("login.action");
            return;
        }

        // セッションから教員情報を取得（userにはTeacherが入っている）
        Teacher teacher = (Teacher) session.getAttribute("user");
        if (teacher == null) {
            response.sendRedirect("login.action");
            return;
        }

        // 教員から学校情報を取得
        School school = teacher.getSchool();
        if (school == null) {
            request.setAttribute("error", "学校情報が取得できませんでした。再度ログインしてください。");
            request.getRequestDispatcher("../login.jsp").forward(request, response);
            return;
        }

        // フォームからのパラメータを取得
        String no = request.getParameter("no");
        String name = request.getParameter("name");
        String entYearStr = request.getParameter("ent_year");
        String classNum = request.getParameter("class_num");

        int entYear = 0;
        try {
            entYear = Integer.parseInt(entYearStr);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "入学年度が正しく入力されていません。");
            request.getRequestDispatcher("student_create_error.jsp").forward(request, response);
            return;
        }

        // Studentオブジェクトを作成して情報をセット
        Student student = new Student();
        student.setNo(no);
        student.setName(name);
        student.setEntYear(entYear);
        student.setClassNum(classNum);
        student.setAttend(true); // デフォルト在籍状態
        student.setSchool(school); // 教員から取得した学校情報をセット

        StudentDao studentDao = new StudentDao();

        try {
            boolean result = studentDao.save(student);
            if (result) {
                request.getRequestDispatcher("/scoremanager/main/student_create_done.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "学生情報の登録に失敗しました。");
                request.getRequestDispatcher("/scoremanager/main/student_create_error.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "エラーが発生しました: " + e.getMessage());
            request.getRequestDispatcher("/scoremanager/main/error.jsp").forward(request, response);
        }
    }
}

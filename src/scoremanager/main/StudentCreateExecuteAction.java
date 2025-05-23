package scoremanager.main;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.School;
import bean.Student;
import dao.StudentDao;

@WebServlet("/studentcreateexecute")
public class StudentCreateExecuteAction extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // セッション取得（セッションがなければログイン画面へリダイレクト）
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // セッションから学校情報を取得
        School school = (School) session.getAttribute("loginSchool");
        if (school == null) {
            request.setAttribute("error", "学校情報が取得できませんでした。再度ログインしてください。");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // フォームからのパラメータを取得
        String no = request.getParameter("no");
        String name = request.getParameter("name");
        String entYearStr = request.getParameter("entYear");
        String classNum = request.getParameter("classNum");

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
        student.setSchool(school); // セッションから取得した学校情報をセット

        StudentDao studentDao = new StudentDao();

        try {
            boolean result = studentDao.save(student);
            if (result) {
                response.sendRedirect("student_create_done.jsp");
            } else {
                request.setAttribute("error", "学生情報の登録に失敗しました。");
                request.getRequestDispatcher("student_create_error.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "エラーが発生しました: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}

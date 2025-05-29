package scoremanager.main;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.School;
import bean.Student;
import bean.Subject;
import bean.Teacher;
import bean.TestListStudent;
import dao.ClassNumDao;
import dao.StudentDao;
import dao.SubjectDao;
import dao.TestListStudentDao;
import tool.Action;

public class TestListStudentExecuteAction extends Action {

    // ドロップダウンデータをセットする共通メソッド
    private void setDropdownData(HttpServletRequest request, School school) throws Exception {
        List<Integer> entYearSet = new ArrayList<>();
        int currentYear = LocalDate.now().getYear();
        for (int i = currentYear - 10; i <= currentYear; i++) {
            entYearSet.add(i);
        }
        request.setAttribute("ent_year_set", entYearSet);

        ClassNumDao classNumDao = new ClassNumDao();
        List<String> classNumSet = classNumDao.filter(school);
        request.setAttribute("class_num_set", classNumSet);

        SubjectDao subjectDao = new SubjectDao();
        List<Subject> subjects = subjectDao.filter(school);
        request.setAttribute("subjects", subjects);
    }

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession session = request.getSession();
        Teacher teacher = (Teacher) session.getAttribute("user");
        if (teacher == null) {
            response.sendRedirect("../Login.action"); // 相対パスでのリダイレクト
            return;
        }

        School school = teacher.getSchool();
        StudentDao studentDao = new StudentDao();
        TestListStudentDao testListStudentDao = new TestListStudentDao();

        try {
            String studentNo = request.getParameter("student_no"); // パラメータ名を student_no に統一

            if (studentNo == null || studentNo.trim().isEmpty()) {
                request.setAttribute("lackError", "学生番号を入力してください");
                setDropdownData(request, school);
                request.getRequestDispatcher("/scoremanager/main/test_list.jsp").forward(request, response);
                return;
            }

            Student student = studentDao.get(studentNo);

            if (student == null || !student.getSchool().getCd().equals(school.getCd())) {
                request.setAttribute("nothingError", "該当する学生情報が存在しませんでした");
                setDropdownData(request, school);
                request.getRequestDispatcher("/scoremanager/main/test_list.jsp").forward(request, response);
                return;
            }

            List<TestListStudent> list = testListStudentDao.filter(student);

            if (list.isEmpty()) {
                request.setAttribute("nothingError", "該当する成績情報が存在しませんでした");
            }

            request.setAttribute("resultList", list);
            request.setAttribute("f4", studentNo);
            request.setAttribute("target_student", student);

            setDropdownData(request, school);
            request.getRequestDispatcher("/scoremanager/main/test_list_student.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error_message", "処理中にエラーが発生しました。");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }

    }
}
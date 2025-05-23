package scoremanager.main;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.School;
import bean.Student;
import dao.SchoolDao;
import dao.StudentDao;
import tool.Action;

public class StudentListAction extends Action {
    public void execute(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        try {
            // 学校のコードを取得（例として"001"を仮定）
            String schoolCd = "001";
            SchoolDao schoolDao = new SchoolDao();
            School school = schoolDao.get(schoolCd);

            // 学生一覧を取得（在学している学生のみ）
            StudentDao studentDao = new StudentDao();
            List<Student> students = studentDao.filter(school, true);

            // JSPに渡す
            request.setAttribute("students", students);
            request.getRequestDispatcher("/student_list.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "システムエラーが発生しました。");
        }
    }
}

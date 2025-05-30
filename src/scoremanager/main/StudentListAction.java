package scoremanager.main;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.School;
import bean.Student;
import dao.SchoolDao;
import dao.StudentDao;
import tool.Action;

public class StudentListAction extends Action {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
        	String schoolCd = (String) request.getSession().getAttribute("schoolCd");
            SchoolDao schoolDao = new SchoolDao();
            School school = schoolDao.get(schoolCd);
            StudentDao studentDao = new StudentDao();

            // --- ドロップダウン選択肢をセット ---
            List<Integer> entYears = Arrays.asList(2021, 2022, 2023, 2024);
            List<String> classNums = Arrays.asList("101", "102", "201", "202");
            request.setAttribute("entYears", entYears);
            request.setAttribute("classNums", classNums);

            // --- 検索条件の取得 ---
            String entYearStr = request.getParameter("f1");
            String classNum = request.getParameter("f2");
            String isAttendStr = request.getParameter("f3");

            List<Student> students;

            if (entYearStr == null && classNum == null && isAttendStr == null) {
                // 初期表示：全員（在学中のみ）
                students = studentDao.filter(school, true);
            } else {
                // 検索後の表示
                int entYear = (entYearStr != null && !entYearStr.isEmpty()) ? Integer.parseInt(entYearStr) : 0;
                boolean isAttend = "true".equals(isAttendStr);

                if (entYear > 0 && classNum != null && !classNum.isEmpty()) {
                    students = studentDao.filter(school, entYear, classNum, isAttend);
                } else if (entYear > 0) {
                    students = studentDao.filter(school, entYear, isAttend);
                } else {
                    students = studentDao.filter(school, isAttend);
                }
            }

            request.setAttribute("students", students);
            request.getRequestDispatcher("/scoremanager/main/student_list.jsp").forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}

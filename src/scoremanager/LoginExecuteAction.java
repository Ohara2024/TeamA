package scoremanager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.School;
import bean.Teacher;
import dao.SchoolDao;
import dao.TeacherDao;
import tool.Action;  // ← Action インターフェースのインポート

public class LoginExecuteAction extends Action {

    public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            String id = request.getParameter("id");
            String password = request.getParameter("password");

            TeacherDao dao = new TeacherDao();
            Teacher teacher = dao.login(id, password);

            if (teacher != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", teacher);
                request.setAttribute("teachername", teacher.getName());

                // 学校コード取得
                String schoolCd = getSchoolCdByTeacherId(id);
                if (schoolCd != null) {
                    SchoolDao schoolDao = new SchoolDao();
                    School school = schoolDao.get(schoolCd);
                    session.setAttribute("loginSchool", school);
                }

                request.getRequestDispatcher("/menu.jsp").forward(request, response);
            } else {
            	 request.getRequestDispatcher("/error.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    private String getSchoolCdByTeacherId(String teacherId) throws Exception {
        String schoolCd = null;

        try (
            Connection conn = new dao.Dao().getConnection();
            PreparedStatement stmt = conn.prepareStatement("SELECT school_cd FROM teacher WHERE id = ?");
        ) {
            stmt.setString(1, teacherId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    schoolCd = rs.getString("school_cd");
                }
            }
        }

        return schoolCd;
    }
}

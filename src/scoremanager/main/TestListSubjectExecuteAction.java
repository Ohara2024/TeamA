package scoremanager.main;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.School;
import bean.Subject;
import bean.Teacher;
import bean.TestListSubject;
import dao.ClassNumDao;
import dao.SubjectDao;
import dao.TestListSubjectDao;
import tool.Action;

public class TestListSubjectExecuteAction extends Action {

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
        SubjectDao subjectDao = new SubjectDao();
        TestListSubjectDao testListSubjectDao = new TestListSubjectDao();

        try {
            String entYearStr = request.getParameter("ent_year"); // パラメータ名を ent_year に統一
            String classNum = request.getParameter("class_num"); // パラメータ名を class_num に統一
            String subjectCd = request.getParameter("subject_cd"); // パラメータ名を subject_cd に統一

            boolean hasCondition = entYearStr != null && !entYearStr.trim().isEmpty() &&
                                   classNum != null && !classNum.trim().isEmpty() &&
                                   subjectCd != null && !subjectCd.trim().isEmpty();

            if (!hasCondition) {
                request.setAttribute("lackError", "入学年度とクラスと科目を選択してください");
                setDropdownData(request, school);
                request.getRequestDispatcher("/scoremanager/main/test_list.jsp").forward(request, response);
                return;
            }

            int entYear;
            try {
                entYear = Integer.parseInt(entYearStr);
            } catch (NumberFormatException e) {
                request.setAttribute("lackError", "入学年度が不正です");
                setDropdownData(request, school);
                request.getRequestDispatcher("/scoremanager/main/test_list.jsp").forward(request, response);
                return;
            }

            Subject subject = subjectDao.get(subjectCd, school);

            if (subject == null) {
                request.setAttribute("lackError", "科目が選択されていません");
                setDropdownData(request, school);
                request.getRequestDispatcher("/scoremanager/main/test_list.jsp").forward(request, response);
                return;
            } else {
                List<TestListSubject> list = testListSubjectDao.filter(entYear, classNum, subject, school);

                request.setAttribute("resultList", list);
                request.setAttribute("subjectName", subject.getName());

                // 検索後にフォームに値を保持するためのsetAttribute（JSPのf1,f2,f3に対応させる）
                request.setAttribute("f1", entYearStr);
                request.setAttribute("f2", classNum);
                request.setAttribute("f3", subjectCd);

                setDropdownData(request, school);
                request.getRequestDispatcher("/scoremanager/main/test_list_subject.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error_message", "処理中にエラーが発生しました。");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
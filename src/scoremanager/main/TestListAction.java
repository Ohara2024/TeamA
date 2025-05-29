package scoremanager.main;

import java.time.LocalDate; // LocalDateのインポートを追加
import java.util.ArrayList; // ArrayListのインポートを追加
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.School;
import bean.Teacher;
import dao.ClassNumDao;
import dao.SubjectDao;
import tool.Action;

public class TestListAction extends Action {
    private void setDropdownData(HttpServletRequest request, School school) throws Exception {
        List<Integer> entYearSet = new ArrayList<>();
        int currentYear = LocalDate.now().getYear();
        for (int i = currentYear - 10; i <= currentYear; i++) { // 現在の年から過去10年、未来10年など、範囲を適切に設定
            entYearSet.add(i);
        }
        request.setAttribute("ent_year_set", entYearSet);

        ClassNumDao classNumDao = new ClassNumDao();
        List<String> classNumSet = classNumDao.filter(school);
        request.setAttribute("class_num_set", classNumSet); // 属性名を class_num_set に統一

        SubjectDao subjectDao = new SubjectDao();
        List<bean.Subject> subjects = subjectDao.filter(school); // bean.Subjectを明示
        request.setAttribute("subjects", subjects); // 属性名を subjects に統一
    }

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		HttpSession session = req.getSession();
		Teacher teacher = (Teacher) session.getAttribute("user");

		if (teacher == null) {
			res.sendRedirect("../Login.action");
			return;
		}

		School school = teacher.getSchool();

		// ドロップダウンデータをセットする共通メソッドを呼び出す
		setDropdownData(req, school);
		req.getRequestDispatcher("/scoremanager/main/test_list.jsp").forward(req, res);
	}
}
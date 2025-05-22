package test;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Subject;

@WebServlet("/test/SubjectListAction")
public class SubjectListAction extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String JDBC_URL = "jdbc:h2:tcp://localhost/~/exam;LOCK_TIMEOUT=10000";
    private static final String DB_USER = "sa";
    private static final String DB_PASSWORD = "";
    private static final Logger LOGGER = Logger.getLogger(SubjectListAction.class.getName());

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        execute(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        execute(request, response);
    }

    private void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Subject> subjectList = new ArrayList<>();
        String errorMessage = null;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            LOGGER.info("H2ドライバをロード中...");
            Class.forName("org.h2.Driver");
            conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
            if (conn.isValid(2)) {
                LOGGER.info("データベース接続に成功しました。");
            } else {
                throw new SQLException("データベース接続が無効です。");
            }

            String sql = "SELECT SCHOOL_CD, CD, NAME FROM.SUBJECT ORDER BY CD";
            LOGGER.info("クエリを実行中: " + sql);
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Subject subject = new Subject();
                subject.setSchoolCd(rs.getString("SCHOOL_CD"));
                subject.setCd(rs.getString("CD"));
                subject.setName(rs.getString("NAME"));
                subjectList.add(subject);
            }
            LOGGER.info(subjectList.size() + "件の科目データを取得しました。");
            if (subjectList.isEmpty()) {
                errorMessage = "データベースに科目データが存在しません。SUBJECTテーブルを確認してください。";
            }
        } catch (ClassNotFoundException e) {
            LOGGER.severe("H2ドライバが見つかりません: " + e.getMessage());
            errorMessage = "H2ドライバが見つかりません: " + e.getMessage() + "。H2ライブラリがプロジェクトに含まれているか確認してください。";
        } catch (SQLException e) {
            LOGGER.severe("データベースエラー: " + e.getMessage());
            errorMessage = "データベースエラー: " + e.getMessage() + "。データベース接続設定を確認してください。";
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
        }

        request.setAttribute("errorMessage", errorMessage);
        request.setAttribute("subjectList", subjectList);
        LOGGER.info("subject_list.jsp にフォワード中。科目リストのサイズ: " + subjectList.size());
        request.getRequestDispatcher("/subject_list.jsp").forward(request, response);
    }
}
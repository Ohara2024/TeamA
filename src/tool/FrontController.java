package tool;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.action")  // *.action のURLにマッピングされる
public class FrontController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        executeAction(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        executeAction(request, response);
    }

    private void executeAction(HttpServletRequest request, HttpServletResponse response)
            throws ServletException {
        try {
            // 例: /scoremanager/main/LoginExecute.action など
            String path = request.getServletPath().substring(1);  // 先頭の '/' を除く
            String className;

            // pathに main が含まれているケースを処理（適宜修正してください）
            if (path.startsWith("scoremanager/main/")) {
                // scoremanager/main/LoginExecute.action → scoremanager.LoginExecuteAction に変換
                String subPath = path.substring("scoremanager/main/".length());  // LoginExecute.action
                subPath = subPath.replace(".action", "");                       // LoginExecute
                className = "scoremanager.main." + subPath;               // scoremanager.LoginExecuteAction
            } else {
                // それ以外は通常通り変換
                String classPath = path.replace(".action", "").replace("/", ".");
                className = classPath;
            }

            // Actionクラスを動的にロード＆インスタンス化
            Class<?> actionClass = Class.forName(className);
            Action action = (Action) actionClass.getDeclaredConstructor().newInstance();

            // Actionのexecuteメソッド実行、戻り先URLを受け取る
            String url = action.execute(request, response);

            // JSPなどにフォワード
            RequestDispatcher dispatcher = request.getRequestDispatcher(url);
            dispatcher.forward(request, response);

        } catch (Exception e) {
            throw new ServletException("アクションの実行中にエラーが発生しました: " + e.getMessage(), e);
        }
    }
}

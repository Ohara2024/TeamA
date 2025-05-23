package tool;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = {"*.action"})
public class FrontController extends HttpServlet {

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {
        	String path = request.getServletPath().substring(1);  // 例: scoremanager/login.action
        	int dotIndex = path.lastIndexOf('.');
        	String base = (dotIndex > 0) ? path.substring(0, dotIndex) : path;  // scoremanager/login
        	String name = base.replace('/', '.');  // scoremanager.loginAction


            // 動的にアクションクラスをロードしてインスタンス生成
            Action action = (Action) Class.forName(name).getDeclaredConstructor().newInstance();

            // executeメソッドを呼び出して、フォワード先のURLを取得
            String url = action.execute(request, response);

            // JSPなどにフォワード
            request.getRequestDispatcher(url).forward(request, response);

        } catch (Exception e) {
            e.printStackTrace(out);
        }
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response); // GETリクエストもPOSTと同様に処理
    }
}

package cn.carman.web.servlet;

import cn.carman.domain.User;
import cn.carman.service.UserService;
import cn.carman.service.impl.UserServiceImpl;
import org.apache.commons.beanutils.BeanUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.Map;

@WebServlet("/loginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        HttpSession session = request.getSession();
        String verifycode=request.getParameter("verifycode");
        String checkCodeServer=(String)session.getAttribute("CHECKCODE_SERVER");
        session.removeAttribute("CHECKCODE_SERVER");
        if(checkCodeServer==null || !checkCodeServer.equalsIgnoreCase(verifycode)){
            request.setAttribute("login_msg", "验证码错误！");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }
        Map<String,String[]> map=request.getParameterMap();
        User user=new User();
        try {
            BeanUtils.populate(user,map);
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        }
        UserService service=new UserServiceImpl();
        User loginUser=service.login(user);
        if(loginUser!=null){
            session.setAttribute("loginUser",loginUser);
            response.sendRedirect(request.getContextPath()+"/index.jsp");
        }else{
            request.setAttribute("login_msg", "用户名或密码错误！");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }
}

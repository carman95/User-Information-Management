package cn.carman.web.servlet;

import cn.carman.domain.PageBean;
import cn.carman.domain.User;
import cn.carman.service.UserService;
import cn.carman.service.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

@WebServlet("/findUserByPageServlet")
public class FindUserByPageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        if(request.getSession().getAttribute("loginUser")==null){
            request.getRequestDispatcher("/login.jsp").forward(request,response);
            return;
        }
        String currentPage = request.getParameter("currentPage");//当前页码
        String rows = request.getParameter("rows");//每页显示条数
        if(currentPage == null || "".equals(currentPage)){
            currentPage = "1";
        }
        if(rows == null || "".equals(rows)){
            rows = "5";
        }
        Map<String, String[]> condition = request.getParameterMap();
        UserService service = new UserServiceImpl();
        PageBean<User> pb = service.findUserByPage(currentPage,rows,condition);
//        System.out.println(pb);
        request.setAttribute("pb",pb);
        request.setAttribute("condition",condition);//将查询条件存入request
        request.getRequestDispatcher("/list.jsp").forward(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }
}

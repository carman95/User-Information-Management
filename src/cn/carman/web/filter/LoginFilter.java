package cn.carman.web.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

@WebFilter("/*")
public class LoginFilter implements Filter {
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest request=(HttpServletRequest)req;
        String uri=request.getRequestURI();
        if(uri.contains("/login.jsp")||uri.contains("/loginServlet")||uri.contains("/checkCodeServlet")||
        uri.contains("/css/")||uri.contains("/fonts/")||uri.contains("/js/")){
            chain.doFilter(req, resp);
        }else{
            Object user=request.getSession().getAttribute("loginUser");
            if(user!=null){
                chain.doFilter(req, resp);
            }else{
                request.setAttribute("login_msg", "您尚未登陆，请登录");
                request.getRequestDispatcher("/login.jsp").forward(request,resp);
            }
        }
    }

    public void destroy() {
    }

    public void init(FilterConfig config) throws ServletException {

    }

}

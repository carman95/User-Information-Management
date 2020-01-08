package cn.carman.web.servlet;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

@WebServlet("/checkCodeServlet")
public class CheckCodeServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        response.setHeader("pragma","no-cache");
        response.setHeader("cache-control","no-cache");
        response.setHeader("expires","0");
        int width = 80;
        int height = 30;
        BufferedImage image = new BufferedImage(width,height,BufferedImage.TYPE_INT_RGB);
        Graphics g = image.getGraphics();
        g.setColor(Color.GRAY);
        g.fillRect(0,0, width,height);
        String checkCode = getCheckCode();
        request.getSession().setAttribute("CHECKCODE_SERVER",checkCode);
        g.setColor(Color.YELLOW);
        g.setFont(new Font("黑体",Font.BOLD,24));
        g.drawString(checkCode,15,25);
        ImageIO.write(image,"PNG",response.getOutputStream());
    }
    private String getCheckCode() {
        String base = "0123456789ABCDEFGabcdefg";
        int size = base.length();
        Random r = new Random();
        StringBuffer sb = new StringBuffer();
        for(int i=1;i<=4;i++){
            int index = r.nextInt(size);
            char c = base.charAt(index);
            sb.append(c);
        }
        return sb.toString();
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }
}

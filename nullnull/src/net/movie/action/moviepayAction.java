package net.movie.action;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class moviepayAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	      
	      	String img = request.getParameter("img");
	      	String name = request.getParameter("name");
	      	String place = request.getParameter("place");
	      	String date = request.getParameter("date");
	      	String time = request.getParameter("time");
	      	String count = request.getParameter("count");
	      	String seat = request.getParameter("seat");
	         request.setAttribute("img", img); 
	         request.setAttribute("name", name);
	         request.setAttribute("place", place);
	         request.setAttribute("date", date);
	         request.setAttribute("time", time);
	         request.setAttribute("count", count);
	         request.setAttribute("seat", seat);
	         
	         ActionForward forward = new ActionForward();
	         forward.setRedirect(false);
	         forward.setPath("Movie/MoviePay.jsp"); //¹Ù²ã¾ßÇÔ
	         return forward;
	      }// if end

	}

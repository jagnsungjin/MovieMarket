package net.movie.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import net.board_bk.db.Bbs_bk_bean;

public class gotobk_listAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	      List<Bbs_bk_bean> boardlist = new ArrayList<Bbs_bk_bean>();
	      
	      	String img = request.getParameter("img");
	      	String name = request.getParameter("name");
	      	String place = request.getParameter("place");
	      	String date = request.getParameter("date");
	      	String time = request.getParameter("time");
	      	String count = request.getParameter("count");
	      	String seat = request.getParameter("seat");
	      	
	         request.setAttribute("img", img); //���� ������ �� 
	         request.setAttribute("name", name);//�ִ� ������ ��
	         request.setAttribute("place", place);
	         request.setAttribute("date", date);
	         request.setAttribute("time", time);//�� ���� ��
	         request.setAttribute("boardlist", boardlist);
	         request.setAttribute("count", count);
	         request.setAttribute("seat", seat);
	         
	         ActionForward forward = new ActionForward();
	         forward.setRedirect(false);
	         forward.setPath("Bbs_bk/bk_write.jsp"); //�ٲ����
	         return forward;
	      }// if end

	}

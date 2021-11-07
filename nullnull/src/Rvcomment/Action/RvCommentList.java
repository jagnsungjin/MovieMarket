package Rvcomment.Action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import Rv.Action.Action;
import Rv.Action.ActionForward;
import Rvcomment.db.CommentDAO;



public class RvCommentList implements Action{
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		CommentDAO dao = new CommentDAO();
		
		int RCM_COMMENT_BOARD_NUM = 
					Integer.parseInt(request.getParameter("RCM_COMMENT_BOARD_NUM"));
		System.out.println(RCM_COMMENT_BOARD_NUM);
		int state = Integer.parseInt(request.getParameter("state"));
		int listcount = dao.getListCount(RCM_COMMENT_BOARD_NUM);
		
		JsonObject object = new JsonObject();
		JsonArray jarray = dao.getCommentList(RCM_COMMENT_BOARD_NUM,state);
		object.addProperty("listcount", listcount);
		JsonElement je = new Gson().toJsonTree(jarray);
		object.add("boardlist", je);
		
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(object.toString());
		System.out.println(object.toString());
		return null;
	}
}

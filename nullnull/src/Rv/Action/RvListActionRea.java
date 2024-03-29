package Rv.Action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import Rv.db.RvBean;

public class RvListActionRea implements Action{
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		RvDAO boarddao = new RvDAO();
		List<RvBean> boardlist = new ArrayList<RvBean>();
		
		//로그인 성공시 파라미터 page가 없어요. 그래서 초기값이 필요합니다.
		int page = 1; 	//보여줄 page
		int limit = 10;	//한 페이지에 보여줄 게시판 목록의 수
		String searchType ="";	//SEARCH 08-14 
		String search="";

		if(request.getParameter("page")!=null) {
			page=Integer.parseInt(request.getParameter("page"));
		}
		System.out.println("넘어온 페이지 = " + page);
		
		//추가 
		if(request.getParameter("limit")!= null) {
			limit = Integer.parseInt(request.getParameter("limit"));
		}
		System.out.println("넘어온 limit = " + limit);
		//추가
		if(request.getParameter("searchType") != null) {
			searchType = request.getParameter("searchType");
		}
		System.out.println("넘어온 searchType = " + searchType);
		//추가
		if(request.getParameter("search") != null) {
			search = request.getParameter("search");
		}
		System.out.println("넘어온 search = " + search);

		

		
				
		int listcount;
		// 리스트를 받아옵니다.
		if (searchType == "" && search == "") {
			boardlist = boarddao.getBoardReaList(page, limit);
			listcount = boarddao.getListCount();
		} else {
			boardlist = boarddao.BoardSearchReaList(page, limit,searchType, search);
			listcount = boarddao.SearchListCount(searchType, search);
		}

		
		/*
		 * 총페이지수
= (DB에 저장된 총 리스트의 수 + 한페이지에서 보여주는 리스트의수 -1) / 한페이지에서 보여주는 리스트의 수
		 * 예를 들어 한 페이지에서 보여주는 리스트의 수가 10개인 경우 
		 * 예1) DB에 저장된 총 리스트의 수가 0이면 총 페이지수는 0페이지
		 * 예2) DB에 저장된 총 리스트의 수가 ( 1~10)이면 총 페이지수는 1페이지
		 * 예3) DB에 저장된 총 리스트의 수가 (11~20)이면 총 페이지수는 2페이지
		 * 예4) DB에 저장된 총 리스트의 수가 (21~30)이면 총 페이지수는 3페이지
		 *
		 */
		int maxpage = (listcount + limit -1 )/limit;
		System.out.println("총 페이지수=" + maxpage);
		/*
		 * startpage : 현재 페이지 그룹에서 맨 처음에 표시될 페이지 수를 의미합니다.
		 * ([1] , [11] , [21] 등 ...) 보여줄 페이지가 30 개일 경우 
		   [1][2][3]....[30] 까지 다 표시하기에는 너무 많기 떄문에 보통 한 페이지에는
		   10페이지 정도까지 이동할 수 있게 표시합니다.
		 *  예) 페이지 그룹이 아래와 같은경우
		       [1][2][3][4][5][6][7][8][9][10]
		 * 페이지그룹의 시작 페이지는 startpage에 마지막  페이지는 endpage에 구합니다.
		 * 
		 * 예로 1~10 페이지의 내용을 나타낼때는 페이지 그룹은 [1][2][3]...[10]로 표시되고
		 * 11~20 페이지의 내용을 나타낼때는 페이지 그룹은 [11][12][13]...[20] 까지 표시됩니다.
		 */
		
		int startpage= ((page-1) / 10 ) *10 +1;
		System.out.println("현재 페이지에 보여줄 시작 페이지 수 = " + startpage);
		
		//endpage: 현재 페이지 그룹에서 보여줄 마지막 페이지 수 ([10], [20], [30] 등...)
		int endpage = startpage +10 -1;
		System.out.println("현재 페이지에 보여줄 마지막 페이지 수 = " + endpage);
		
		/*
		 * 마지막 그룹의 마지막 페이지 값은 최대 페이지 값입니다.
		 * 예로 마지막 페이지 그룹이 [21]~[30]인 경우
		 * 시작페이지(startpage=21)와 마지막 페이지 (endpage=30) 이지만
		 * 최대 페이지(maxpage)가 25라면 [21]~[25] 까지만 표시되도록 합니다.
		 */
		if (endpage > maxpage)
			endpage = maxpage;
		//추가
		String state =request.getParameter("state");
		//추가
		if(state ==null) {
			
			System.out.println("state==null");
			request.setAttribute("page", page); //현재 페이지 수 
			request.setAttribute("maxpage", maxpage);//최대 페이지 수
			
			//현재 페이지에 표시할 첫 페이지 수
			request.setAttribute("startpage", startpage);
			
			//현재 페이지에 표시할 끝 페이지 수 
			request.setAttribute("endpage", endpage);
			
			request.setAttribute("listcount", listcount);//총 글의 수
			
			//해당 페이지의 글 목록을 갖고 있는 리스트
			request.setAttribute("boardlist", boardlist);
			request.setAttribute("limit", limit);
			ActionForward forward = new ActionForward();
			forward.setRedirect(false);
			
			// 글 목록 페이지로 이동하기 위해 경로를 설정합니다.
			forward.setPath("bbs_rv/RvListRea.jsp");
			return forward;
		}else {
			System.out.println("state==ajax");
			
			//위에서 request로 담았던 것을 JsonObject에 담습니다.
			JsonObject object = new JsonObject();
			object.addProperty("page",page);//{"page":변수 page의 값} 형식으로 저장
			object.addProperty("maxpage",maxpage);
			object.addProperty("startpage",startpage);
			object.addProperty("endpage",endpage);
			object.addProperty("listcount",listcount);
			object.addProperty("limit",limit);
			
			//JsonObject에 List 형식을 담을 수 있는 addProperty() 존재하지 않습니다.
			//void com.goole.gson.JsonObject.add(String property, JsonElement value)
			//메서드를 통해서 저장합니다. 
			//List형식을 JsonElement로 바꾸어 주어야 object에 저장할 수 있습니다.
			// List => JsonElement
			JsonElement je = new Gson().toJsonTree(boardlist);
			System.out.println("boardlist=" + je.toString());
			object.add("boardlist", je);
			
			response.setContentType("text/html;charset=utf-8");
			response.getWriter().append(object.toString());
			System.out.println(object.toString());
			return null;
		}// if end
			
	}//execute end
}

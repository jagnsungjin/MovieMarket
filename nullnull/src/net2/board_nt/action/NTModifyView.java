package net2.board_nt.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net2.board_nt.db.NTBean;
import net2.board_nt.db.NTDAO;



public class NTModifyView implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ActionForward forward = new ActionForward();
		NTDAO boarddao = new NTDAO();
		NTBean boarddata = new NTBean();
		
		//파라미터로 전달받은 수정할 글 번호를 num 변수에 저장
		int num = Integer.parseInt(request.getParameter("num"));
		
		//글 번호 num에 해당하는 내용을 가져와서 boarddata 객체에 저장합니다.
		boarddata=boarddao.getDetail(num);
		
		//글 내용이 없는 경우
		if(boarddata==null) {
			System.out.println("수정 상세보기 실패");
			forward.setRedirect(false);
			request.setAttribute("message","게시판 수정 실패");
			forward.setPath("error/error.jsp");
			return forward;
		}
		System.out.println("수정 상세보기 성공");
		//수정 폼 페이지로 이동할 때 원문 글 내용을 보여주기 때문에 boarddata 객체를
		//request 객체에 저장합니다.
		request.setAttribute("boarddata",boarddata);
		forward.setRedirect(false);
		//글 수정 폼 페이지로 이동하기 위해 경로를 설정합니다.
		forward.setPath("Bbs_nt/NTModify.jsp");
		return forward;
	}

}

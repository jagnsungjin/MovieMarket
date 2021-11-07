package main.board;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Rv.Action.RvDAO;
import Rv.db.RvBean;
import net.board_bk.db.Bbs_bkDAO;
import net.board_bk.db.Bbs_bk_bean;
import net2.board_nt.db.NTBean;
import net2.board_nt.db.NTDAO;

public class mainboardAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		NTDAO bbs_ntdao = new NTDAO();
		List<NTBean> nt_list = new ArrayList<NTBean>();
		
		Bbs_bkDAO bbs_bkdao = new Bbs_bkDAO();
		List<Bbs_bk_bean> bk_list = new ArrayList<Bbs_bk_bean>();
		
		RvDAO rv_dao = new RvDAO();
		List<RvBean> rv_list = new ArrayList<RvBean>();
		
		
		nt_list =  bbs_ntdao.getBoardList(1,7,"1");
		bk_list = bbs_bkdao.bbs_bkBoardList(1, 7);
		rv_list =  rv_dao.getBoardList(1,7);
		
		request.setAttribute("nt_list", nt_list);
		request.setAttribute("bk_list", bk_list);
		request.setAttribute("rv_list", rv_list);
		
		ActionForward forward =new ActionForward();
		forward.setRedirect(false);
		
		forward.setPath("main.jsp");
		return forward;
	}

}

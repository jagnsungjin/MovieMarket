package Rv.Action;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import Rv.db.RvBean;


public class RvAddAction implements Action {

	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		RvDAO boarddao = new RvDAO();
		RvBean boarddata = new RvBean();
		ActionForward forward = new ActionForward();
		
		String realFolder="";
		
		//WebContent 아래에 꼭 폴더 생성하세요
		String saveFolder="Bbs_rvupload";
		
		int fileSize=50*1024*1024;	//업로드할 파일의 최대 사이즈 입니다.5MB
		
		//실제 저장 경로를 지정합니다.
		ServletContext sc = request.getServletContext();
		realFolder = sc.getRealPath(saveFolder);
		System.out.println("realFolder=" + realFolder);
		boolean result =false;
		try {
			MultipartRequest multi
			= new MultipartRequest(request,
						realFolder,
						fileSize,
						"utf-8",
						new DefaultFileRenamePolicy());
			//BoardBean 객체에 글 등록 폼에서 입력 받은 정보드을 저장합니다.
			boarddata.setUSER_ID(multi.getParameter("USER_ID"));
			boarddata.setRV_PASS(multi.getParameter("RV_PASS"));
//			String csfcs[] = multi.getParameterValues("RV_CSFC");
//			String csfc ="" ;
//			for(int i = 0 ; i < csfcs.length ; i++) {
//				csfc += csfcs[i];
//			}
//			boarddata.setRV_CSFC(csfc);

			System.out.println("SUNGJIN " + multi.getParameter("RV_CSFC"));
			boarddata.setRV_GRADE(multi.getParameter("RV_GRADE"));
			System.out.println(multi.getParameter("RV_GRADE"));
			boarddata.setRV_CSFC(multi.getParameter("RV_CSFC"));
			boarddata.setRV_SUBJECT(multi.getParameter("RV_SUBJECT"));
			boarddata.setRV_CONTENT(multi.getParameter("RV_CONTENT"));
			
			//시스템 상에 업로드된 실제 파일명을 얻어 옵니다.
			String filename = multi.getFilesystemName("RV_FILE");
			boarddata.setRV_FILE(filename);
			
			//글 등록 처리를 위해 DAO의 boardInsert()메서드를 호출합니다.
			//글 등록 폼에서 입력한 정보가 저장되어 있는 boarddata객체를 전달합니다.
			result=boarddao.boardInsert(boarddata);
			
			//글 등록에 실패할 경우 false를 반환합니다.
			if(result == false) {
				System.out.println("게시판 등록 실패 ");
				forward.setPath("error/error.jsp");
				request.setAttribute("message", "게시판 등록 실패입니다.");
				forward.setRedirect(false);
				return forward;
			}

			
			//글 등록이 완료되면 글 목록을 보여주기 위해 "BoardList.bo"로 이동합니다.
			//Redirect여부를 true로 설정합니다.
			forward.setRedirect(true);
			forward.setPath("RvList.rv");//이동할 경로를 지정합니다.
			return forward;
			
		}catch(IOException ex) {
			ex.printStackTrace();
			System.out.println("ioexcption");
			forward.setPath("error/error.jsp");
			request.setAttribute("message", "게시판 업로드 실패입니다.");
			forward.setRedirect(false);
			return forward;
		}//catch end
	}//execute end

}

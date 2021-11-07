package net2.board_nt.action;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import net2.board_nt.db.NTBean;
import net2.board_nt.db.NTDAO;



public class NTAddAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			
			NTDAO boarddao = new NTDAO();
			NTBean boarddata = new NTBean();
			ActionForward forward = new ActionForward();
			
			String realFolder="";
			
			//WebContent�Ʒ��� �� ���� �����ϼ���
			String saveFolder="/Bbs_ntupload";
			
			int fileSize=5*1024*1024; //���ε� �� ������ �ִ� �������Դϴ�. 5MB
			
			//���� ���� ��θ� �����մϴ�.
			ServletContext sc = request.getSession().getServletContext();
			realFolder = sc.getRealPath(saveFolder);
			System.out.println("realFolder= " + realFolder);
			boolean result=false;
			try {
				MultipartRequest multi
				= new MultipartRequest(request,
										realFolder,
										fileSize,
										"utf-8",
										new DefaultFileRenamePolicy());
				
				//BoardBean ��ü�� �� ��� ������ �Է� ���� �������� �����մϴ�.
				boarddata.setNt_pass(multi.getParameter("nt_pass"));
				boarddata.setNt_subject(multi.getParameter("nt_subject"));
				boarddata.setNt_content(multi.getParameter("nt_content"));
				boarddata.setUser_id(multi.getParameter("user_id"));
				boarddata.setNt_read(0);
				//��ܰ���
				boarddata.setNt_fix(Integer.parseInt(multi.getParameter("nt_fix")));
				System.out.println("�����̸� 1 �ƴϸ� 0="+ multi.getParameter("nt_fix"));
				//�ý��� �� ���ε�� ���� ���ϸ��� ���ɴϴ�.
				String filename=multi.getFilesystemName("nt_file");
				boarddata.setNt_file(filename);
				
				//�� ��� ó���� ���� DAO�� boardInsert()�޼��带 ȣ���մϴ�.
				//�� ��� ������ �Է��� ������ ����Ǿ� �ִ� boarddata��ü�� �����մϴ�.
				result=boarddao.boardInsert(boarddata);
				
				//�� ��Ͽ� �÷����� ��� false�� ��ȯ�մϴ�.
				if(result==false) {
					System.out.println("�Խ��� ��� ����");
					forward.setPath("error/error.jsp");
					request.setAttribute("message","�Խ��� ��� �����Դϴ�.");
					forward.setRedirect(false);
					return forward;
				}
				System.out.println("�Խ��� ��� �Ϸ�");
				
				//�� ����� �Ϸ�Ǹ� �� ����� �����ֱ� ���� "BoardList.bo"�� �̵��մϴ�.
				//Redirect���θ� true�� �����մϴ�.
				forward.setRedirect(true);
				forward.setPath("NTList.bo");//�̵��� ��θ� �����մϴ�.
				return forward;
			}catch(IOException ex) {
				forward.setPath("error/error.jsp");
				request.setAttribute("message", "�Խ��� ��� �����Դϴ�.");
				forward.setRedirect(false);
				return forward;
			}//catch end
	}

}

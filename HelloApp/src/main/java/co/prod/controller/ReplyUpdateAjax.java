package co.prod.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import co.prod.common.Control;
import co.prod.service.ProductService;
import co.prod.service.ProductServiceImpl;
import co.prod.vo.ReplyVO;

public class ReplyUpdateAjax implements Control {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		ReplyVO vo = new ReplyVO();
		vo.setReplyNo(Integer.parseInt(request.getParameter("replyNo")));
		vo.setReplyWriter(request.getParameter("replyWriter"));
		vo.setReplyContent(request.getParameter("replyContent"));
		
		ProductService service = new ProductServiceImpl();
		ReplyVO re = new ReplyVO();
		Map<String,Object> result = new HashMap<>();
		if(service.modifyReply(vo)) {
			re = service.getReply(Integer.parseInt(request.getParameter("replyNo")));
			result.put("retCode", "Success");
			result.put("reply", re);
		}else {
			result.put("retCode", "Fail");
			result.put("reply", null);
		}
		Gson gson = new GsonBuilder().create();
		String json = gson.toJson(result);
		return json+".ajax";
	}

}

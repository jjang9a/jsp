package co.prod.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import co.prod.common.Control;
import co.prod.service.ProductService;
import co.prod.service.ProductServiceImpl;
import co.prod.vo.ReplyVO;

public class ReplySearchAjax implements Control {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		String rid = request.getParameter("replyNo");
		ProductService service = new ProductServiceImpl();
		ReplyVO vo = service.getReply(Integer.parseInt(rid)); // selectReply(rid)
		
		// Gson 라이브러리 - 편하게 자바 객체를 문자열로 변경해줌
		Gson gson = new GsonBuilder().create();
		String json = gson.toJson(vo);
		
		return json + ".ajax";
	}

}

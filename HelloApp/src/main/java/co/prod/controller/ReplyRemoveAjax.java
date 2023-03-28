package co.prod.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import co.prod.common.Control;
import co.prod.service.ProductService;
import co.prod.service.ProductServiceImpl;
import co.prod.vo.ReplyVO;

public class ReplyRemoveAjax implements Control {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		int no = Integer.parseInt(request.getParameter("replyId"));
		ProductService service = new ProductServiceImpl();
		boolean result = service.replyRemove(no);
		String json = "";
		if(result) {
			// {"retCode" : "Success"}
			json = "{\"retCode\" : \"Success\"}";
		}else {
			// {"retCode" : "Fail"}
			json = "{\"retCode\" : \"Fail\"}";
		}
		return json+".ajax";
	}
}

package co.prod.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import co.prod.common.Control;
import co.prod.service.ProductService;
import co.prod.service.ProductServiceImpl;
import co.prod.vo.EventVO;

public class CalendatDeleteAjax implements Control {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		EventVO vo = new EventVO();
		vo.setTitle(request.getParameter("title"));
		vo.setStart(request.getParameter("start"));
		vo.setEnd(request.getParameter("end"));
				
		ProductService service = new ProductServiceImpl();
		String json = "";
		if(service.removeEvent(vo)){
			json = "{\"retCode\" : \"Success\"}";
		}else {
			json = "{\"retCode\" : \"Fail\"}";
		}
		return json + ".ajax";
	}

}

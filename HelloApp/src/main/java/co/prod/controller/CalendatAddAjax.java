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
import co.prod.vo.EventVO;

public class CalendatAddAjax implements Control {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		EventVO vo = new EventVO();
		
		vo.setTitle(request.getParameter("title"));
		vo.setStart(request.getParameter("start"));
		vo.setEnd(request.getParameter("end"));
		
		ProductService service = new ProductServiceImpl();
		Gson gson = new GsonBuilder().create();
		
		String json = "";
		Map<String, Object> map = new HashMap<>();
		
		if(service.addEvent(vo)) {
			map.put("retCode", "Success");
			map.put("event", vo);
		}else {
			map.put("retCode", "Fail");
			map.put("event", null);
		}
		
		json = gson.toJson(map);
		return json + ".ajax";
	}

}

package co.prod.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import co.prod.common.Control;
import co.prod.service.ProductService;
import co.prod.service.ProductServiceImpl;
import co.prod.vo.EventVO;

public class CalendarListAjax implements Control {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		ProductService service = new ProductServiceImpl();
		List<EventVO> list = service.eventList();
		
		Gson gson = new GsonBuilder().create();
//		{title : '여행', start: '2023-03-09', end: '2023-03-13'}	
//		String json = "[";
//		for(EventVO vo : list) {
//			json += "{title : '"+vo.getTitle()+", start : '"+vo.getStartDate()+"'";
//			if(vo.getEndDate() != null) {
//				json += ", end : '"+vo.getEndDate()+"'},";
//			}else {
//				json += "},";
//			}
//		}
//		json = json.substring(0, json.length()-1);
//		json += "]";
		String json = gson.toJson(list);
				
		return json + ".ajax";
	}

}

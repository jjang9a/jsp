package co.prod.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.prod.common.Control;
import co.prod.service.ProductService;
import co.prod.service.ProductServiceImpl;

public class ChartAjax implements Control {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		ProductService service = new ProductServiceImpl();
		List<Map<String,Object>> list = service.chartInfo();
		
		String json = "[";
		for(Map<String, Object> map : list) {
			System.out.println(map.get("DEPARTMENT_NAME")+ "," + map.get("cnt"));
						// ㄴ 대문자로 적어야 하는데 소문자로 적고싶다면 mapper.xml select문 안에서 별칭 지정해주면 됨
			// {"Administration":1}
			json += "{\""+map.get("DEPARTMENT_NAME")+"\":"+map.get("cnt")+"},";
		}
		json = json.substring(0, json.length()-1);
		json += "]";
		
		return json + ".ajax";
	}

}

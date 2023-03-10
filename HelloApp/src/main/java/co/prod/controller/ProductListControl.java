package co.prod.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.prod.common.Control;
import co.prod.service.ProductService;
import co.prod.service.ProductServiceImpl;
import co.prod.vo.ProductVO;

public class ProductListControl implements Control {

	@Override
	public String exec(HttpServletRequest req, HttpServletResponse resp) {
		// db결과 -> attribute("list")에 담아서 보냄
		List<ProductVO> list = new ArrayList<>();
		ProductService service = new ProductServiceImpl();
		list = service.products();
		
		req.setAttribute("list", list);
		
		return "product/productList.tiles";
	}

}

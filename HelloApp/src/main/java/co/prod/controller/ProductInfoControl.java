package co.prod.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.prod.common.Control;
import co.prod.service.ProductService;
import co.prod.service.ProductServiceImpl;
import co.prod.vo.ProductVO;

public class ProductInfoControl implements Control {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		ProductService service = new ProductServiceImpl();
		
		String code = request.getParameter("code");
		ProductVO prod = service.getProduct(code);
		List<ProductVO> reco = service.recomend();
		
		request.setAttribute("info", prod);
		request.setAttribute("reco", reco);
		
		return "product/product.tiles";
	}

}

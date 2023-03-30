package co.prod.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.prod.common.Control;
import co.prod.service.ProductService;
import co.prod.service.ProductServiceImpl;
import co.prod.vo.EventVO;

public class CarlendarControl implements Control {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		return "product/selectable.jsp";
	}

}

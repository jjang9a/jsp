package co.prod.service;

import java.util.List;

import co.prod.vo.ProductVO;

public interface ProductService {
	public List<ProductVO> products();
	public ProductVO prod(String code);
	public List<ProductVO> recomend();
}

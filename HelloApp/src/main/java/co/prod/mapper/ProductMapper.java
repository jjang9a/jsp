package co.prod.mapper;

import java.util.List;

import co.prod.vo.ProductVO;

public interface ProductMapper {
	//목록
	public List<ProductVO> productList();
	public ProductVO productInfo(String code);
	public List<ProductVO> productReco();
}

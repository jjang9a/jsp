package co.prod.service;

import java.util.List;

import co.prod.vo.ProductVO;
import co.prod.vo.ReplyVO;

public interface ProductService {
	public List<ProductVO> products();
	public ProductVO getProduct(String code);
	public List<ProductVO> recomend();
	
	public List<ReplyVO> replyList(String code); // 상품에 대한 댓글 목록
	public boolean replyRemove(int no);
	public boolean addReply(ReplyVO vo);
}

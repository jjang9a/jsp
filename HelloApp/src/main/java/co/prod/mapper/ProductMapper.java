package co.prod.mapper;

import java.util.List;

import co.prod.vo.ProductVO;
import co.prod.vo.ReplyVO;

public interface ProductMapper {
	//목록
	public List<ProductVO> productList();
	public ProductVO productInfo(String code);
	public List<ProductVO> productReco();
	public List<ReplyVO> replyList(String code);
	public int replyDelete(int no);
	public int insertReply(ReplyVO vo);
}

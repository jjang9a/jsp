package co.prod.service;

import java.util.List;
import java.util.Map;

import co.prod.vo.EventVO;
import co.prod.vo.ProductVO;
import co.prod.vo.ReplyVO;

public interface ProductService {
	public List<ProductVO> products();
	public ProductVO getProduct(String code);
	public List<ProductVO> recomend();
	
	public List<ReplyVO> replyList(String code); // 상품에 대한 댓글 목록
	public boolean replyRemove(int no);
	public boolean addReply(ReplyVO vo);
	public ReplyVO getReply(int rid); // 댓글 단건조회
	public boolean modifyReply(ReplyVO vo);
	
	public List<Map<String,Object>> chartInfo();
	
	public List<EventVO> eventList();
	public boolean addEvent(EventVO vo);
	public boolean removeEvent(EventVO vo);
}

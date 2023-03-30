package co.prod.mapper;

import java.util.List;
import java.util.Map;

import co.prod.vo.EventVO;
import co.prod.vo.ProductVO;
import co.prod.vo.ReplyVO;

public interface ProductMapper {
	//목록
	public List<ProductVO> productList();
	public ProductVO productInfo(String code);
	public List<ProductVO> productReco();
	//댓글
	public List<ReplyVO> replyList(String code);
	public int replyDelete(int no);
	public int insertReply(ReplyVO vo);
	public ReplyVO selectReply(int rid);
	public int updateReply(ReplyVO vo);
	// 차트
	public List<Map<String, Object>> chartInfo();
	// 달력
	public List<EventVO> eventList();
	public int addEvent(EventVO vo);
	public int deleteEvent(EventVO vo);
}

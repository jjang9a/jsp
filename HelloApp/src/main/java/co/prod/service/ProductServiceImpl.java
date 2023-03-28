package co.prod.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import co.prod.common.DataSource;
import co.prod.mapper.ProductMapper;
import co.prod.vo.ProductVO;
import co.prod.vo.ReplyVO;

public class ProductServiceImpl implements ProductService{

	SqlSession sqlSession = DataSource.getInstance().openSession(true); //매개값이 true이면 자동 커밋 실행
	ProductMapper mapper = sqlSession.getMapper(ProductMapper.class);
	
	@Override
	public List<ProductVO> products() {
		return mapper.productList();
	}

	@Override
	public ProductVO getProduct(String code) {
		return mapper.productInfo(code);
	}

	@Override
	public List<ProductVO> recomend() {
		return mapper.productReco();
	}

	@Override
	public List<ReplyVO> replyList(String code) {
		return mapper.replyList(code);
	}

	@Override
	public boolean replyRemove(int no) {
		return mapper.replyDelete(no) == 1;
	}

	@Override
	public boolean addReply(ReplyVO vo) {
		return mapper.insertReply(vo) == 1;
	}

}

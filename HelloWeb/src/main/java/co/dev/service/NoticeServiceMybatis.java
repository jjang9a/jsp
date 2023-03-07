package co.dev.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import co.dev.common.Datasource;
import co.dev.mapper.NoticeMapper;
import co.dev.vo.NoticeVO;

public class NoticeServiceMybatis implements NoticeService {
	
	// jdbc : NoticeDAO dao;
	// mybatis : mapper;
	SqlSession sqlSession = Datasource.getInstance().openSession(true);
	NoticeMapper mapper = sqlSession.getMapper(NoticeMapper.class);
	
	// 목록
	@Override
	public List<NoticeVO> noticeList(int page) {
//		return mapper.noticeList();
		return mapper.noticeListWithPaging(page);
	}

	// 등록
	@Override
	public boolean addNotice(NoticeVO vo) {
		int r = mapper.insertNotice(vo);
		sqlSession.commit(); // 다른 세션에서 반영
		return r == 1;
	}

	@Override
	public NoticeVO getNotice(int nid) {
		mapper.updateCount(nid); // 조회수 증가
		return mapper.selectNotice(nid);
	}

}

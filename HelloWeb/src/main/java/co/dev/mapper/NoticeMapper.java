package co.dev.mapper;

import java.util.List;

import co.dev.vo.NoticeVO;

public interface NoticeMapper {
	
	public List<NoticeVO> noticeList(); // 목록
	public List<NoticeVO> noticeListWithPaging(int page);
	public int insertNotice(NoticeVO vo); // 등록
	public NoticeVO selectNotice(int nid); // 단건 조회
	public int updateCount(int nid); // 조회수 증가
	public int getTotalCount(); // 전체 글 수
	public int updateNotice(NoticeVO vo);
	public int deleteNotice(int nid);
}

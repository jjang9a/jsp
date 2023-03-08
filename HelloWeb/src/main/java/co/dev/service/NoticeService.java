package co.dev.service;

import java.util.List;

import co.dev.vo.NoticeVO;

public interface NoticeService {
	// 업무로직을 처리하기 위한 인터페이스 선언
	// 목록
	public List<NoticeVO> noticeList(int page);
	// (한 건) 등록
	public boolean addNotice(NoticeVO vo);
	// 상세조회
	public NoticeVO getNotice(int nid);
	// 전체 건수
	public int getTotalCount();
	// 수정
	public boolean noticeModify(NoticeVO vo);
	// 삭제
	public boolean noticeRemove(int nid);
}

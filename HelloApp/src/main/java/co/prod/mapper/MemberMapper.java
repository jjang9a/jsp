package co.prod.mapper;

import java.util.List;

import co.prod.vo.EmpVO;
import co.prod.vo.MemberVO;
import co.prod.vo.MembersVO;



public interface MemberMapper {
	// 매퍼(MemberMapper.xml)에서 실행할 메소드 정의
	public List<MemberVO> getMembers();
	
	// 로그인 용도
	public MemberVO login(MemberVO vo);
	
	// 회원 삭제
	public int deleteMember(String id);
	
	// 회원 등록
	public int insertMember(MemberVO vo);
	
	// new List
	public List<MembersVO> memberList();
	public int addNewMember(MembersVO vo);
	//public int deleteMembers(List<MembersVO> list); // 여러건 한번에 삭제
	// delete from members where member_id in ('user01', 'user02', 'user03')
	public int deleteMembersAry(String[] members);
	
	
	//dataTable
	// 사원 목록
	public List<EmpVO> selectEmployees();
	public int addEmp(EmpVO vo);
	public int delEmp(int id);
	
}

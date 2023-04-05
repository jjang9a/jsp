package co.prod.service;

import java.util.List;

import co.prod.vo.EmpVO;
import co.prod.vo.MemberVO;
import co.prod.vo.MembersVO;

public interface MemberService {
	// 회원 목록
	public List<MemberVO> getMembers();
	// 회원 등록
	public boolean addMember(MemberVO vo);
	// 회원 조회
	public MemberVO getMember(String id);
	// 회원 수정
	public boolean modifyMember(MemberVO vo);
	// 회원 삭제
	public boolean removeMember(String id);
	// id/pw 로그인 처리
	public MemberVO login(MemberVO vo);
	
	
	// new List
	public List<MembersVO> getMemberList();
	public boolean addNewMember(MembersVO vo);
	// public boolean deleteMembers(List<MembersVO> list);
	public boolean removeMemberAry(String[] users);
	
	// dataTable
	// 사원목록
	public List<EmpVO> employeeList();
	public boolean addEmp(EmpVO vo);
	public boolean delEmp(int id);
	
	
}

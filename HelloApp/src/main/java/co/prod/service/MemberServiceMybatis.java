package co.prod.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import co.prod.common.DataSource;
import co.prod.mapper.MemberMapper;
import co.prod.vo.EmpVO;
import co.prod.vo.MemberVO;
import co.prod.vo.MembersVO;

public class MemberServiceMybatis implements MemberService {

	// jdbc를 활용할 때는 MemberDAO dao를 활용했었음
	// mybatis : DataSource : SqlSessionFactory -> SqlSession;
	private SqlSession sqlSession = DataSource.getInstance().openSession(true);
	// Mapper.xml 파일의 메소드를 호출.
	private MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);

	@Override
	public List<MemberVO> getMembers() {
		return mapper.getMembers();
	}

	@Override
	public boolean addMember(MemberVO vo) {
		return mapper.insertMember(vo) == 1;
	}

	@Override
	public MemberVO getMember(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean modifyMember(MemberVO vo) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean removeMember(String id) {
		return mapper.deleteMember(id) == 1;
	}

	@Override
	public MemberVO login(MemberVO vo) {
		return mapper.login(vo);
	}

	@Override
	public List<MembersVO> getMemberList() {
		return mapper.memberList();
	}

	@Override
	public boolean addNewMember(MembersVO vo) {
		return mapper.addNewMember(vo) == 1;
	}

//	@Override public boolean deleteMembers(List<MembersVO> list) {
//		return mapper.deleteMembers(list) > 0; 
//	}

	@Override
	public boolean removeMemberAry(String[] users) {
		return mapper.deleteMembersAry(users) > 0;
	}

	@Override
	public List<EmpVO> employeeList() {
		return mapper.selectEmployees();
	}

	@Override
	public boolean addEmp(EmpVO vo) {
		return mapper.addEmp(vo) == 1;
	}

	@Override
	public boolean delEmp(int id) {
		return mapper.delEmp(id) == 1;
	}

}

package co.dev.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import co.dev.common.Datasource;
import co.dev.mapper.MemberMapper;
import co.dev.vo.MemberVO;

public class MemberServiceMybatis implements MemberService {

	// jdbc를 활용할 때는 MemberDAO dao를 활용했었음
	// mybatis : DataSource : SqlSessionFactory -> SqlSession;
	private SqlSession sqlSession = Datasource.getInstance().openSession();
	// Mapper.xml 파일의 메소드를 호출.
	private MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
	
	@Override
	public List<MemberVO> getMembers() {
		return mapper.getMembers();
	}

	@Override
	public boolean addMember(MemberVO vo) {
		// TODO Auto-generated method stub
		return false;
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
		// TODO Auto-generated method stub
		return false;
	}

}

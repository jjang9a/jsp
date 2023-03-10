package co.prod.common;

import java.io.IOException;
import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

// ojdbc를 활용하여 db connection 객체를 가져왔었음
// ㄴ 특징 : 실행할 때 마다 객체를 생성하고 반환
// connection 객체를 서버가 실행되면 미리 생성해놨다가(10개)
// Datasource => Resource를 가져오는 룩업
public class DataSource {
	// 싱글톤 방식(리소스를 아끼기 위해서)
	private static SqlSessionFactory sqlSessionFactory; // 필드값 처리
	
	private DataSource() {}
	
	public static SqlSessionFactory getInstance() {
		String resource = "config/mybatis-config.xml";
		InputStream inputStream = null;
		try {
			inputStream = Resources.getResourceAsStream(resource);
		} catch (IOException e) {
			e.printStackTrace();
		}
		SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
		return sqlSessionFactory;
	}
}

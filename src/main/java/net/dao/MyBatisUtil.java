package net.dao;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.io.Reader;


public class MyBatisUtil
{

	private static SqlSessionFactory sf;
	static {
		try{
			String path= "SqlMapConfig.xml";
			SqlSessionFactoryBuilder sfb=new SqlSessionFactoryBuilder();
			Reader reader= Resources.getResourceAsReader(path);
			sf=sfb.build(reader);
		}catch (Exception e){

		}
	}
	public static SqlSession getSession(){
		SqlSession sqlSession = sf.openSession(true);
		System.out.println(sqlSession);
		return sqlSession;

	}

}

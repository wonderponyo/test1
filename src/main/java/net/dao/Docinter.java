package net.dao;

import net.inf.Docinf;
import net.inf.Userinf;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface Docinter
{
	public int insertFile(Docinf docinf);
	public int updatedoctate(@Param("id")String id,@Param("state")String state);
	public  List<Docinf> querydocbytitle(String title);
	public List<Docinf> showAlldoc(@Param("start") String start, @Param("end") String end, @Param("username") String username, @Param("startpage") String startpage,@Param("doctitle") String doctitle,@Param("doctype") String doctype);
	public int docCount(@Param("start") String start, @Param("end") String end, @Param("username") String username,@Param("doctitle") String doctitle,@Param("doctype") String doctype);
}

package net.dao;

import net.inf.Userinf;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
@Mapper
public interface Userinter
{
	public int insertUser(Userinf userinf);
	public List<Userinf> showAlluser(@Param("start") String start, @Param("end") String end, @Param("username") String username, @Param("startpage") String startpage);
	public int userCount(@Param("start") String start, @Param("end") String end, @Param("username") String username);
	public int updateUserstate(@Param("username") String username, @Param("state") String state);
	public Userinf findUserbyid(int id);
	public  Userinf findByusername(String id);
}

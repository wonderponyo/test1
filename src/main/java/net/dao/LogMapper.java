package net.dao;

import net.inf.Loginf;
import net.inf.Userinf;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface LogMapper
{

	public int insertLog(Loginf loginf);
	public List<Loginf> showAllLog(@Param("start") String start, @Param("end") String end, @Param("opman") String opman, @Param("startpage") String startpage);
	public int logCount(@Param("start") String start, @Param("end") String end, @Param("opman") String opman);

}

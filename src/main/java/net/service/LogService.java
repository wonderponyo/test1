package net.service;

import net.dao.LogMapper;
import net.inf.Loginf;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LogService
{
	@Autowired
private LogMapper logMapper;

	public int insertLog(Loginf loginf){
		return logMapper.insertLog(loginf);
	}
	public List<Loginf> showAllLog(@Param("start") String start, @Param("end") String end, @Param("opman") String opman, @Param("startpage") String startpage){
		return logMapper.showAllLog(start,end,opman,startpage);
	}
	public int logCount(@Param("start") String start, @Param("end") String end, @Param("opman") String opman){
		return logMapper.logCount(start,end,opman);
	}
}

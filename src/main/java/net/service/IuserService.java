package net.service;

import net.inf.Userinf;
import net.log.Log;

import java.util.List;

public interface IuserService
{
	public int insertUser(Userinf userinf);
	public List<Userinf> showAlluser(String page,String limit,String dateStart,String dateEnd,String username);
	public int userCount(String start, String end, String username);
	public int updateUserstate(String username, String state);

	public Userinf findUserbyid(int id);
	public  Userinf findByusername(String id);
}

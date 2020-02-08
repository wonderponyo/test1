package net.service;

import net.dao.Userinter;
import net.inf.Userinf;
import net.log.Log;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("userServiceimp")
public class UserService implements IuserService
{
	@Autowired
	private Userinter userinter;
	public int insertUser(Userinf userinf){
		return  userinter.insertUser(userinf);
	}
	public List<Userinf> showAlluser(String page,String limit,String dateStart,String dateEnd,String username){
		int pageInt = Integer.valueOf(page);
		int limitInt = Integer.valueOf(limit);
		int start=(pageInt-1)*limitInt; //计算开始条数

		return userinter.showAlluser(dateStart,dateEnd,username,String.valueOf(start));
	}
	public int userCount(String start, String end, String username){
		return userinter.userCount(start,end,username);

	}
	@Log(operationType = "修改操作", operationName = "修改用户状态")
	public int updateUserstate(String username, String state){
		return userinter.updateUserstate(username,state);
	}
	public Userinf findUserbyid(int id){
		return userinter.findUserbyid(id);
	}
	public  Userinf findByusername(String id){
		return  userinter.findByusername(id);
	}
}

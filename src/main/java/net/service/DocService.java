package net.service;

import net.dao.Docinter;
import net.inf.Docinf;
import net.log.Log;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DocService
{
	@Autowired
	private Docinter docinter;
	@Log(operationType = "上传文件", operationName = "用户上传文件")
	public int insertFile(Docinf docinf){
		docinf.setDocstate("待审核");
		return docinter.insertFile(docinf);
	}
	public List<Docinf> querydocbytitle(String title){
		return docinter.querydocbytitle(title);
	}
	public List<Docinf> showAlldoc(String date, String username, String page, String doctitle,  String doctype,String limit){
		String start="",end="";
		int pageInt = Integer.valueOf(page);
		int limitInt = Integer.valueOf(limit);
		int startpage=(pageInt-1)*limitInt; //计算开始条数
		if (date!=null&&!date.equals(""))
		{
			 start = date.split("~")[0];
			 end = date.split("~")[1];
		}
		return docinter.showAlldoc(start,end,username,String.valueOf(startpage),doctitle,doctype);

	}
	public int docCount(String date,  String username,String doctitle, String doctype){
		String start="",end="";
		if (date!=null&&!date.equals(""))
		{
			String dateArr[] = date.split("~");
			 start = dateArr[0];
			 end = dateArr[1];
		}
		return docinter.docCount(start,end,username,doctitle,doctype);
	}
	public int updatedoctate(String id,String state){return docinter.updatedoctate(id,state);}

}

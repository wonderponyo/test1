package net.controller;

import com.google.gson.Gson;
import net.inf.DatagridResult;
import net.inf.Docinf;
import net.inf.Userinf;
import net.service.DocService;
import net.service.IuserService;
import net.service.UserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.Date;
import java.util.List;

@Controller

@RequestMapping("/backstage")
public class BackController
{
	@Autowired
	private IuserService userService;
	@Autowired
	private DocService docService;
	@RequestMapping("/log.action")
	public ModelAndView backlogin(HttpServletRequest request,String account, String password){
		ModelAndView modelAndView=new ModelAndView();

		Userinf userinf=new Userinf();
		userinf.setUsername(account);
		request.getSession().setAttribute("user",userinf.getUsername());
		modelAndView.addObject("user",userinf);
		modelAndView.setViewName("/background/bjsp/backmain");
		return  modelAndView;
	}

	@RequestMapping(value = "/userlist.action", produces ="application/json;charset=utf-8")
	@ResponseBody
	public DatagridResult userlist(String page,String limit,String dateStart,String dateEnd,String username){
		DatagridResult datagridResult=new DatagridResult();
		List<Userinf> userinfs= userService.showAlluser(page,limit,dateStart,dateEnd,username);
		int count=userService.userCount(dateStart,dateEnd,username);
		datagridResult.setData(userinfs);
		datagridResult.setCount(count);
//		return new Gson().toJson(datagridResult);

		return datagridResult;
	}

	@RequestMapping(value = "/doclist.action", produces ="application/json;charset=utf-8")
	@ResponseBody
	public DatagridResult doclist(String page,String limit,String doctitle,String username,String doctype,String date){
		DatagridResult datagridResult=new DatagridResult();
		List<Docinf> docinfs= docService.showAlldoc(date,username,page,doctitle,doctype,limit);
		int count=docService.docCount(date,username,doctitle,doctype);
		datagridResult.setData(docinfs);
		datagridResult.setCount(count);
		//		return new Gson().toJson(datagridResult);

		return datagridResult;
	}

	@RequestMapping("/updateState.action")
	@ResponseBody
	public String updateState(String username,String state){
		if (state.equals("启用")){
			state="审核通过";
		}
		int i=userService.updateUserstate(username,state);
		if (i>0){
				return "success";
			}else {
			return "fail";
		}
	}

	@RequestMapping("/updatedocState.action")
	@ResponseBody
	public String updatedocState(String id,String state){

		int i=docService.updatedoctate(id,state);
		if (i>0){
			return "success";
		}else {
			return "fail";
		}
	}

	@RequestMapping("/fileupload.action")
	@ResponseBody
	public String uploadFile(@RequestParam("file") MultipartFile fileact,HttpServletRequest request,Docinf docinf){
		System.out.println(fileact.getOriginalFilename());
		System.out.println(docinf.getDoctitle());
		System.out.println(docinf.getUsername());
		docinf.setTime(new Date().toLocaleString());
		docinf.setDocname(fileact.getOriginalFilename());
		docService.insertFile(docinf);
		try{
			String savePath = request.getSession().getServletContext().getRealPath("//filedir");
			System.out.println(savePath);
			fileact.transferTo(new File(savePath+"//" + fileact.getOriginalFilename()));
		}catch(Exception e){

		}

		return "{\"code\":0, \"msg\":\"\", \"data\":{}}";
	}

	@RequestMapping("/filedownload.action")
	//泛型指响应体中数据的类型
	public ResponseEntity<byte[]> fileDownload(HttpServletRequest request,String filename){
		ServletContext context=request.getServletContext();
		String realPath=context.getRealPath("//filedir//"+filename);
		byte[] tmp=new byte[10];
		try
		{
			FileInputStream inputStream=new FileInputStream(realPath);
			tmp=new byte[inputStream.available()];
			inputStream.read(tmp);
			inputStream.close();

		} catch (Exception e)
		{
			e.printStackTrace();
		}
		System.out.println(realPath);
		HttpHeaders httpHeaders=new HttpHeaders();
		//application/octet-stream二进制流数据
		httpHeaders.setContentType(MediaType.APPLICATION_OCTET_STREAM);
		//设置以附件的形式下载
		httpHeaders.set("Content-Disposition","attachment;filename="+filename);
		return new ResponseEntity<byte[]>(tmp,httpHeaders, HttpStatus.OK);
	}


	}


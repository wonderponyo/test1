package net.controller;

import net.inf.Userinf;
import net.service.IuserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.annotation.RequiresGuest;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;

@Controller
@RequiresGuest
@RequestMapping("/front")
public class FrontController
{
	@Autowired
	private IuserService userservice;
	@RequestMapping("/reg.action")
	@ResponseBody
	public String reg(Userinf userinf){
		ByteSource salt=ByteSource.Util.bytes(userinf.getUsername());
		Object md5pwd= new SimpleHash("MD5",userinf.getPassword(),salt,2);
		userinf.setPassword(md5pwd.toString());
		userinf.setRegtime(new Date().toLocaleString());
		userinf.setUserstate("审核通过");
		System.out.println("注册调用");
		userservice.insertUser(userinf);
		return "suc";
	}

	@RequestMapping("/log.action")
	@ResponseBody
	public String log(HttpServletRequest request,String loginAccount,String loginPassword){
//		String rs="false";
		Userinf userinf=userservice.findByusername(loginAccount);
//		if (userinf.getPassword()!=null&&loginPassword.equals(userinf.getPassword())){
//			request.getSession().setAttribute("userinf",userinf);
//			request.getSession().setAttribute("user",userinf.getUsername());
//			rs="success";
//		}
		Subject currentUser= SecurityUtils.getSubject();
		if (!currentUser.isAuthenticated()){
			UsernamePasswordToken usernamePasswordToken=new UsernamePasswordToken(loginAccount,loginPassword);
			try
			{
				currentUser.login(usernamePasswordToken);
				request.getSession().setAttribute("userinf",userinf);
				request.getSession().setAttribute("user",userinf.getUsername());
			}catch (AuthenticationException e){
				e.printStackTrace();

				return "false";
			}

		}
		return "success";
	}


}

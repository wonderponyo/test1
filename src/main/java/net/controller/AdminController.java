package net.controller;

import net.service.IuserService;
import net.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/admin")
public class AdminController
{
	@Autowired
	private IuserService userservice;
	@RequestMapping("test")
	public ModelAndView test(){
		ModelAndView modelAndView=new ModelAndView();
		modelAndView.setViewName("index");

		return  modelAndView;
	}
	@RequestMapping("/tologin.action")
	public String tologin(String account,String password){
		System.out.println(account+","+password);
		return "index";
	}
}

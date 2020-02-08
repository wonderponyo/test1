package net.log;


import net.inf.Loginf;
import net.inf.Userinf;
import net.service.LogService;
import org.apache.log4j.Logger;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.lang.reflect.Method;
import java.util.Date;
import java.util.UUID;



@Aspect
@Component

public class SystemLogAspect
{
    @Autowired
private LogService logService;


	private static Logger logger = Logger.getLogger("nyttest");
    

    @Pointcut("execution (* net.service..*.*(..))")
    public  void controllerAspect() {  
    }
    

    /** 
     * 后置通知 用于拦截Controller层记录用户的操作 
     * 
     * @param joinPoint 切点 
     */  
    @After("controllerAspect()")
    public  void after(JoinPoint joinPoint) throws Throwable{
  
       HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        HttpSession session = request.getSession();
        //读取session中的用户  
        String user = (String) session.getAttribute("user");
        //请求的IP  
        //String ip = request.getRemoteAddr();
//        User user = new User();
//        user.setId(1);
//        user.setName("张三");
//        String ip = "127.0.0.1";
         try {  
            logger.info("日志记录测试");
            String targetName = joinPoint.getTarget().getClass().getName();  
            String methodName = joinPoint.getSignature().getName();  
            Object[] arguments = joinPoint.getArgs();  
            Class targetClass = Class.forName(targetName);  
            Method[] methods = targetClass.getMethods();
            String operationType = "";
            String operationName = "";
             for (Method method : methods) {  
                 if (method.getName().equals(methodName)) {  
                    Class[] clazzs = method.getParameterTypes();  
                     if (clazzs.length == arguments.length) {
                         if (method.getAnnotation(Log.class)!=null)
                         {
                             operationType = method.getAnnotation(Log.class).operationType();
                             operationName = method.getAnnotation(Log.class).operationName();
                             //*========控制台输出=========*//
                             System.out.println("=====controller后置通知开始=====");
                             System.out.println("请求方法:" +operationType);
                             System.out.println("方法描述:" + operationName);
                             System.out.println("操作人："+user);
                             Loginf log = new Loginf();
                             log.setOpthing(operationName);
                             log.setOptype(operationType);
                             log.setOptime(new Date().toLocaleString());
                             log.setOpman(user);
                             logService.insertLog(log);

                             System.out.println("=====controller后置通知结束=====");
                             break;
                         }
                    }  
                }  
            }

        }  catch (Exception e) {  
            //记录本地异常日志  
            logger.error("==后置通知异常==");  
            logger.error("异常信息:{}------"+ e.getMessage());  
            
            
            throw e;
        }  
    } 
    

}
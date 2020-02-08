package net.Realm;

import net.inf.Userinf;
import net.service.UserService;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;

import javax.annotation.Resource;

public class ShiroRealm extends AuthorizingRealm
{
	@Resource
	private UserService userService;
	/**
	 * 授权
	 * @param principalCollection
	 * @return
	 */

	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection)
	{
		return null;
	}

	/**
	 * 认证
	 * @param token
	 * @return
	 * @throws AuthenticationException
	 */

	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException
	{
		UsernamePasswordToken uptoken=(UsernamePasswordToken)token;
		String username=uptoken.getUsername();
		Userinf userinf=userService.findByusername(username);
		if (userinf!=null){
			ByteSource salt=ByteSource.Util.bytes(userinf.getUsername());

			SimpleAuthenticationInfo info= new SimpleAuthenticationInfo(userinf,userinf.getPassword(),salt,getName());
			return info;
		}
		return null;
	}
}

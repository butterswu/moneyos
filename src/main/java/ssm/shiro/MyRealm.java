package ssm.shiro;


import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.Subject;
import ssm.dao.ParkDao;
import ssm.dao.UserDao;
import ssm.dao.UserLevelDao;
import ssm.model.*;
import ssm.service.UserService;

import javax.annotation.Resource;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

/** * Created with IDEA * Created by ${jie.chen} on 2016/7/14. * Shiro自定义域 */
public class MyRealm extends AuthorizingRealm {

    @Resource
    private UserDao userDao;



    /** * 用于的权限的认证。 * @param principalCollection * @return */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        String userName = principalCollection.getPrimaryPrincipal().toString() ;
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo() ;
        User user1 =userDao.getShiroByUserName(userName);
        Set<String> roleName = new HashSet<String>();
        Set<String> permissions =new HashSet<String>();
        for (Role role:user1.getRoleList()){
            roleName.add(role.getRoleName());
            for (Permission permission:role.getPermissionList()){
                permissions.add(permission.getPermissionName());
            }

        }



 /*       int userLevelId=userDao.getUserLevelIdByUserName(userName);
        UserLevel userLevel=userLevelDao.getUserLevelById(userLevelId);
        Set<String> roleName=new HashSet<String>();
        Set<String> permissions=new HashSet<String>();
        Iterator<PermissionKind> role =userLevel.getPermissionKindSet().iterator();
        while (role.hasNext()){
                PermissionKind permissionKind=role.next();
                String permissionKindName=permissionKind.getPermissionKindName();
                roleName.add(permissionKindName);
                Iterator<PermissionItem> permissionItemIterator =permissionKind.getPermissionItemSet().iterator();
                while (permissionItemIterator.hasNext()){
                    permissions.add(permissionKindName+":"+permissionItemIterator.next().getPermissionItemName());
                }
             }

        info.setRoles(roleName);
        info.setStringPermissions(permissions);*/

   /*     Set<String> roleName = t_userService.findRoles(username) ;
        Set<String> permissions = t_userService.findPermissions(username) ;
        info.setRoles(roleName);
        info.setStringPermissions(permissions);*/
        info.setRoles(roleName);
        info.setStringPermissions(permissions);
        return info;
    }

    /** * 首先执行这个登录验证 * @param token * @return * @throws AuthenticationException */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token)
            throws AuthenticationException {
        //获取用户账号
        String username = token.getPrincipal().toString() ;
        User user = userDao.findByUserName(username) ;



        if (user != null){
            //将查询到的用户账号和密码存放到 authenticationInfo用于后面的权限判断。第三个参数传入realName。
            AuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(user.getUserName(),user.getUserPwd(),
                    "a") ;
            Subject subject= SecurityUtils.getSubject();
            subject.getSession().setAttribute("user_id",user.getId());
            return authenticationInfo ;
        }else{
            return  null ;
        }
    }
}
package ssm.model;

import java.util.Set;

public class UserLevel {
    private int id;
    private String userLevelName;
    private int userRoleId;
    private String userRoleName;
    private Set<PermissionKind> permissionKindSet;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserLevelName() {
        return userLevelName;
    }

    public void setUserLevelName(String userLevelName) {
        this.userLevelName = userLevelName;
    }

    public int getUserRoleId() {
        return userRoleId;
    }

    public void setUserRoleId(int userRoleId) {
        this.userRoleId = userRoleId;
    }

    public String getUserRoleName() {
        return userRoleName;
    }

    public void setUserRoleName(String userRoleName) {
        this.userRoleName = userRoleName;
    }

    public Set<PermissionKind> getPermissionKindSet() {
        return permissionKindSet;
    }

    public void setPermissionKindSet(Set<PermissionKind> permissionKindSet) {
        this.permissionKindSet = permissionKindSet;
    }

    @Override
    public String toString() {
        return "UserLevel{" +
                "id=" + id +
                ", userLevelName='" + userLevelName + '\'' +
                ", userRoleId=" + userRoleId +
                ", userRoleName='" + userRoleName + '\'' +
                ", permissionKindSet=" + permissionKindSet +
                '}';
    }
}

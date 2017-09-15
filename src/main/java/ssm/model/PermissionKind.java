package ssm.model;

import java.util.Set;

public class PermissionKind {
    private int permissionKindId;
    private String permissionKindName;
    private Set<PermissionItem> permissionItemSet;

    public int getPermissionKindId() {
        return permissionKindId;
    }

    public void setPermissionKindId(int permissionKindId) {
        permissionKindId = permissionKindId;
    }

    public String getPermissionKindName() {
        return permissionKindName;
    }

    public void setPermissionKindName(String permissionKindName) {
        permissionKindName = permissionKindName;
    }

    public Set<PermissionItem> getPermissionItemSet() {
        return permissionItemSet;
    }

    public void setPermissionItemSet(Set<PermissionItem> permissionItemSet) {
        this.permissionItemSet = permissionItemSet;
    }

    @Override
    public String toString() {
        return "PermissionKind{" +
                "PermissionKindId=" + permissionKindId +
                ", PermissionKindName='" + permissionKindName + '\'' +
                ", permissionItemSet=" + permissionItemSet +
                '}';
    }
}

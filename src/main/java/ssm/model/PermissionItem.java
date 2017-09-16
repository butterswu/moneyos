package ssm.model;

public class PermissionItem {
    private int permissionItemId;
    private String permissionItemName;

    public int getPermissionItemId() {
        return permissionItemId;
    }

    public void setPermissionItemId(int permissionItemId) {
        permissionItemId = permissionItemId;
    }

    public String getPermissionItemName() {
        return permissionItemName;
    }

    public void setPermissionItemName(String permissionItemName) {
        permissionItemName = permissionItemName;
    }

    @Override
    public String toString() {
        return "PermissionItem{" +
                "permissionItemId=" + permissionItemId +
                ", permissionItemName='" + permissionItemName + '\'' +
                '}';
    }
}

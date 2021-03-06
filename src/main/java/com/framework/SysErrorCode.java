package com.framework;

import java.util.HashMap;
import java.util.Map;

public interface SysErrorCode {

    public static final String SAVE_FAILED = "1001";
    public static final String ADMIN_CANNOT_DELETE = "1002";
    public static final String ORG_NAME_DUPLICATE = "1003";
    public static final String ROLE_NAME_DUPLICATE = "1004";
    public static final String USER_NAME_DUPLICATE = "1005";
    public static final String ADMIN_CANNOT_UPDATE = "1006";
    public static final String USER_PASSWORD_ERROR = "1007";
    public static final String DATA_INVALID = "1008";
    public static final String FILE_FORMAT_INVALID = "1009";
    public static final String UNITE_OPEN_ERROR = "1010";

    public static final Map<String, String> MAP = new HashMap<String, String>() {
        {
            put(SAVE_FAILED, "保存失败");
            put(ADMIN_CANNOT_UPDATE, "Admin不能被修改");
            put(ADMIN_CANNOT_DELETE, "Admin不能被删除");
            put(ORG_NAME_DUPLICATE, "组织名不能重复");
            put(ROLE_NAME_DUPLICATE, "角色名不能重复");
            put(USER_NAME_DUPLICATE, "用户名不能重复");
            put(USER_PASSWORD_ERROR, "用户密码错误");
            put(DATA_INVALID, "数据不合法");
            put(FILE_FORMAT_INVALID, "文件不合法");
            put(UNITE_OPEN_ERROR, "执行中出错，请检查日志！");
        }
    };

}

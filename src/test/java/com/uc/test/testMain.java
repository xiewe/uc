package com.uc.test;

import java.io.UnsupportedEncodingException;
import java.util.Calendar;
import java.util.Date;
import java.util.TimeZone;

public class testMain {

    public static void main(String[] args) {
        // 获取本地时区的方法
        Calendar cal = Calendar.getInstance();
        TimeZone timeZone = cal.getTimeZone();
        System.out.println(timeZone.getID());
        System.out.println(timeZone.getDisplayName());
        // 获取当前时区的方法（被setDefault后当前时区和本地时区是不一样的）
        TimeZone time = TimeZone.getDefault();
        System.out.println(time);

        // 后台返回Millisecond，前台按指定时区显示的方法
        TimeZone time1 = TimeZone.getTimeZone("GMT+5"); // 设置为东5区
        TimeZone.setDefault(time1);// 设置时区
        System.out.println(new Date(cal.getTimeInMillis() - 1000000));
        System.out.println(new Date());

        // 设置为本地时区
        TimeZone.setDefault(cal.getTimeZone());// 设置时区
        System.out.println(new Date(cal.getTimeInMillis() - 1000000));
        System.out.println(new Date());

        String tmp = "MCU+KEY+00你好";
        byte[] b = tmp.getBytes();

        try {
            System.out.println(new String(b));
            System.out.println(new String(b, "UTF-8"));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
    }

}

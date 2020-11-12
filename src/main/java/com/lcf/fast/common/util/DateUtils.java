package com.lcf.fast.common.util;

import cn.hutool.core.util.StrUtil;
import org.joda.time.DateTime;
import org.joda.time.LocalDate;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.TimeZone;

/**
 * 日期处理
 *
 * @author lcf
 * @date 2019-08-29 12:53:33
 */
public class DateUtils {
    /**
     * 时间格式(yyyy-MM-dd)
     */
    public final static String DATE_PATTERN = "yyyy-MM-dd";
    /**
     * 时间格式(yyyy-MM-dd HH:mm:ss)
     */
    public final static String DATE_TIME_PATTERN = "yyyy-MM-dd HH:mm:ss";
    /**
     * 时间格式(yyyy-MM-dd HH:mm:ss)
     */
    public final static String ZHUOWEN_DATE_TIME_DAY = "yyyy-MM-dd";

    public final static String ZHUOWEN_DATE_TIME_YEAE = "yyyy";

    public final static String ZHUOWEN_DATE_TIME_MONTH = "yyyy-MM";

    /**
     * 时间格式(yyyyMMddHH )
     */
    public final static String DATE_TIME_HOUR = "yyyyMMddHH";
    /**
     * 时间格式(yyyyMMdd )
     */
    public final static String DATE_TIME_DAY = "yyyyMMdd";
    /**
     * 时间格式(yyyyMM )
     */
    public final static String DATE_TIME_MONTH = "yyyyMM";
    /**
     * 时间格式(yyyyMMddHHmm )
     */
    public final static String DATE_TIME_MINUTE = "yyyyMMddHHmm";


    /**
     * 日期格式化 日期格式为：yyyy-MM-dd
     *
     * @param date 日期
     * @return 返回yyyy-MM-dd格式日期
     */
    public static String format(Date date) {
        return format(date, DATE_PATTERN);
    }

    /**
     * 日期格式化 日期格式为：yyyy-MM-dd
     *
     * @param date    日期
     * @param pattern 格式，如：DateUtils.DATE_TIME_PATTERN
     * @return 返回yyyy-MM-dd格式日期
     */
    public static String format(Date date, String pattern) {
        if (date != null) {
            TimeZone timeZone = TimeZone.getTimeZone("GMT+8:00");
            SimpleDateFormat df = new SimpleDateFormat(pattern);
            df.setTimeZone(timeZone);
            return df.format(date);
        }
        return null;
    }

    /**
     * 字符串转换成日期
     *
     * @param strDate 日期字符串
     * @param pattern 日期的格式，如：DateUtils.DATE_TIME_PATTERN
     */
    public static Date stringToDate(String strDate, String pattern) {
        if (StrUtil.isBlank(strDate)) {
            return null;
        }

        DateTimeFormatter fmt = DateTimeFormat.forPattern(pattern);
        return fmt.parseLocalDateTime(strDate).toDate();
    }

    /**
     * 根据周数，获取开始日期、结束日期
     *
     * @param week 周期  0本周，-1上周，-2上上周，1下周，2下下周
     * @return 返回date[0]开始日期、date[1]结束日期
     */
    public static Date[] getWeekStartAndEnd(int week) {
        DateTime dateTime = new DateTime();
        LocalDate date = new LocalDate(dateTime.plusWeeks(week));

        date = date.dayOfWeek().withMinimumValue();
        Date beginDate = date.toDate();
        Date endDate = date.plusDays(6).toDate();
        return new Date[]{beginDate, endDate};
    }

    /**
     * 对日期的【秒】进行加/减
     *
     * @param date    日期
     * @param seconds 秒数，负数为减
     * @return 加/减几秒后的日期
     */
    public static Date addDateSeconds(Date date, int seconds) {
        DateTime dateTime = new DateTime(date);
        return dateTime.plusSeconds(seconds).toDate();
    }

    /**
     * 对日期的【分钟】进行加/减
     *
     * @param date    日期
     * @param minutes 分钟数，负数为减
     * @return 加/减几分钟后的日期
     */
    public static Date addDateMinutes(Date date, int minutes) {
        DateTime dateTime = new DateTime(date);
        return dateTime.plusMinutes(minutes).toDate();
    }

    /**
     * 对日期的【小时】进行加/减
     *
     * @param date  日期
     * @param hours 小时数，负数为减
     * @return 加/减几小时后的日期
     */
    public static Date addDateHours(Date date, int hours) {
        DateTime dateTime = new DateTime(date);
        return dateTime.plusHours(hours).toDate();
    }

    /**
     * 对日期的【天】进行加/减
     *
     * @param date 日期
     * @param days 天数，负数为减
     * @return 加/减几天后的日期
     */
    public static Date addDateDays(Date date, int days) {
        DateTime dateTime = new DateTime(date);
        return dateTime.plusDays(days).toDate();
    }

    /**
     * 对日期的【周】进行加/减
     *
     * @param date  日期
     * @param weeks 周数，负数为减
     * @return 加/减几周后的日期
     */
    public static Date addDateWeeks(Date date, int weeks) {
        DateTime dateTime = new DateTime(date);
        return dateTime.plusWeeks(weeks).toDate();
    }

    /**
     * 对日期的【月】进行加/减
     *
     * @param date   日期
     * @param months 月数，负数为减
     * @return 加/减几月后的日期
     */
    public static Date addDateMonths(Date date, int months) {
        DateTime dateTime = new DateTime(date);
        return dateTime.plusMonths(months).toDate();
    }

    /**
     * 对日期的【年】进行加/减
     *
     * @param date  日期
     * @param years 年数，负数为减
     * @return 加/减几年后的日期
     */
    public static Date addDateYears(Date date, int years) {
        DateTime dateTime = new DateTime(date);
        return dateTime.plusYears(years).toDate();
    }

    /**
     * 取得当月天数
     */
    public static int getCurrentMonth() {
        Calendar a = Calendar.getInstance();
        a.set(Calendar.DATE, 1);//把日期设置为当月第一天
        a.roll(Calendar.DATE, -1);//日期回滚一天，也就是最后一天
        int maxDate = a.get(Calendar.DATE);
        return maxDate;
    }

    /**
     * 统计指定月的天数
     */
    public static int countDaysWithOneMonth(int year, int month) {
        Calendar a = Calendar.getInstance();
        a.set(Calendar.YEAR, year);
        a.set(Calendar.MONTH, month - 1);
        a.set(Calendar.DATE, 1);//把日期设置为当月第一天
        a.roll(Calendar.DATE, -1);//日期回滚一天，也就是最后一天
        int maxDate = a.get(Calendar.DATE);
        return maxDate;
    }

    /**
     * 获取系统当前时间的年、月、日、时、分、秒
     * @param type
     * @return
     */
    public static String currentDate(String type){
        Calendar now = Calendar.getInstance();
        if ("YEAR".equals(type)) {
            return now.get(Calendar.YEAR) + "";
        } else if ("MONTH".equals(type)) {
            return (now.get(Calendar.MONTH) + 1) + "";
        } else if ("DAY".equals(type)) {
            return now.get(Calendar.DAY_OF_MONTH) + "";
        } else if ("HH".equals(type)) {
            return now.get(Calendar.HOUR_OF_DAY) + "";
        } else if ("MM".equals(type)) {
            return now.get(Calendar.MINUTE) + "";
        } else if ("SS".equals(type)) {
            return now.get(Calendar.SECOND) + "";
        }
        return "";
    }

    /**
     * 获取 时间的BCD编码数值
     * @param date
     * @return BCD编码的时间数组 格式：[ss,mm,hh,DD,MM,YY]
     */
    public static int[] getDateBCD(Date date){
        if(date == null) {
            date = new Date();
        }
        int[] dateArr = new int[6];

        Calendar cal = Calendar.getInstance();
        cal.setTime(date);

        /*秒*/
        int second = cal.get(Calendar.SECOND);
        dateArr[0] = ((second / 10) << 4) + (second % 10);

        /*分*/
        int minute = cal.get(Calendar.MINUTE);
        dateArr[1] = ((minute / 10) << 4) + (minute % 10);

        /*时*/
        int hour = cal.get(Calendar.HOUR_OF_DAY);
        dateArr[2] = ((hour / 10) << 4) + (hour % 10);

        /*日*/
        int day = cal.get(Calendar.DATE);
        dateArr[3] = ((day / 10) << 4) + (day % 10);

        /*月*/
        int month = cal.get(Calendar.MONTH) + 1;
        dateArr[4] = ((month / 10) << 4) + (month % 10);

        /*年*/
        int year = cal.get(Calendar.YEAR);
        int yearL = year % 100;
        dateArr[5] = ((yearL / 10) << 4) + (yearL % 10);

        return dateArr;
    }

}

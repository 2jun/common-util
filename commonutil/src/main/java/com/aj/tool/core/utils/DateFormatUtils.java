package com.aj.tool.core.utils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;


public class DateFormatUtils {

	private static final String DATE_FORMAT1 = "yyyy-MM-dd HH:mm:ss";
	private static final String DATE_FORMAT2 = "yyyy-MM-dd";
	private static final String DATE_FORMAT3 = "yyyy-MM-dd_HH:mm:ss";
	private static final String DATE_FORMAT4 = "yyyy-MM-dd HH:mm";
	private static final String DATE_FORMAT5 = "MM/dd/yyyy";
	
    private final static Logger LOGGER = LoggerFactory.getLogger(DateFormatUtils.class);

	private static ThreadLocal<SimpleDateFormat> threadLocal1 = new ThreadLocal<SimpleDateFormat>() {
		protected synchronized SimpleDateFormat initialValue() {
			return new SimpleDateFormat(DATE_FORMAT1);
		}
	};
	private static ThreadLocal<SimpleDateFormat> threadLocal2 = new ThreadLocal<SimpleDateFormat>() {
		protected synchronized SimpleDateFormat initialValue() {
			return new SimpleDateFormat(DATE_FORMAT2);
		}
	};
	private static ThreadLocal<SimpleDateFormat> threadLocal3 = new ThreadLocal<SimpleDateFormat>() {
		protected synchronized SimpleDateFormat initialValue() {
			return new SimpleDateFormat(DATE_FORMAT3);
		}
	};
	private static ThreadLocal<SimpleDateFormat> threadLocal4 = new ThreadLocal<SimpleDateFormat>() {
		protected synchronized SimpleDateFormat initialValue() {
			return new SimpleDateFormat(DATE_FORMAT4);
		}
	};
	private static ThreadLocal<SimpleDateFormat> threadLocal5 = new ThreadLocal<SimpleDateFormat>() {
		protected synchronized SimpleDateFormat initialValue() {
			return new SimpleDateFormat(DATE_FORMAT5);
		}
	};

	/**
	 * yyyy-MM-dd HH:mm:ss
	 */
	public static SimpleDateFormat getDateFormatOfYMdHms() {
		return (SimpleDateFormat) threadLocal1.get();
	}

	/**
	 * yyyy-MM-dd
	 */
	public static SimpleDateFormat getDateFormatOfYMd() {
		return (SimpleDateFormat) threadLocal2.get();
	}

	/**
	 * yyyy-MM-dd_HH:mm:ss
	 */
	public static SimpleDateFormat getDateFormatOfyMd_Hms() {
		return (SimpleDateFormat) threadLocal3.get();
	}

	/**
	 * yyyy-MM-dd_HH:mm:ss
	 */
	public static SimpleDateFormat getDateFormat_yMdHm() {
		return (SimpleDateFormat) threadLocal4.get();
	}

	/**
	 * MM/dd/yyyy
	 */
	public static SimpleDateFormat getDateFormat_Mdy() {
		return (SimpleDateFormat) threadLocal5.get();
	}

	/**
	 * yyyy-MM-dd
	 * 
	 * @param date
	 * @return
	 * @throws ParseException
	 */
	public static String formatYMd(Date date) throws ParseException {
		return getDateFormatOfYMd().format(date);
	}

	/**
	 * yyyy-MM-dd
	 * 
	 * @param textDate
	 * @return
	 * @throws ParseException
	 */
	public static Date parseYMd(String textDate) throws ParseException {
		return getDateFormatOfYMd().parse(textDate);
	}

	/**
	 * yyyy-MM-dd HH:mm:ss
	 * 
	 * @param date
	 * @return
	 * @throws ParseException
	 */
	public static String formatYMdHms(Date date) throws ParseException {
		return getDateFormatOfYMdHms().format(date);
	}

	public static Date parseYMdHms(String textDate) throws ParseException {
		return getDateFormatOfYMdHms().parse(textDate);
	}

	/**
	 * yyyy-MM-dd HH:mm
	 * 
	 * @param date
	 * @return
	 * @throws ParseException
	 */
	public static String format_yMdHm(Date date) throws ParseException {
		return getDateFormat_yMdHm().format(date);
	}

	/**
	 * yyyy-MM-dd HH:mm
	 * 
	 * @param textDate
	 * @return
	 * @throws ParseException
	 */
	public static Date parse_yMdHm(String textDate) throws ParseException {
		return getDateFormat_yMdHm().parse(textDate);
	}

	/**
	 * yyyy-MM-dd_HH:mm:ss
	 * 
	 * @param date
	 * @return
	 * @throws ParseException
	 */
	public static String format_yMd_Hms(Date date) throws ParseException {
		return getDateFormatOfyMd_Hms().format(date);
	}

	/**
	 * yyyy-MM-dd_HH:mm:ss
	 * 
	 * @param textDate
	 * @return
	 * @throws ParseException
	 */
	public static Date parse_yMd_Hms(String textDate) throws ParseException {
		return getDateFormatOfyMd_Hms().parse(textDate);
	}

	/**
	 * MM/dd/yyyy
	 * 
	 * @param date
	 * @return
	 * @throws ParseException
	 */
	public static String format_Mdy(Date date) throws ParseException {
		return getDateFormat_Mdy().format(date);
	}

	/**
	 * MM/dd/yyyy
	 * 
	 * @param textDate
	 * @return
	 * @throws ParseException
	 */
	public static Date parse_Mdy(String textDate) throws ParseException {
		return getDateFormat_Mdy().parse(textDate);
	}


	/**
	 * 当日期间隔大于指定的间隔的时候，修改开始查询时间
	 * 
	 * @param startDate
	 * @param num
	 * @return Date
	 */
	public static Date setStartTime(Date startDate, int num) {

		Date newDate = new Date();
		long days = (newDate.getTime() - startDate.getTime()) / 86400000;
		if (days > num) {
			startDate = DateFormatUtils.getDateByPeriod(newDate, 0 - num);
		}

		return startDate;
	}

	/**
	 * 在当前的时间上加上或者减去指定的天数
	 * 
	 * @param targetDate
	 *            目标时间
	 * @param period
	 *            周期(-1 当前的时间减去一天；1当前的时间加一天)
	 * @return
	 */
	public static Date getDateByPeriod(Date targetDate, int period) {
		Calendar calendar = Calendar.getInstance();
		try {

			calendar.setTime(targetDate);
			calendar.add(Calendar.DAY_OF_MONTH, period);

		} catch (Exception e) {
           LOGGER.error(e.getMessage(),e);
		}
		return calendar.getTime();
	}
	

	
	/**
	 * 获取传入时间的开始时间：2015-11-11 00:00:00
	 * 
	 * @param date
	 * @return
	 */
	public static Date getStartTimeOfDate(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.set(Calendar.HOUR_OF_DAY, 0);
		calendar.set(Calendar.MINUTE, 0);
		calendar.set(Calendar.SECOND, 0);
		calendar.set(Calendar.MILLISECOND, 0);
		return calendar.getTime();
	}
	
	/**
	 * 线程不安全的
	 * 算出开始时间和结束时间之间的时间List (long interval为指定的间隔,单位：秒)
	 * @param startDate
	 * @param endDate
	 * @param interval
	 * @return List<Date> dates
	 */
	public static List<Date> splitDateToList(Date startDate, Date endDate,long interval)  {
		if(interval <= 1) {
			System.err.println("间隔必须大于1！");
			return new ArrayList<Date>();
		}
		ArrayList<Date> dateList = new ArrayList<Date>();
		interval -= 1;
		
		long startDateTime = startDate.getTime();
		long endDateTime = endDate.getTime();

		if (startDateTime != endDateTime) {
			dateList.add(startDate);
			startDateTime = startDateTime + interval*1000;
			while (startDateTime+interval*1000 < endDateTime) {
				dateList.add(new Date(startDateTime));
				startDateTime+=1000;
				dateList.add(new Date(startDateTime));
				startDateTime = startDateTime + interval*1000;
			}
			dateList.add(endDate);
		} else {
			dateList.add(startDate);
			dateList.add(endDate);
		}
		return dateList;
	}
	
	/**
	 * 获取传入时间的结束时间：2015-11-11 23:59:59
	 * 
	 * @param date
	 * @return
	 */
	public static Date getEndTimeOfDate(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.DAY_OF_MONTH, 1);
		calendar.set(Calendar.HOUR_OF_DAY, 0);
		calendar.set(Calendar.MINUTE, 0);
		calendar.set(Calendar.SECOND, 0);
		calendar.add(Calendar.SECOND, -1);
		return calendar.getTime();
	}

    /**

     */
    /**
     * 根据最早的开始时间 跟时间节点 ,取最早的开始时间
     * 开始时间 2020-03-15
     * 最早开始时间 45天
     * @param startDate  对比的开始时间
     * @param date  对比天
     * @param beforeDateNum 对比天之前的天数
     * @return
     */
    public static Date getEarliestTime(Date startDate, Date date,int beforeDateNum) throws Exception {
        //开始时间最早
        Date startTimeOfDate = getStartTimeOfDate(startDate);
        //当前对比日的时间
        Date compareOfDate = getStartTimeOfDate(date);
        //对比日往前推的时间
        Date dateByPeriod = getDateByPeriod(compareOfDate, -beforeDateNum);
        if (startTimeOfDate.getTime() >= dateByPeriod.getTime()) {
            String s = format_yMd_Hms(startTimeOfDate);
            System.out.println(s);
            return startTimeOfDate;
        } else {
            String s = format_yMd_Hms(dateByPeriod);
            System.out.println(s);
            return dateByPeriod;
        }
    }

    public static void main(String[] args) throws Exception {
//        test();
        String startDate="2020-04-11";
        int beforeDateNum=4;
        System.out.println(getEarliestTime(DateFormatUtils.parseYMd(startDate), new Date(), beforeDateNum));

    }

    private static void test() throws ParseException {
        Date endDate = parseYMdHms("2019-02-20 23:59:59");
        Date startDate = parseYMdHms("2019-02-13 00:00:00");
        int a = 10;
        System.out.println(formatYMdHms(getDateByPeriod(startDate, 11)));
        ;
        System.out.println(formatYMdHms(endDate));
        ;
        if(getDateByPeriod(startDate, 10).getTime()<endDate.getTime()){
            System.out.println(true);
        }else{
            System.out.println(false);
        }
    }

}
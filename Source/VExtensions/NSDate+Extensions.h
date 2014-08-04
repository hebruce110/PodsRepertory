//
//  NSDate+Extensions.h
//  VExtensions
//
//  Created by yuan on 14-6-6.
//  Copyright (c) 2014年 www.heyuan110.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define D_MINUTE	60
#define D_HOUR		3600
#define D_DAY		86400
#define D_WEEK		604800
#define D_YEAR		31556926

@interface NSDate (NSDate_Extensions)

- (NSString *)formatMD;
- (NSString *)formatYM;
- (NSString *)formatYMD;
- (NSString *)formatYMDHMS;
- (NSString *)formatHM;
- (NSString *)format;
- (NSString *)formatWithStyle:(NSString *)style;

// Relative dates from the current date
+ (NSDate *) dateTomorrow;
+ (NSDate *) dateYesterday;
+ (NSDate *) dateWithDaysFromNow: (NSInteger) days;
+ (NSDate *) dateWithDaysBeforeNow: (NSInteger) days;
+ (NSDate *) dateWithHoursFromNow: (NSInteger) dHours;
+ (NSDate *) dateWithHoursBeforeNow: (NSInteger) dHours;
+ (NSDate *) dateWithMinutesFromNow: (NSInteger) dMinutes;
+ (NSDate *) dateWithMinutesBeforeNow: (NSInteger) dMinutes;

+ (NSDate *)translateStrToFullDate:(NSString *)strDate;
+ (NSDate *)translateStrToFullDateWithShorttime:(NSString *)strDate;
+ (NSDate *)translateStrDateToDate:(NSString *)strDate;

//今天到月末还有的天数
+ (NSInteger)nowToMonthLastDay;

// Comparing dates
- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate;
- (BOOL) isToday;
- (BOOL) isTomorrow;
- (BOOL) isYesterday;
- (BOOL) isSameWeekAsDate: (NSDate *) aDate;
- (BOOL) isThisWeek;
- (BOOL) isNextWeek;
- (BOOL) isLastWeek;
- (BOOL) isSameMonthAsDate: (NSDate *) aDate;
- (BOOL) isThisMonth;
- (BOOL) isSameYearAsDate: (NSDate *) aDate;
- (BOOL) isThisYear;
- (BOOL) isNextYear;
- (BOOL) isLastYear;
- (BOOL) isEarlierThanDate: (NSDate *) aDate; //<
- (BOOL) isLaterThanDate: (NSDate *) aDate; //>
- (BOOL) isEarlierOrEqualDate: (NSDate *) aDate;//<=
- (BOOL) isEqualDate:(NSDate *)date;//=
- (BOOL) isLaterOrEqualDate: (NSDate *) aDate;//>=
- (BOOL) isInFuture;
- (BOOL) isInPast;

// Date roles
- (BOOL) isTypicallyWorkday;
- (BOOL) isTypicallyWeekend;

// Adjusting dates
- (NSDate *) dateByAddingDays: (NSInteger) dDays;
- (NSDate *) dateBySubtractingDays: (NSInteger) dDays;
- (NSDate *) dateByAddingHours: (NSInteger) dHours;
- (NSDate *) dateBySubtractingHours: (NSInteger) dHours;
- (NSDate *) dateByAddingMinutes: (NSInteger) dMinutes;
- (NSDate *) dateBySubtractingMinutes: (NSInteger) dMinutes;
- (NSDate *) dateAtStartOfDay;

// Retrieving intervals
- (NSInteger) minutesAfterDate: (NSDate *) aDate;
- (NSInteger) minutesBeforeDate: (NSDate *) aDate;
- (NSInteger) hoursAfterDate: (NSDate *) aDate;
- (NSInteger) hoursBeforeDate: (NSDate *) aDate;
- (NSInteger) daysAfterDate: (NSDate *) aDate;
- (NSInteger) daysBeforeDate: (NSDate *) aDate;
- (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate;

- (NSDate *) monthDateFromDate;
- (NSDate *) monthDayDateFromDate;

//上个月
- (NSDate *)lastMonth;

//下个月
- (NSDate *)nextMonth;

//当前月份的上个月
+ (NSDate *)lastMonth;

//当前月的下个月
+ (NSDate *)nextMonth;

//返回month月的总天数
+ (NSInteger)monthDays:(NSInteger)month
                  year:(NSInteger)year;

- (NSDate *)setYear:(NSInteger)year;

- (NSDate *)setDay:(NSInteger)day;

- (NSDate *)setMonth:(NSInteger)month;

- (NSDate *)setHour:(NSInteger)hour;

- (NSDate *)setMinute:(NSInteger)minute;

- (NSDate *)setSecond:(NSInteger)second;

- (NSDate *)setHour:(NSInteger)hour minute:(NSInteger)minute;

- (NSDate *)setHour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;

// Decomposing dates
@property (readonly) NSInteger nearestHour;
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger week;
@property (readonly) NSInteger weekday;
@property (readonly) NSInteger nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger year;

@end
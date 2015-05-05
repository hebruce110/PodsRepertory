//
//  PKDevice.m
//  PKDevice
//
//  Created by yuan on 14-5-22.
//  Copyright (c) 2014年 XXTSTUDIO. All rights reserved.
//

#import "VDevice.h"
#import <sys/utsname.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

@implementation VDevice

/*
 System Uptime: 2 Days 6 Hours 4 Minutes
 Device Model: iPhone
 Device Name: “patpat”的 iPhone6+
 System Name: iPhone OS
 System Version: 8.3
 System Device Type Unformatted: iPhone7,1
 System Device Type Formatted: (null)
 Screen Width: 414 Pixels
 Screen Height: 736 Pixels
 Screen Brightness: 100%
 Multitasking Enabled: Yes
 Jailbroken: No
 Charging: Yes
 Fully Charged: Yes
 Country: en_CN
 Language: en
 TimeZone: Asia/Shanghai
 Currency: CN¥
 Application Version: 1.3 ,build Version: 1211
 ClipBoard Content: "heyuan110@gmail.com"
 Carrier Name: 中国移动
 Carrier Country: CN
 Cell IP Address: (null)
 WiFi IP Address: 192.168.31.207
 Connected to WiFi: Yes
 Connected to Cell Network: No
 Memory (RAM): (±)1024.00 MB
 Used Memory: 755.13 MB 	74%
 Wired Memory: 244.69 MB 	24%
 Active Memory: 345.75 MB 	34%
 Inactive Memory: 164.69 MB 	16%
 Free Memory: 107.34 MB 	10%
 Purgeable Memory: 2.76 MB 	0%
 */

// Get all Harware Information
+ (NSString *)infos
{
    //启动时间
    NSArray *uptimeFormat = [[VDevice systemUptime] componentsSeparatedByString:@" "];
    NSString *systemUptime = [NSString stringWithFormat:@"System Uptime: %@ Days %@ Hours %@ Minutes", [uptimeFormat objectAtIndex:0], [uptimeFormat objectAtIndex:1], [uptimeFormat objectAtIndex:2]];
    NSString *deviceModel = [NSString stringWithFormat:@"Device Model: %@", [VDevice deviceModel]];
    NSString *deviceName = [NSString stringWithFormat:@"Device Name: %@", [VDevice deviceName]];
    NSString *systemName = [NSString stringWithFormat:@"System Name: %@", [VDevice systemName]];
    NSString *systemVersion = [NSString stringWithFormat:@"System Version: %@", [VDevice systemVersion]];
    NSString *systemDeviceTypeFormattedNO = [NSString stringWithFormat:@"System Device Type Unformatted: %@", [VDevice systemDeviceTypeFormatted:NO]];
    NSString *systemDeviceTypeFormattedYES = [NSString stringWithFormat:@"System Device Type Formatted: %@", [VDevice systemDeviceTypeFormatted:YES]];
    NSString *screenWidth = [NSString stringWithFormat:@"Screen Width: %d Pixels", [VDevice screenWidth]];
    NSString *screenHeight = [NSString stringWithFormat:@"Screen Height: %d Pixels", [VDevice screenHeight]];
    NSString *screenBrightness = [NSString stringWithFormat:@"Screen Brightness: %.0f%%", [VDevice screenBrightness]];
    NSString *multitaskingEnabled = ([VDevice multitaskingEnabled]) ? @"Multitasking Enabled: Yes" : @"Multitasking: No";
    NSString *jailbroken = ([VJailbreakCheck jailbroken] != NOTJAIL) ? @"Jailbroken: Yes" : @"Jailbroken: No";
    NSString *charging = ([VDevice charging]) ? @"Charging: Yes" : @"Charging: No";
    NSString *fullyCharged = ([VDevice fullyCharged]) ? @"Fully Charged: Yes" : @"Fully Charged: No";
    NSString *country = [NSString stringWithFormat:@"Country: %@", [VLocalization country]];
    NSString *language = [NSString stringWithFormat:@"Language: %@", [VLocalization language]];
    NSString *timeZone = [NSString stringWithFormat:@"TimeZone: %@", [VLocalization timeZone]];
    NSString *currency = [NSString stringWithFormat:@"Currency: %@", [VLocalization currency]];
    NSString *applicationVersion = [NSString stringWithFormat:@"Application Version: %@ ,build Version: %@", [VDevice applicationVersion],[VDevice buildVersion]];
    NSString *clipboardContent = [NSString stringWithFormat:@"ClipBoard Content: \"%@\"", [VDevice clipboardContent]];
    NSString *carrierName = [NSString stringWithFormat:@"Carrier Name: %@",[VDevice carrierName]];
    NSString *carrierCountry = [NSString stringWithFormat:@"Carrier Country: %@",[VDevice carrierCountry]];
    NSString *cellIPAddress = [NSString stringWithFormat:@"Cell IP Address: %@",[VNetwork cellIPAddress]];
    NSString *wiFiIPAddress = [NSString stringWithFormat:@"WiFi IP Address: %@",[VNetwork wiFiIPAddress]];
    NSString *connectedToWiFi = ([VNetwork connectedToWiFi]) ? @"Connected to WiFi: Yes" : @"Connected to WiFi: No";
    NSString *connectedToCellNetwork = ([VNetwork connectedToCellNetwork]) ? @"Connected to Cell Network: Yes" : @"Connected to Cell Network: No";
    NSString *totalMemory = [NSString stringWithFormat:@"Memory (RAM): (±)%.2f MB",[VMemoryInfo totalMemory]];
    // Used Memory
    NSString *usedMemory = [NSString stringWithFormat:@"Used Memory: %.2f MB \t%.0f%%", [VMemoryInfo usedMemory:NO], [VMemoryInfo usedMemory:YES]];
    NSString *wiredMemory = [NSString stringWithFormat:@"Wired Memory: %.2f MB \t%.0f%%", [VMemoryInfo wiredMemory:NO], [VMemoryInfo wiredMemory:YES]];// Wired Memory
    NSString *activeMemory = [NSString stringWithFormat:@"Active Memory: %.2f MB \t%.0f%%", [VMemoryInfo activeMemory:NO], [VMemoryInfo activeMemory:YES]];// Active Memory
    NSString *inactiveMemory = [NSString stringWithFormat:@"Inactive Memory: %.2f MB \t%.0f%%", [VMemoryInfo inactiveMemory:NO], [VMemoryInfo inactiveMemory:YES]];// Inactive Memory
    NSString *freeMemory = [NSString stringWithFormat:@"Free Memory: %.2f MB \t%.0f%%", [VMemoryInfo freeMemory:NO], [VMemoryInfo freeMemory:YES]]; // Free Memory
    NSString *purgableMemory = [NSString stringWithFormat:@"Purgeable Memory: %.2f MB \t%.0f%%", [VMemoryInfo purgableMemory:NO], [VMemoryInfo purgableMemory:YES]];// Purgeable Memory
    NSArray *infoArrays = [NSArray arrayWithObjects:systemUptime,deviceModel,deviceName,
                           systemName,systemVersion,systemDeviceTypeFormattedNO,
                           systemDeviceTypeFormattedYES,screenWidth,
                           screenHeight,screenBrightness,multitaskingEnabled,
                           jailbroken,charging,fullyCharged,
                           country,language,timeZone,
                           currency,applicationVersion,clipboardContent,
                           carrierName,carrierCountry,cellIPAddress,
                           wiFiIPAddress,connectedToWiFi,connectedToCellNetwork,
                           totalMemory,usedMemory,wiredMemory,
                           activeMemory,inactiveMemory,freeMemory,purgableMemory,nil];
    NSString *infos = [infoArrays componentsJoinedByString:@"\n"];
    return infos;
}

+ (NSString *)country
{
    return [VLocalization country];
}

+ (NSString *)currency
{
   return [VLocalization currency];
}


+ (NSString *)language
{
    return [VLocalization language];
}

+ (NSString *)timeZone
{
    return [VLocalization timeZone];
}


+ (BOOL)isJailbroken
{
    return ([VJailbreakCheck jailbroken] != NOTJAIL);
}


+ (NSString *)deviceType
{
    return [VDevice systemDeviceTypeFormatted:NO];
}

+ (NSString *)screenSize
{
    return [NSString stringWithFormat:@"%d:%d", [VDevice screenWidth], [VDevice screenHeight]];
}

// System Hardware Information

// System Uptime (dd hh mm)
+ (NSString *)systemUptime {
    // Set up the days/hours/minutes
    NSNumber *Days, *Hours, *Minutes;
    
    // Get the info about a process
    NSProcessInfo * processInfo = [NSProcessInfo processInfo];
	// Get the uptime of the system
    NSTimeInterval UptimeInterval = [processInfo systemUptime];
	// Get the calendar
    NSCalendar *Calendar = [NSCalendar currentCalendar];
	// Create the Dates
    NSDate *Date = [[NSDate alloc] initWithTimeIntervalSinceNow:(0-UptimeInterval)];
    unsigned int unitFlags = NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit;
    NSDateComponents *Components = [Calendar components:unitFlags fromDate:Date toDate:[NSDate date]  options:0];
	
    // Get the day, hour and minutes
    Days = [NSNumber numberWithInt:[Components day]];
    Hours = [NSNumber numberWithInt:[Components hour]];
    Minutes = [NSNumber numberWithInt:[Components minute]];
	
    // Format the dates
	NSString *Uptime = [NSString stringWithFormat:@"%@ %@ %@",
                        [Days stringValue],
                        [Hours stringValue],
                        [Minutes stringValue]];
    
    // Error checking
    if (!Uptime) {
        // No uptime found
        // Return nil
        return nil;
    }
    
    // Return the uptime
    return Uptime;
}

// Model of Device
+ (NSString *)deviceModel {
    // Get the device model
    if ([[UIDevice currentDevice] respondsToSelector:@selector(model)]) {
        // Make a string for the device model
        NSString *deviceModel = [[UIDevice currentDevice] model];
        // Set the output to the device model
        return deviceModel;
    } else {
        // Device model not found
        return nil;
    }
}

// Device Name
+ (NSString *)deviceName {
    // Get the current device name
    if ([[UIDevice currentDevice] respondsToSelector:@selector(name)]) {
        // Make a string for the device name
        NSString *deviceName = [[UIDevice currentDevice] name];
        // Set the output to the device name
        return deviceName;
    } else {
        // Device name not found
        return nil;
    }
}

// System Name
+ (NSString *)systemName {
    // Get the current system name
    if ([[UIDevice currentDevice] respondsToSelector:@selector(systemName)]) {
        // Make a string for the system name
        NSString *systemName = [[UIDevice currentDevice] systemName];
        // Set the output to the system name
        return systemName;
    } else {
        // System name not found
        return nil;
    }
}

// System Version
+ (NSString *)systemVersion {
    // Get the current system version
    if ([[UIDevice currentDevice] respondsToSelector:@selector(systemVersion)]) {
        // Make a string for the system version
        NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
        // Set the output to the system version
        return systemVersion;
    } else {
        // System version not found
        return nil;
    }
}

// System Device Type (iPhone1,0) (Formatted = iPhone 1)
+ (NSString *)systemDeviceTypeFormatted:(BOOL)formatted {
    // Set up a Device Type String
    NSString *DeviceType;
    
    // Check if it should be formatted
    if (formatted) {
        // Formatted
        @try {
            // Set up a new Device Type String
            NSString *NewDeviceType;
            // Set up a struct
            struct utsname DT;
            // Get the system information
            uname(&DT);
            // Set the device type to the machine type
            DeviceType = [NSString stringWithFormat:@"%s", DT.machine];
            
            if ([DeviceType isEqualToString:@"i386"])
                NewDeviceType = @"iPhone Simulator";
            else if ([DeviceType isEqualToString:@"iPhone1,1"])
                NewDeviceType = @"iPhone";
            else if ([DeviceType isEqualToString:@"iPhone1,2"])
                NewDeviceType = @"iPhone 3G";
            else if ([DeviceType isEqualToString:@"iPhone2,1"])
                NewDeviceType = @"iPhone 3GS";
            else if ([DeviceType isEqualToString:@"iPhone3,1"])
                NewDeviceType = @"iPhone 4";
            else if ([DeviceType isEqualToString:@"iPhone4,1"])
                NewDeviceType = @"iPhone 4S";
            else if ([DeviceType isEqualToString:@"iPhone5,1"])
                NewDeviceType = @"iPhone 5";
            else if ([DeviceType isEqualToString:@"iPhone5,2"])
                NewDeviceType = @"iPhone 5";
            else if ([DeviceType isEqualToString:@"iPod1,1"])
                NewDeviceType = @"1st Gen iPod";
            else if ([DeviceType isEqualToString:@"iPod2,1"])
                NewDeviceType = @"2nd Gen iPod";
            else if ([DeviceType isEqualToString:@"iPod3,1"])
                NewDeviceType = @"3rd Gen iPod";
            else if ([DeviceType isEqualToString:@"iPad1,1"])
                NewDeviceType = @"iPad";
            else if ([DeviceType isEqualToString:@"iPad2,2"])
                NewDeviceType = @"iPad 2";
            else if ([DeviceType isEqualToString:@"iPad3,3"])
                NewDeviceType = @"New iPad";
            else if ([DeviceType isEqualToString:@"iPad4,4"])
                NewDeviceType = @"iPad 4";
            else if ([DeviceType hasPrefix:@"iPad"])
                NewDeviceType = @"iPad";
            
            // Return the new device type
            return NewDeviceType;
        }
        @catch (NSException *exception) {
            // Error
            return nil;
        }
    } else {
        // Unformatted
        @try {
            // Set up a struct
            struct utsname DT;
            // Get the system information
            uname(&DT);
            // Set the device type to the machine type
            DeviceType = [NSString stringWithFormat:@"%s", DT.machine];
            
            // Return the device type
            return DeviceType;
        }
        @catch (NSException *exception) {
            // Error
            return nil;
        }
    }
}

// Get the Screen Width (X)
+ (NSInteger)screenWidth {
    // Get the screen width
    @try {
        // Screen bounds
        CGRect Rect = [[UIScreen mainScreen] bounds];
        // Find the width (X)
        NSInteger Width = Rect.size.width;
        // Verify validity
        if (Width <= 0) {
            // Invalid Width
            return -1;
        }
        
        // Successful
        return Width;
    }
    @catch (NSException *exception) {
        // Error
        return -1;
    }
}

// Get the Screen Height (Y)
+ (NSInteger)screenHeight {
    // Get the screen height
    @try {
        // Screen bounds
        CGRect Rect = [[UIScreen mainScreen] bounds];
        // Find the Height (Y)
        NSInteger Height = Rect.size.height;
        // Verify validity
        if (Height <= 0) {
            // Invalid Height
            return -1;
        }
        
        // Successful
        return Height;
    }
    @catch (NSException *exception) {
        // Error
        return -1;
    }
}

// Get the Screen Brightness
+ (float)screenBrightness {
    // Get the screen brightness
    @try {
        // Brightness
        float brightness = [UIScreen mainScreen].brightness;
        // Verify validity
        if (brightness < 0.0 || brightness > 1.0) {
            // Invalid brightness
            return -1;
        }
        
        // Successful
        return (brightness * 100);
    }
    @catch (NSException *exception) {
        // Error
        return -1;
    }
}

// Multitasking enabled?
+ (BOOL)multitaskingEnabled {
    // Is multitasking enabled?
    if ([[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)]) {
        // Create a bool
        BOOL MultitaskingSupported = [UIDevice currentDevice].multitaskingSupported;
        // Return the value
        return MultitaskingSupported;
    } else {
        // Doesn't respond to selector
        return false;
    }
}

// Battery Information

// Battery Level
+ (float)batteryLevel {
    // Find the battery level
    @try {
        // Get the device
        UIDevice *Device = [UIDevice currentDevice];
        // Set battery monitoring on
        Device.batteryMonitoringEnabled = YES;
        
        // Set up the battery level float
        float BatteryLevel = 0.0;
        // Get the battery level
        float BatteryCharge = [Device batteryLevel];
        
        // Check to make sure the battery level is more than zero
        if (BatteryCharge > 0.0f) {
            // Make the battery level float equal to the charge * 100
            BatteryLevel = BatteryCharge * 100;
        } else {
            // Unable to find the battery level
            return -1;
        }
        
        // Output the battery level
        return BatteryLevel;
    }
    @catch (NSException *exception) {
        // Error out
        return -1;
    }
}

// Charging?
+ (BOOL)charging {
    // Is the battery charging?
    @try {
        // Get the device
        UIDevice *Device = [UIDevice currentDevice];
        // Set battery monitoring on
        Device.batteryMonitoringEnabled = YES;
        
        // Check the battery state
        if ([Device batteryState] == UIDeviceBatteryStateCharging || [Device batteryState] == UIDeviceBatteryStateFull) {
            // Device is charging
            return true;
        } else {
            // Device is not charging
            return false;
        }
    }
    @catch (NSException *exception) {
        // Error out
        return false;
    }
}

// Fully Charged?
+ (BOOL)fullyCharged {
    // Is the battery fully charged?
    @try {
        // Get the device
        UIDevice *Device = [UIDevice currentDevice];
        // Set battery monitoring on
        Device.batteryMonitoringEnabled = YES;
        
        // Check the battery state
        if ([Device batteryState] == UIDeviceBatteryStateFull) {
            // Device is fully charged
            return true;
        } else {
            // Device is not fully charged
            return false;
        }
    }
    @catch (NSException *exception) {
        // Error out
        return false;
    }
}

// Application Information

// Application Version
+ (NSString *)applicationVersion {
    // Get the Application Version Number
    @try {
        // Query the plist for the version
        NSString *Version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        // Validate the Version
        if (Version == nil || Version.length <= 0) {
            // Invalid Version number
            return nil;
        }
        // Successful
        return Version;
    }
    @catch (NSException *exception) {
        // Error
        return nil;
    }
}

+ (NSString *)buildVersion {
    @try {
        // Query the plist for the version
        NSString *Version = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
        // Validate the Version
        if (Version == nil || Version.length <= 0) {
            // Invalid Version number
            return nil;
        }
        // Successful
        return Version;
    }
    @catch (NSException *exception) {
        // Error
        return nil;
    }
}


#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]


// Clipboard Content
+ (NSString *)clipboardContent {
    // Get the string content of the clipboard (copy, paste)
    @try {
        // Get the Pasteboard
        UIPasteboard *PasteBoard = [UIPasteboard generalPasteboard];
        // Get the string value of the pasteboard
        NSString *ClipboardContent = [PasteBoard string];
        // Check for validity
        if (ClipboardContent == nil || ClipboardContent.length <= 0) {
            // Error, invalid pasteboard
            return nil;
        }
        // Successful
        return ClipboardContent;
    }
    @catch (NSException *exception) {
        // Error
        return nil;
    }
}

// Carrier Information

// Carrier Name
+ (NSString *)carrierName {
    // Get the carrier name
    @try {
        // Get the Telephony Network Info
        CTTelephonyNetworkInfo *TelephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
        // Get the carrier
        CTCarrier *Carrier = [TelephonyInfo subscriberCellularProvider];
        // Get the carrier name
        NSString *CarrierName = [Carrier carrierName];
        
        // Check to make sure it's valid
        if (CarrierName == nil || CarrierName.length <= 0) {
            // Return unknown
            return nil;
        }
        
        // Return the name
        return CarrierName;
    }
    @catch (NSException *exception) {
        // Error finding the name
        return nil;
    }
}

// Carrier Country
+ (NSString *)carrierCountry {
    // Get the country that the carrier is located in
    @try {
        // Get the locale
        NSLocale *CurrentCountry = [NSLocale currentLocale];
        // Get the country Code
        NSString *Country = [CurrentCountry objectForKey:NSLocaleCountryCode];
        // Check if it returned anything
        if (Country == nil || Country.length <= 0) {
            // No country found
            return nil;
        }
        // Return the country
        return Country;
    }
    @catch (NSException *exception) {
        // Failed, return nil
        return nil;
    }
}


@end























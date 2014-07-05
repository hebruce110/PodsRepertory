//
//  PKJailbreakCheck.h
//  PKDevice
//
//  Created by yuan on 14-5-22.
//  Copyright (c) 2014年 XXTSTUDIO. All rights reserved.
//

#import <Foundation/Foundation.h>

/* Jailbreak Check Definitions */

#define NOTJAIL 4783242

// Failed jailbroken checks
enum {
    // Failed the Jailbreak Check
    KFJailbroken = 3429542,
    // Failed the OpenURL Check
    KFOpenURL = 321,
    // Failed the Cydia Check
    KFCydia = 432,
    // Failed the Inaccessible Files Check
    KFIFC = 47293,
    // Failed the plist check
    KFPlist = 9412,
    // Failed the Processes Check with Cydia
    KFProcessesCydia = 10012,
    // Failed the Processes Check with other Cydia
    KFProcessesOtherCydia = 42932,
    // Failed the Processes Check with other other Cydia
    KFProcessesOtherOCydia = 10013,
    // Failed the FSTab Check
    KFFSTab = 9620,
    // Failed the System() Check
    KFSystem = 47475,
    // Failed the Symbolic Link Check
    KFSymbolic = 34859,
    // Failed the File Exists Check
    KFFileExists = 6625,
} JailbrokenChecks;

// Define the filesystem check
#define FILECHECK [NSFileManager defaultManager] fileExistsAtPath:
// Define the exe path
#define EXEPATH [[NSBundle mainBundle] executablePath]
// Define the plist path
#define PLISTPATH [[NSBundle mainBundle] infoDictionary]

// Jailbreak Check Definitions
#define CYDIA       @"MobileCydia"
#define OTHERCYDIA  @"Cydia"
#define OOCYDIA     @"afpd"
#define CYDIAPACKAGE    @"cydia://package/com.fake.package"
#define CYDIALOC        @"/Applications/Cydia.app"
#define HIDDENFILES     [NSArray arrayWithObjects:@"/Applications/RockApp.app",@"/Applications/Icy.app",@"/usr/sbin/sshd",@"/usr/bin/sshd",@"/usr/libexec/sftp-server",@"/Applications/WinterBoard.app",@"/Applications/SBSettings.app",@"/Applications/MxTube.app",@"/Applications/IntelliScreen.app",@"/Library/MobileSubstrate/DynamicLibraries/Veency.plist",@"/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",@"/private/var/lib/apt",@"/private/var/stash",@"/System/Library/LaunchDaemons/com.ikey.bbot.plist",@"/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",@"/private/var/tmp/cydia.log",@"/private/var/lib/cydia", @"/etc/clutch.conf", @"/var/cache/clutch.plist", @"/etc/clutch_cracked.plist", @"/var/cache/clutch_cracked.plist", @"/var/lib/clutch/overdrive.dylib", @"/var/root/Documents/Cracked/", nil]

/* End Jailbreak Definitions */


@interface VJailbreakCheck : NSObject

// Jailbreak Check

// Jailbroken?
+ (int)jailbroken;

@end

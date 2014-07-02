//
//  PKNetwork.m
//  PKDevice
//
//  Created by yuan on 14-5-22.
//  Copyright (c) 2014年 XXTSTUDIO. All rights reserved.
//

#import "VNetwork.h"
#import <ifaddrs.h>
#include <sys/socket.h>
#import <arpa/inet.h>

@implementation VNetwork

// Get WiFi IP Address
+ (NSString *)wiFiIPAddress {
    // Get the WiFi IP Address
    @try {
        // Set a string for the address
        NSString *IPAddress;
        // Set up structs to hold the interfaces and the temporary address
        struct ifaddrs *Interfaces;
        struct ifaddrs *Temp;
        // Set up int for success or fail
        int Status = 0;
        
        // Get all the network interfaces
        Status = getifaddrs(&Interfaces);
        
        // If it's 0, then it's good
        if (Status == 0)
        {
            // Loop through the list of interfaces
            Temp = Interfaces;
            
            // Run through it while it's still available
            while(Temp != NULL)
            {
                // If the temp interface is a valid interface
                if(Temp->ifa_addr->sa_family == AF_INET)
                {
                    // Check if the interface is WiFi
                    if([[NSString stringWithUTF8String:Temp->ifa_name] isEqualToString:@"en0"])
                    {
                        // Get the WiFi IP Address
                        IPAddress = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)Temp->ifa_addr)->sin_addr)];
                    }
                }
                
                // Set the temp value to the next interface
                Temp = Temp->ifa_next;
            }
        }
        
        // Free the memory of the interfaces
        freeifaddrs(Interfaces);
        
        // Check to make sure it's not empty
        if (IPAddress == nil || IPAddress.length <= 0) {
            // Empty, return not found
            return nil;
        }
        
        // Return the IP Address of the WiFi
        return IPAddress;
    }
    @catch (NSException *exception) {
        // Error, IP Not found
        return nil;
    }
}


// Get Cell IP Address
+ (NSString *)cellIPAddress {
    // Get the Cell IP Address
    @try {
        // Set a string for the address
        NSString *IPAddress;
        // Set up structs to hold the interfaces and the temporary address
        struct ifaddrs *Interfaces;
        struct ifaddrs *Temp;
        struct sockaddr_in *s4;
        char buf[64];
        
        // If it's 0, then it's good
        if (!getifaddrs(&Interfaces))
        {
            // Loop through the list of interfaces
            Temp = Interfaces;
            
            // Run through it while it's still available
            while(Temp != NULL)
            {
                // If the temp interface is a valid interface
                if(Temp->ifa_addr->sa_family == AF_INET)
                {
                    // Check if the interface is Cell
                    if([[NSString stringWithUTF8String:Temp->ifa_name] isEqualToString:@"pdp_ip0"])
                    {
                        s4 = (struct sockaddr_in *)Temp->ifa_addr;
                        
                        if (inet_ntop(Temp->ifa_addr->sa_family, (void *)&(s4->sin_addr), buf, sizeof(buf)) == NULL) {
                            // Failed to find it
                            IPAddress = nil;
                        } else {
                            // Got the Cell IP Address
                            IPAddress = [NSString stringWithUTF8String:buf];
                        }
                    }
                }
                
                // Set the temp value to the next interface
                Temp = Temp->ifa_next;
            }
        }
        
        // Free the memory of the interfaces
        freeifaddrs(Interfaces);
        
        // Check to make sure it's not empty
        if (IPAddress == nil || IPAddress.length <= 0) {
            // Empty, return not found
            return nil;
        }
        
        // Return the IP Address of the WiFi
        return IPAddress;
    }
    @catch (NSException *exception) {
        // Error, IP Not found
        return nil;
    }
}

// Connected to WiFi?
+ (BOOL)connectedToWiFi {
    // Check if we're connected to WiFi
    NSString *WiFiAddress = [self wiFiIPAddress];
    // Check if the string is populated
    if (WiFiAddress == nil || WiFiAddress.length <= 0) {
        // Nothing found
        return false;
    } else {
        // WiFi in use
        return true;
    }
}

// Connected to Cellular Network?
+ (BOOL)connectedToCellNetwork {
    // Check if we're connected to cell network
    NSString *CellAddress = [self cellIPAddress];
    // Check if the string is populated
    if (CellAddress == nil || CellAddress.length <= 0) {
        // Nothing found
        return false;
    } else {
        // Cellular Network in use
        return true;
    }
}

@end

//
//  DeviceUtils.m
//  securityguards
//
//  Created by Zhao yang on 1/6/14.
//  Copyright (c) 2014 hentre. All rights reserved.
//

#import "DeviceUtils.h"

@implementation DeviceUtils

+ (NSMutableArray *)operationsListFor:(Device *)device {
    NSMutableArray *operations = [NSMutableArray array];
    if(device.isAirPurifierPower) {
       
    } else if(device.isAirPurifierLevel) {
        [operations addObject:[[DeviceOperationItem alloc] initWithDisplayName:NSLocalizedString(@"high_level", @"") andCommandString:@""]];
        [operations addObject:[[DeviceOperationItem alloc] initWithDisplayName:NSLocalizedString(@"medium_level", @"") andCommandString:@""]];
        [operations addObject:[[DeviceOperationItem alloc] initWithDisplayName:NSLocalizedString(@"low_level", @"") andCommandString:@""]];
    } else if(device.isAirPurifierModeControl) {
        [operations addObject:[[DeviceOperationItem alloc] initWithDisplayName:NSLocalizedString(@"device_automatic", @"") andCommandString:@""]];
        [operations addObject:[[DeviceOperationItem alloc] initWithDisplayName:NSLocalizedString(@"device_manual", @"") andCommandString:@""]];
    } else if(device.isAirPurifierSecurity) {
        [operations addObject:[[DeviceOperationItem alloc] initWithDisplayName:NSLocalizedString(@"device_open", @"") andCommandString:@""]];
        [operations addObject:[[DeviceOperationItem alloc] initWithDisplayName:NSLocalizedString(@"device_close", @"") andCommandString:@""]];
    }
    return operations;
}

+ (NSString *)stateAsStringFor:(Device *)device {
    if(device == nil) return [XXStringUtils emptyString];
    if(device.isAirPurifierPower) {
        
    } else if(device.isAirPurifierLevel) {
        
    } else if(device.isAirPurifierSecurity) {
        
    } else if(device.isAirPurifierModeControl) {
        
    }
    return [XXStringUtils emptyString];
}

+ (void)executeOperationItem:(DeviceOperationItem *)operationItem {
    if(operationItem == nil) return;
}

@end

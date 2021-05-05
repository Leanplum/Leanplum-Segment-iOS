//
//  SEGLeanplumIntegration.m
//  Leanplum Segment iOS Integration
//
//  Copyright (c) 2020 Leanplum. All rights reserved.
//

#import "SEGLeanplumIntegration.h"

@implementation SEGLeanplumIntegration

- (instancetype)initWithSettings:(NSDictionary *)settings
{
    if (self = [super init]) {
        NSString *appId = [settings objectForKey:@"appId"];
        NSString *token = [settings objectForKey:@"clientKey"];
        bool isDevelopmentMode = [[settings objectForKey:@"devMode"] boolValue];

        if (!appId || appId.length == 0) {
            @throw([NSException
                exceptionWithName:@"Leanplum Error"
                           reason:[NSString
                                      stringWithFormat:@"Leanplum: Please add "
                                                       @"Leanplum app id in "
                                                       @"Segment settings."]
                         userInfo:nil]);
        }
        if (!token || token.length == 0) {
            @throw([NSException
                exceptionWithName:@"Leanplum Error"
                           reason:[NSString
                                      stringWithFormat:@"Leanplum: Please add "
                                                       @"Leanplum client key "
                                                       @"in Segment settings."]
                         userInfo:nil]);
        }

        if (isDevelopmentMode) {
            [Leanplum setAppId:appId withDevelopmentKey:token];
        } else {
            [Leanplum setAppId:appId withProductionKey:token];
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            @try {
                [Leanplum start];
            } @catch (NSException *exception) {
                NSLog(@"Leanplum Integration Error: Unable to start."
                      @"Error: %@", exception);
            }
        });
    }
    return self;
}

- (void)identify:(SEGIdentifyPayload *)payload
{
    dispatch_async(dispatch_get_main_queue(), ^{
        @try {
            [Leanplum setUserId:payload.userId withUserAttributes:payload.traits];
        } @catch (NSException *exception) {
            NSLog(@"Leanplum Integration Error: Unable to set userId with userAttributes."
                  @"Error: %@", exception);
        }
    });
}

- (void)track:(SEGTrackPayload *)payload
{
    dispatch_async(dispatch_get_main_queue(), ^{
        // Since Leanplum has value field that can be associated with any event,
        // we have to extract that field from Segment and send it with our event as a value.
        @try {
            if ([payload.properties objectForKey:@"value"])
            {
                id valueObject = [payload.properties objectForKey:@"value"];
                if ([valueObject isKindOfClass:[NSNumber class]])
                {
                    double value = [valueObject doubleValue];
                    [Leanplum track:payload.event withValue:value andParameters:payload.properties];
                }
                else {
                    [Leanplum track:payload.event withParameters:payload.properties];
                }
            }
            else {
                [Leanplum track:payload.event withParameters:payload.properties];
            }
        } @catch (NSException *exception) {
            NSLog(@"Leanplum Integration Error: Unable to track event. %@",
                  exception);
        }
    });
}

- (void)screen:(SEGScreenPayload *)payload
{
    dispatch_async(dispatch_get_main_queue(), ^{
        @try {
            [Leanplum advanceTo:payload.name withParameters:payload.properties];
        } @catch (NSException *exception) {
            NSLog(@"Leanplum Integration Error: Unable to screen event. %@",
                  exception);
        }
    });
}

- (void)flush
{
    // Not Implemented.
    // Segment batching works based on the number of events and can send each event separately.
    // Leanplum batching based on time and is tight to billing.
}

@end

//
//  SEGLeanplumIntegrationFactory.h
//  Leanplum Segment iOS Integration Version 1.1.4
//
//  Copyright (c) 2020 Leanplum. All rights reserved.
//

#import "SEGLeanplumIntegration.h"

NS_SWIFT_NAME(SegmentLeanplumIntegrationFactory)
@interface SEGLeanplumIntegrationFactory : NSObject <SEGIntegrationFactory>

extern NSString *LPLeanplumSegmentKey;

+ (SEGLeanplumIntegrationFactory *)instance;
- (SEGLeanplumIntegration *)createWithSettings:(NSDictionary *)settings
                                  forAnalytics:(SEGAnalytics *)analytics;
- (NSString *)key;

@end

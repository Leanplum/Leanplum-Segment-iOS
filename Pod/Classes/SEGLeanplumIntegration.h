//
//  SEGLeanplumIntegration.h
//  Leanplum Segment iOS Integration Version 1.1.4
//
//  Copyright (c) 2020 Leanplum. All rights reserved.
//

@import Leanplum;
@import Segment;
#import <Foundation/Foundation.h>

@interface SEGLeanplumIntegration : NSObject <SEGIntegration>

- (instancetype)initWithSettings:(NSDictionary *)settings;

@end

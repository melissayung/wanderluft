//
//  Service.h
//  wanderluft
//
//  Created by Melissa Yung on 13/12/14.
//  Copyright (c) 2014 Travelling Mesh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

static NSString * const BaseURLString = @"http://10.1.128.91:8000";

@interface Service : NSObject

+ (Service *)service;
- (void)getInspirationsSuccess:(void(^)(id jsonObject))success failure:(void(^)())failure;

@end

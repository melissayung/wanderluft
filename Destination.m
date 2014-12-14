//
//  Destination.m
//  wanderluft
//
//  Created by Melissa Yung on 13/12/14.
//  Copyright (c) 2014 Travelling Mesh. All rights reserved.
//

#import "Destination.h"

@implementation Destination

+ (Destination *)destinationWithDict:(NSDictionary *)dict {
    return [[Destination alloc] initWithDict:dict];
}

- (id)initWithDict:(NSDictionary *)dict {
    
    if ((self = [super init])) {
//        self.weather = dict[@"weather"];
        self.locationName  = dict[@"locationName"];
        self.temperature = dict[@"temperature"];
    }
    return self;
}

@end

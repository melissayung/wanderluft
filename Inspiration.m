//
//  Inspiration.m
//  wanderluft
//
//  Created by Melissa Yung on 13/12/14.
//  Copyright (c) 2014 Travelling Mesh. All rights reserved.
//

#import "Inspiration.h"
#import "Destination.h"
#import "Flight.h"

@implementation Inspiration

+ (Inspiration *)inspirationWithDict:(NSDictionary *)dict {
    return [[Inspiration alloc] initWithDict:dict];
}

- (id)initWithDict:(NSDictionary *)dict {
    
    if ((self = [super init])) {
        self.pictureURL = dict[@"pictureURL"];
        self.destination  = [Destination destinationWithDict:dict[@"destinationDetails"]];
        self.flight = [Flight flightWithDict:dict[@"flightDetails"]];
    }
    return self;
}

@end

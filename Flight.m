//
//  Flight.m
//  wanderluft
//
//  Created by Melissa Yung on 13/12/14.
//  Copyright (c) 2014 Travelling Mesh. All rights reserved.
//

#import "Flight.h"

@implementation Flight

+ (Flight *)flightWithDict:(NSDictionary *)dict {
    return [[Flight alloc] initWithDict:dict];
}

- (id)initWithDict:(NSDictionary *)dict {
    
    if ((self = [super init])) {
        self.departureDate = dict[@"departureDate"];
        self.returnDate  = dict[@"returnDate"];
        self.journeyDuration = dict[@"journeyDuration"];
        self.destionationAirport  = dict[@"destinationAirport"];
        self.price = dict[@"price"];
        self.bookingURL = dict[@"bookingURL"];
    }
    return self;
}

@end

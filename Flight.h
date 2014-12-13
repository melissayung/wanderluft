//
//  Flight.h
//  wanderluft
//
//  Created by Melissa Yung on 13/12/14.
//  Copyright (c) 2014 Travelling Mesh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Flight : NSObject

+ (Flight *)flightWithDict:(NSDictionary *)dict;

@property (nonatomic) NSString *departureDate;
@property (nonatomic) NSString *returnDate;
@property (nonatomic) NSString *journeyDuration;
@property (nonatomic) NSString *destionationAirport;
@property (nonatomic) NSString *price;

@end

//
//  Destination.h
//  wanderluft
//
//  Created by Melissa Yung on 13/12/14.
//  Copyright (c) 2014 Travelling Mesh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Destination : NSObject

+ (Destination *)destinationWithDict:(NSDictionary *)dict;

@property (nonatomic) NSString *weather;
@property (nonatomic) NSString *locationName;
@property (nonatomic) NSString *temperature;

@end

//
//  Inspiration.h
//  wanderluft
//
//  Created by Melissa Yung on 13/12/14.
//  Copyright (c) 2014 Travelling Mesh. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Flight;
@class Destination;

@interface Inspiration : NSObject

+ (Inspiration *)inspirationWithDict:(NSDictionary *)dict;

@property (nonatomic) NSString *pictureURL;
@property (nonatomic) Destination *destination;
@property (nonatomic) Flight *flight;

@end

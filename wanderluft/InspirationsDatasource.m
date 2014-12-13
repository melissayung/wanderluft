//
//  InspirationsDatasource.m
//  wanderluft
//
//  Created by Melissa Yung on 13/12/14.
//  Copyright (c) 2014 Travelling Mesh. All rights reserved.
//

#import "InspirationsDatasource.h"
#import "Inspiration.h"

@implementation InspirationsDatasource

- (void)fetchPictures {
    NSData *jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pictures" ofType:@"json"]];
    if(!jsonData) {
        NSLog(@"json not found");
        return;
    }
    id parsedData = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    id responseObjects = [parsedData objectForKey:@"response"];
    if(responseObjects && [responseObjects isKindOfClass:[NSArray class]]) {
        NSMutableArray *list = [[NSMutableArray alloc] init];
        NSArray *dictionaries = responseObjects;
        for(NSDictionary *dict in dictionaries) {
            [list addObject:[Inspiration inspirationWithDict:dict]];
        }
        self.inspirations = [NSArray arrayWithArray:list];
    }
    NSLog(@"Could not parse json :(");
}

- (NSArray *)collectionViewData {
    return self.inspirations;
}

@end

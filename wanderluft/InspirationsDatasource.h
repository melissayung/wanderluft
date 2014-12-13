//
//  InspirationsDatasource.h
//  wanderluft
//
//  Created by Melissa Yung on 13/12/14.
//  Copyright (c) 2014 Travelling Mesh. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol InspirationsDatasourceDelegate <NSObject>
- (void)datasourceDataChanged;
@end

@interface InspirationsDatasource : NSObject

@property (nonatomic) id<InspirationsDatasourceDelegate> delegate;
@property (nonatomic) NSArray *inspirations;

- (NSArray *)collectionViewData;

@end

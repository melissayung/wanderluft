//
//  InspirationCVCell.h
//  wanderluft
//
//  Created by Melissa Yung on 13/12/14.
//  Copyright (c) 2014 Travelling Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Inspiration;

static NSString *InspirationCVCellIdentifier = @"InspirationCVCell";

@interface InspirationCVCell : UICollectionViewCell

- (void)updateCellView;

@property (nonatomic) Inspiration *data;
@property (weak, nonatomic) IBOutlet UIView *flightDetailBackgroundView;

@end

//
//  FirstViewController.h
//  wanderluft
//
//  Created by Melissa Yung on 13/12/14.
//  Copyright (c) 2014 Travelling Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InspirationsVC : UIViewController

@property (weak, nonatomic) IBOutlet UICollectionView *inspirationsCV;
@property (weak, nonatomic) IBOutlet UIButton *infoButton;
@property (weak, nonatomic) IBOutlet UIButton *bookButton;
@property (weak, nonatomic) IBOutlet UIButton *addToWishlistButton;

@property (nonatomic) NSArray *inspirations;

@end


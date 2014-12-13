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
@property (nonatomic) NSArray *inspirations;

@end


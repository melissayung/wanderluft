//
//  InspirationCVCell.m
//  wanderluft
//
//  Created by Melissa Yung on 13/12/14.
//  Copyright (c) 2014 Travelling Mesh. All rights reserved.
//

#import "InspirationCVCell.h"
#import "Inspiration.h"
#import "Destination.h"
#import "Flight.h"

@interface InspirationCVCell()

@property (weak, nonatomic) IBOutlet UIImageView *cityPictureImageView;
@property (weak, nonatomic) IBOutlet UILabel *weather;

@end

@implementation InspirationCVCell

- (void)awakeFromNib {

}

- (void)updateCellView {
    
    UIView *topBarBgView = [[UIView alloc] init];
    [topBarBgView setFrame:CGRectMake(0, self.cityNameLabel.frame.origin.y, [UIScreen mainScreen].bounds.size.width, self.cityNameLabel.frame.size.height)];
    topBarBgView.alpha = .5;
    topBarBgView.backgroundColor = [UIColor whiteColor];
    [self.contentView insertSubview:topBarBgView atIndex:1];
    
#ifdef TEST
    NSURL *localFileURL = [[NSBundle mainBundle] URLForResource:self.data.pictureURL withExtension:@"jpg"];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:localFileURL]];
#else
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.data.pictureURL]]];
#endif
    [self.cityPictureImageView setImage:image];
    self.cityNameLabel.text = self.data.destination.locationName;
//    self.weather.text = self.data.destination.weather;
}



@end

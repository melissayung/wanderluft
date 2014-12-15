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
#import "FXBlurView.h"

@interface InspirationCVCell()

@property (weak, nonatomic) IBOutlet UIImageView *cityPictureImageView;
@property (weak, nonatomic) IBOutlet UILabel *flightNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *departureDetailsLabel;
@property (weak, nonatomic) IBOutlet UILabel *returnDetailsLabel;
@property (weak, nonatomic) IBOutlet UILabel *costLabel;
@property (weak, nonatomic) IBOutlet UILabel *duration;
@property (weak, nonatomic) IBOutlet UILabel *weather;

@end

@implementation InspirationCVCell

- (void)awakeFromNib {

}

- (void)updateCellView {
    
    FXBlurView *blurView = [[FXBlurView alloc] init];
    [blurView setFrame:CGRectMake(0, self.cityNameLabel.frame.origin.y, [UIScreen mainScreen].bounds.size.width, self.cityNameLabel.frame.size.height)];
    blurView.blurRadius = 40.0;
    blurView.tintColor = [UIColor clearColor];

    [self.contentView insertSubview:blurView atIndex:1];
    
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.data.pictureURL]]];
    [self.cityPictureImageView setImage:image];
    self.cityNameLabel.text = self.data.destination.locationName;
    self.departureDetailsLabel.text = self.data.flight.departureDate;
    self.returnDetailsLabel.text = self.data.flight.returnDate;
    self.costLabel.text = self.data.flight.price;
    self.duration.text = self.data.flight.journeyDuration;
//    self.weather.text = self.data.destination.weather;
}



@end

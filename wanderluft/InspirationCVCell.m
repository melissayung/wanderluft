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
@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *flightNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *departureDetailsLabel;
@property (weak, nonatomic) IBOutlet UILabel *returnDetailsLabel;
@property (weak, nonatomic) IBOutlet UILabel *costLabel;

@end

@implementation InspirationCVCell

- (void)awakeFromNib {
    NSLog(@"====%s===", __PRETTY_FUNCTION__);
}

- (void)updateCellView {
    self.cityNameLabel.text = self.data.destination.locationName;
    self.departureDetailsLabel.text = self.data.flight.departureDate;
    self.returnDetailsLabel.text = self.data.flight.returnDate;
    self.costLabel.text = self.data.flight.price;
}

@end

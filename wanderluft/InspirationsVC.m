//
//  FirstViewController.m
//  wanderluft
//
//  Created by Melissa Yung on 13/12/14.
//  Copyright (c) 2014 Travelling Mesh. All rights reserved.
//

#import "InspirationsVC.h"
#import "InspirationCVCell.h"
#import "InspirationsDatasource.h"
#import "WebViewVC.h"
#import "Inspiration.h"
#import "Flight.h"
#import "Destination.h"
#import "FXBlurView.h"

@interface InspirationsVC () <InspirationsDatasourceDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIView *flightDetails;
@property (weak, nonatomic) IBOutlet UILabel *flightNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *departureDetailsLabel;
@property (weak, nonatomic) IBOutlet UILabel *returnDetailsLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;

@property (nonatomic) InspirationsDatasource *datasource;
@property (nonatomic) Inspiration *selectedInspiration;
//@property (nonatomic) int selectedInspirationCVIndex;
@property (nonatomic) BOOL isFlightDetailsShowing;

@end

@implementation InspirationsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.inspirationsCV registerNib:[UINib nibWithNibName:InspirationCVCellIdentifier bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:InspirationCVCellIdentifier];
    self.datasource = [[InspirationsDatasource alloc] init];
    self.datasource.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.datasource testFetchPictures];
    //[self.datasource fetchInspirations];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)updateView {
    self.inspirations = [self.datasource collectionViewData];
    [self.inspirationsCV reloadData];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)view {
    
    // work out where we have scrolled to
    CGPoint contentOffset = view.contentOffset;
    CGSize viewSize = view.bounds.size;
    int index = MAX(0.0, contentOffset.x / viewSize.width);
    self.selectedInspiration = self.inspirations[index];
    [self fillInFlightDetails];
    [self showButtons];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self hideButtons];
    if (self.isFlightDetailsShowing) [self hideFlightDetails];
}

- (void)fillInFlightDetails {
    self.durationLabel.text = self.selectedInspiration.flight.journeyDuration;
    self.departureDetailsLabel.text = self.selectedInspiration.flight.departureDate;
    self.returnDetailsLabel.text = self.selectedInspiration.flight.returnDate;
    self.priceLabel.text = self.selectedInspiration.flight.price;
}

- (void)showFlightDetails {
    // slide the price up
    [UIView animateWithDuration:0.5f
                     animations:^{
                         self.flightDetails.frame = CGRectMake(self.flightDetails.frame.origin.x, 854, self.flightDetails.frame.size.width, self.flightDetails.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         self.isFlightDetailsShowing = YES;
                     }];
}

- (void)hideFlightDetails {
    // slide it back down
    [UIView animateWithDuration:0.5f
                     animations:^{
                         self.flightDetails.frame = CGRectMake(self.flightDetails.frame.origin.x, 1224, self.flightDetails.frame.size.width, self.flightDetails.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         self.isFlightDetailsShowing = NO;
                     }];
}

- (void)showButtons {
    // slide them in from the top
    [UIView animateWithDuration:0.5f
                     animations:^{
                         self.infoButton.hidden = self.bookButton.hidden = self.addToWishlistButton.hidden = NO;
                         self.infoButton.frame = CGRectMake(self.infoButton.frame.origin.x, 18, self.infoButton.frame.size.width, self.infoButton.frame.size.height);
                         self.bookButton.frame = CGRectMake(self.bookButton.frame.origin.x, 18, self.bookButton.frame.size.width, self.bookButton.frame.size.height);
                         self.addToWishlistButton.frame = CGRectMake(self.addToWishlistButton.frame.origin.x, 18, self.addToWishlistButton.frame.size.width, self.addToWishlistButton.frame.size.height);
                     }
                     completion:^(BOOL finished){
                     }];
}

- (void)hideButtons {
    self.infoButton.hidden = self.bookButton.hidden = self.addToWishlistButton.hidden = YES;
    self.infoButton.frame = CGRectMake(self.infoButton.frame.origin.x, -self.infoButton.frame.size.height, self.infoButton.frame.size.width, self.infoButton.frame.size.height);
    self.bookButton.frame = CGRectMake(self.bookButton.frame.origin.x, -self.bookButton.frame.size.height, self.bookButton.frame.size.width, self.bookButton.frame.size.height);
    self.addToWishlistButton.frame = CGRectMake(self.addToWishlistButton.frame.origin.x, -self.addToWishlistButton.frame.size.height, self.addToWishlistButton.frame.size.width, self.addToWishlistButton.frame.size.height);
}

#pragma mark - CollectionViewDatasource delegate methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.inspirations count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    InspirationCVCell *inspirationCell = [collectionView dequeueReusableCellWithReuseIdentifier:InspirationCVCellIdentifier forIndexPath:indexPath];
    inspirationCell.data = self.inspirations[indexPath.row];
    [inspirationCell updateCellView];
    return inspirationCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isFlightDetailsShowing) [self hideFlightDetails];
    else                             [self showFlightDetails];
}

#pragma mark - InspirationDatasource delegate methods
- (void)datasourceDataChanged {
    [self updateView];
}

#pragma mark - UI callbacks
- (IBAction)bookButtonPressed:(UIButton *)sender {
    // we need to build the deep linking
    NSString *URL = self.selectedInspiration.flight.bookingURL;
    
    WebViewVC *webViewVC = [WebViewVC webViewVCWithURL:URL];
    [self presentViewController:webViewVC animated:YES completion:nil];
}

- (IBAction)addToWishlistButtonPressed:(UIButton *)sender {
    self.addToWishlistButton.selected = !self.addToWishlistButton.selected;
}

- (IBAction)infoButtonPressed:(UIButton *)sender {
    //TODO check if luftansa has all the guide or can we check programatically and then hide/display info button?
    NSString *URL = [@"http://travelguide.lufthansa.com/de/en/" stringByAppendingString:self.selectedInspiration.destination.locationName];
    
    WebViewVC *webViewVC = [WebViewVC webViewVCWithURL:URL];
    [self presentViewController:webViewVC animated:YES completion:nil];
}


@end

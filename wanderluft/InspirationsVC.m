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

@interface InspirationsVC () <InspirationsDatasourceDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UILabel *returnFlightNumberLabel;

@property (weak, nonatomic) IBOutlet UIView *flightDetails;
@property (weak, nonatomic) IBOutlet UILabel *flightNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *departureDetailsLabel;
@property (weak, nonatomic) IBOutlet UILabel *returnDetailsLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UIView *wishlistHighlight;

@property (nonatomic) InspirationsDatasource *datasource;
@property (nonatomic) NSInteger selectedInspirationCVIndex;
@property (nonatomic) BOOL isFlightDetailsShowing;

// we use the same VC but different array to show the wishlist
@property (nonatomic) BOOL isShowingWishlist; // defaults to NO. when we shake we now show the wishlist and will set this flag

@end

@implementation InspirationsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.wishlist = [[NSMutableArray alloc] init];
    [self.inspirationsCV registerNib:[UINib nibWithNibName:InspirationCVCellIdentifier bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:InspirationCVCellIdentifier];
    self.datasource = [[InspirationsDatasource alloc] init];
    self.datasource.delegate = self;
    
    self.selectedInspirationCVIndex = 0; // on first load, we are at inspiration 0
    
#ifdef TEST
    [self.datasource testFetchPictures];
#else
    [self.datasource fetchInspirations];
#endif
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)updateView {
    if (self.isShowingWishlist) {
        self.inspirations = self.wishlist;
        self.wishlistHighlight.hidden = NO;
    }
    else {
        self.wishlistHighlight.hidden = YES;
        self.inspirations = [self.datasource collectionViewData];
    }
    [self.inspirationsCV reloadData];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)view {
    
    // work out where we have scrolled to
    CGPoint contentOffset = view.contentOffset;
    CGSize viewSize = view.bounds.size;
    int index = MAX(0.0, contentOffset.x / viewSize.width);
    self.selectedInspirationCVIndex = index;
    [self showButtons];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self hideButtons];
    if (self.isFlightDetailsShowing) [self hideFlightDetails];
}

- (void)fillInFlightDetails {
    Inspiration *selectedInspiration = self.inspirations[self.selectedInspirationCVIndex];
    self.durationLabel.text = selectedInspiration.flight.journeyDuration;
    self.departureDetailsLabel.text = selectedInspiration.flight.departureDate;
    self.returnDetailsLabel.text = selectedInspiration.flight.returnDate;
    self.priceLabel.text = selectedInspiration.flight.price;
    self.addToWishlistButton.selected = selectedInspiration.wishlisted;
    self.flightNumberLabel.text = [@"LH" stringByAppendingString:selectedInspiration.flight.departFlightNumber];
    self.returnFlightNumberLabel.text = [@"LH" stringByAppendingString:selectedInspiration.flight.returnFlightNumber];
}

- (void)showFlightDetails {
    [self fillInFlightDetails];
    // slide the price up
    [UIView animateWithDuration:0.5f
                     animations:^{
                         // TO FIX why isn't it showing on the first tap! the frame isn't updated
                         NSLog(@"====%s===", __PRETTY_FUNCTION__);
                         self.flightDetails.frame = CGRectMake(self.flightDetails.frame.origin.x, 854, self.flightDetails.frame.size.width, self.flightDetails.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         self.isFlightDetailsShowing = YES;
                         NSLog(@"%@", self.flightDetails);
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
    NSLog(@"====%s===", __PRETTY_FUNCTION__);
    self.selectedInspirationCVIndex = indexPath.row;
    if (self.isFlightDetailsShowing) [self hideFlightDetails];
    else                             [self showFlightDetails];
}

#pragma mark - InspirationDatasource delegate methods
- (void)datasourceDataChanged {
    [self updateView];
}

#pragma mark - UI callbacks
- (IBAction)bookButtonPressed:(UIButton *)sender {
    // deep linking in Lufthansa app?
    // backend would return something like
    // https://mobile.lufthansa.com/rs/bkg/login.do?origin=TXL&destination=CDG&dtin1=28&ymin=122014&tminbound=0
    NSString *URL = ((Inspiration *)self.inspirations[self.selectedInspirationCVIndex]).flight.bookingURL;
   
    WebViewVC *webViewVC = [WebViewVC webViewVCWithURL:URL];
    [self presentViewController:webViewVC animated:YES completion:nil];
}

- (IBAction)addToWishlistButtonPressed:(UIButton *)sender {
    self.addToWishlistButton.selected = !self.addToWishlistButton.selected;
    //TODO set in datasource properly
    ((Inspiration *)self.inspirations[self.selectedInspirationCVIndex]).wishlisted = self.addToWishlistButton.selected;
    if (self.addToWishlistButton.selected) [self.wishlist addObject:self.inspirations[self.selectedInspirationCVIndex]];
    else                                   [self.wishlist removeObject:self.inspirations[self.selectedInspirationCVIndex]];

    [self updateView];
}

- (IBAction)infoButtonPressed:(UIButton *)sender {
    //TODO check if luftansa has all the guide or can we check programatically and then hide/display info button?
    NSString *URL = @"http://travelguide.lufthansa.com/de/en/";
    NSString *location = [[(Inspiration *)(self.inspirations[self.selectedInspirationCVIndex]) getDestinationName] lowercaseString];
    URL = [URL stringByAppendingString:location];
    
    WebViewVC *webViewVC = [WebViewVC webViewVCWithURL:URL];
    [self presentViewController:webViewVC animated:YES completion:nil];
}


// Feature to show wishlist on shake on hold for now. ran out of time
//- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
//{
//    if ( event.subtype == UIEventSubtypeMotionShake )
//    {
//        self.isShowingWishlist = !self.isShowingWishlist;
//        [self updateView];
//        // Put in code here to handle shake
//    }
//    
//    if ( [super respondsToSelector:@selector(motionEnded:withEvent:)] )
//        [super motionEnded:motion withEvent:event];
//}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

@end

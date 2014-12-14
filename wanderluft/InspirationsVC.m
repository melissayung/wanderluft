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

@property (nonatomic) InspirationsDatasource *datasource;
@property (nonatomic) int selectedInspirationCVIndex;
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

- (void)updateView {
    self.inspirations = [self.datasource collectionViewData];
    [self.inspirationsCV reloadData];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)view {
    [self showButtons:view];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.infoButton.hidden = self.bookButton.hidden = self.addToWishlistButton.hidden = YES;
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
    [self showButtons:collectionView];
    [self showPriceDetails];
}

- (void)showPriceDetails {
    
}

- (void)showButtons:(UIScrollView *)view {
    // work out where we have scrolled to
    CGPoint contentOffset = view.contentOffset;
    CGSize viewSize = view.bounds.size;
    self.selectedInspirationCVIndex = MAX(0.0, contentOffset.x / viewSize.width);
    self.infoButton.hidden = self.bookButton.hidden = self.addToWishlistButton.hidden = NO;
}

#pragma mark - InspirationDatasource delegate methods
- (void)datasourceDataChanged {
    [self updateView];
}

#pragma mark - UI callbacks
- (IBAction)bookButtonPressed:(UIButton *)sender {
    // we need to build the deep linking
    Inspiration *selectedInspiration = (Inspiration *)(self.inspirations[self.selectedInspirationCVIndex]);
    NSString *URL = selectedInspiration.flight.bookingURL;
    
    WebViewVC *webViewVC = [WebViewVC webViewVCWithURL:URL];
    [self presentViewController:webViewVC animated:YES completion:nil];
}

- (IBAction)addToWishlistButtonPressed:(UIButton *)sender {
    self.addToWishlistButton.selected = !self.addToWishlistButton.selected;
}

- (IBAction)infoButtonPressed:(UIButton *)sender {
    //TODO check if luftansa has all the guide or can we check programatically and then hide/display info button?
    Inspiration *selectedInspiration = (Inspiration *)(self.inspirations[self.selectedInspirationCVIndex]);
    NSString *URL = [@"http://travelguide.lufthansa.com/de/en/" stringByAppendingString:selectedInspiration.destination.locationName];
    
    WebViewVC *webViewVC = [WebViewVC webViewVCWithURL:URL];
    [self presentViewController:webViewVC animated:YES completion:nil];
}


@end

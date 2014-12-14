//
//  WebViewVC.m
//  wanderluft
//
//  Created by Melissa Yung on 14/12/14.
//  Copyright (c) 2014 Travelling Mesh. All rights reserved.
//

#import "WebViewVC.h"
#import <UIKit/UIKit.h>

@interface WebViewVC () <UIWebViewDelegate>

@property (nonatomic) NSString *URL;
@property (nonatomic) UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WebViewVC

+ (WebViewVC *)webViewVCWithURL:(NSString *)URL {
    WebViewVC *webViewVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"WebViewVC"];
    webViewVC.URL = URL;
    return webViewVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView.delegate = self;
    if ([self.URL hasPrefix:@"http"]) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.URL]]];
    }
    
    int spinnerYPos = 50;
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
//        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [backButton setAccessibilityLabel:NSLocalizedString(@"WebViewBack.Label", nil)];
//        [backButton setImage:[UIImage imageNamed:@"BackBnDefault"] forState:UIControlStateNormal];
//        [backButton setImage:[UIImage imageNamed:@"BackBnClicked"] forState:UIControlStateHighlighted];
//        [backButton sizeToFit];
//        [backButton addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
//        
//        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    self.spinner.center = CGPointMake([UIScreen mainScreen].bounds.size.width*.5, spinnerYPos);
    self.spinner.hidesWhenStopped = YES;
    [self.view addSubview:self.spinner];
    [self.spinner startAnimating];
}

#pragma mark - UIWebViewDelegate methods
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.spinner stopAnimating];
}

#pragma mark - UI CALLBACKS
- (void)backButtonPressed {
//    [UIViewController popVC:self];
}

- (IBAction)smallOverlayBackButtonPressed:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(webViewClose:)]) {
        [self.delegate webViewClose:self];
    }
}


@end

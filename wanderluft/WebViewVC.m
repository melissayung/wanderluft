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
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.webView.delegate = self;
    if ([self.URL hasPrefix:@"http"]) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.URL]]];
    }
    
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    self.spinner.center = CGPointMake([UIScreen mainScreen].bounds.size.width*.5, [UIScreen mainScreen].bounds.size.height*.5);
    self.spinner.hidesWhenStopped = YES;
    [self.view addSubview:self.spinner];
    
    
}

-(BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - UIWebViewDelegate methods
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.spinner stopAnimating];
}

#pragma mark - UI CALLBACKS
- (IBAction)closeWebviewButtonPressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        // maybe do something here
    }];
}



@end

//
//  WebViewVC.h
//  wanderluft
//
//  Created by Melissa Yung on 14/12/14.
//  Copyright (c) 2014 Travelling Mesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WebViewVC;

@protocol WebViewVCDelegate <NSObject>
- (void)webViewClose:(WebViewVC *)webViewVC;
@end

@interface WebViewVC : UIViewController

@property (nonatomic, weak) id<WebViewVCDelegate> delegate;

+ (WebViewVC *)webViewVCWithURL:(NSString *)URL;

@end

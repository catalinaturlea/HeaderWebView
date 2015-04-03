//
//  HeaderWebView.h
//  HeaderWebView
//
//  Created by Catalina Turlea on 4/3/15.
//  Copyright (c) 2015 Catalina Turlea. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HeaderWebView;

@protocol HeaderWebViewDelegate

- (void)headerWebView:(HeaderWebView *)webview showFullScreen:(BOOL)fullScreen;

@end

@interface HeaderWebView : UIWebView

@property (nonatomic, weak) id<HeaderWebViewDelegate> fullScreenDelegate;

@end

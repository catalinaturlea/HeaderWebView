//
//  ViewController.m
//  HeaderWebView
//
//  Created by Catalina Turlea on 4/3/15.
//  Copyright (c) 2015 Catalina Turlea. All rights reserved.
//

#import "ViewController.h"
#import "HeaderWebView.h"

@interface ViewController () <HeaderWebViewDelegate>

@property (nonatomic, weak) IBOutlet HeaderWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set the delegate for the full screen behavior
    [self.webView setFullScreenDelegate:self];
    
    // Test URL to load
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.postseek.com/meta/e85aef3ecaa2887f4c531f0940821c0f"]]];
}

#pragma mark -
#pragma mark - HeaderWebViewDelegate

- (void)headerWebView:(HeaderWebView *)webview showFullScreen:(BOOL)fullScreen {
    
    // Hide navigation bar
    [self.navigationController setNavigationBarHidden:fullScreen animated:YES];
    
    // Could hide also toolbar if apps has it
    
    // Hide the status bar too
    [[UIApplication sharedApplication] setStatusBarHidden:fullScreen withAnimation:UIStatusBarAnimationFade];
}

@end

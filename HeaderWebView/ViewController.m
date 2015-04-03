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
}

- (void)headerWebView:(HeaderWebView *)webview showFullScreen:(BOOL)fullScreen {
    
    [self.navigationController setNavigationBarHidden:fullScreen animated:YES];
    
    // Hide the status bar too
}

@end

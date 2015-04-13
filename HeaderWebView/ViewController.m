//
//  ViewController.m
//  HeaderWebView
//
//  Created by Catalina Turlea on 4/3/15.
//  Copyright (c) 2015 Catalina Turlea. All rights reserved.
//

#import "ViewController.h"
#import "EmailView.h"

@interface ViewController () <EmailViewDelegate>

@property (nonatomic, weak) IBOutlet EmailView *emaiView;
@property (weak, nonatomic) IBOutlet UIWebView *normalWebView;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	// Test URL to load
	[self.normalWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://nshipster.com/ns_enum-ns_options/"]]];

	[self.emaiView setFullScreenDelegate:self];
}

#pragma mark -
#pragma mark - EmailViewDelegate

- (void)emailView:(EmailView *)emailView showFullScreen:(BOOL)fullScreen {
	// Hide navigation bar
	[self.navigationController setNavigationBarHidden:fullScreen animated:YES];

	// Could hide also toolbar if apps has it

	// Hide the status bar too
	[[UIApplication sharedApplication] setStatusBarHidden:fullScreen withAnimation:UIStatusBarAnimationFade];
}

@end

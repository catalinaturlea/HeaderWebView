//
//  HeaderWebView.m
//  HeaderWebView
//
//  Created by Catalina Turlea on 4/3/15.
//  Copyright (c) 2015 Catalina Turlea. All rights reserved.
//

#import "HeaderWebView.h"

@interface HeaderWebView()

@property (nonatomic, weak) UIView *innerHeaderView;
@property (nonatomic, weak) IBOutlet UIView *headerView;

@property (nonatomic, getter = isFullScreen) BOOL fullScreen;

@end

@implementation HeaderWebView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self createHeaderView];
    
    self.scalesPageToFit = YES;
    
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionInitial context:nil];
    
    [self.scrollView setDelegate:self];
}

#pragma mark -
#pragma mark - NSKeyObserving

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    // Update the frame of the header view so that it scrolls with the webview content
    CGRect newFrame = self.headerView.frame;
    newFrame.origin.y = -CGRectGetMinY([self convertRect:self.innerHeaderView.frame toView:self.scrollView]);
    [self.headerView setFrame:newFrame];
    
    BOOL fullScreen = (newFrame.origin.y < 0) || [self isFullScreen];
    
    // Call the delegate for the full screen
    [self.fullScreenDelegate headerWebView:self showFullScreen:fullScreen];
}

#pragma mark - 
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    // This is used to avoid weird behaviour when frame changes on full screen
    [self setFullScreen:(self.scrollView.zoomScale > 1)];
}

#pragma mark -
#pragma mark - Custom methods

- (void)createHeaderView {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 60)];
    [headerView setBackgroundColor:[UIColor redColor]];
    
    [self.scrollView addSubview:headerView];
    [self setInnerHeaderView:headerView];
    
    [self addSubview:self.headerView];
    [self.headerView setHidden:YES];
    
    for (UIView *subview in self.scrollView.subviews) {
        CGRect newFrame = subview.frame;
        if ([subview isEqual:self.innerHeaderView]) {
            continue;
        }
        
        newFrame.origin.y += CGRectGetHeight(self.headerView.frame);
        [subview setFrame:newFrame];
    }
}

#pragma mark -
#pragma mark - Dealloc

- (void)dealloc {
    
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

@end

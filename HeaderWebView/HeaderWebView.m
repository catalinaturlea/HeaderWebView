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

@end

@implementation HeaderWebView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self createHeaderView];
    
    self.scalesPageToFit = YES;
    
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionInitial context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {

    CGRect newFrame = self.headerView.frame;
    newFrame.origin.y = -CGRectGetMinY([self convertRect:self.innerHeaderView.frame toView:self.scrollView]);
    [self.headerView setFrame:newFrame];
    
    // Just once fullscreen on zoom scale !=1 
    if (self.scrollView.zoomScale!=1) {
        return;
    }
    
    // Need some special logic on zooming when the frame increases
    [self.fullScreenDelegate headerWebView:self showFullScreen:(newFrame.origin.y < 0)];
}

- (void)createHeaderView {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 0)];
    [headerView setBackgroundColor:[UIColor redColor]];
    
    [self.scrollView addSubview:headerView];
    [self setInnerHeaderView:headerView];
    
    [self addSubview:self.headerView];
    
    for (UIView *subview in self.scrollView.subviews) {
        CGRect newFrame = subview.frame;
        if ([subview isEqual:self.innerHeaderView]) {
            continue;
        }
        
        newFrame.origin.y += CGRectGetHeight(self.headerView.frame);
        [subview setFrame:newFrame];
    }
}

- (void)dealloc {
    
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

@end

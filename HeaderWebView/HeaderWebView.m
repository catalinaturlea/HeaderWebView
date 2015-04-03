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
    
    [self loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.postseek.com/meta/e85aef3ecaa2887f4c531f0940821c0f"]]];
    
    self.scalesPageToFit = YES;
    
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionInitial context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    NSLog(@"%@", NSStringFromCGRect([self convertRect:self.innerHeaderView.frame toView:self.scrollView]));
    
    CGRect newFrame = self.headerView.frame;
    newFrame.origin.y = -CGRectGetMinY([self convertRect:self.innerHeaderView.frame toView:self.scrollView]);
    [self.headerView setFrame:newFrame];
    
    [self.fullScreenDelegate headerWebView:self showFullScreen:(self.scrollView.contentOffset.y > 0)];
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

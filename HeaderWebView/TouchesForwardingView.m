//
//  TouchesForwardingView.m
//  HeaderWebView
//
//  Created by Catalina Turlea on 4/22/15.
//  Copyright (c) 2015 Catalina Turlea. All rights reserved.
//

#import "TouchesForwardingView.h"

@implementation TouchesForwardingView

// Need to forward touches to the webview from the overscrolling to work
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *hitTestView = [super hitTest:point withEvent:event];
    
    if ([hitTestView isKindOfClass:[UIControl class]])
    {
        return hitTestView;
    }
    return nil;
}

@end
//
//  EmailView.h
//  HeaderWebView
//
//  Created by Catalina Turlea on 4/13/15.
//  Copyright (c) 2015 Catalina Turlea. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EmailView;

@protocol EmailViewDelegate

- (void)emailView:(EmailView *)emailView showFullScreen:(BOOL)fullScreen;

@end

@interface EmailView : UIView

@property (nonatomic, weak) id<EmailViewDelegate> fullScreenDelegate;

@end

//
//  SwsAlertView.h
//
//  Created by sws on 6/6/6.
//  Copyright © 666年 sws. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SwsAlertView;

@protocol SwsAlertViewDelegate <NSObject>

@optional

/** 0:Left  1:Right  2:BackgroundButton */
- (void)clickSwsAlertViewButtonAtIndex:(NSInteger)index swsAlertView:(SwsAlertView *)swsAlertView;

@end

@interface SwsAlertView : UIView

@property (nonatomic, weak) id <SwsAlertViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextView *textView;

/** SwsAlertView With Message */
- (SwsAlertView *)initWithTitle:(NSString *)title
                        message:(NSString *)message
                       delegate:(id)delegate
                       leftText:(NSString *)leftText
                      rightText:(NSString *)rightText;

/** SwsAlertView With View */
- (SwsAlertView *)initWithTitle:(NSString *)title
                           view:(UIView *)view
                       delegate:(id)delegate
                       leftText:(NSString *)leftText
                      rightText:(NSString *)rightText;

/** SwsAlertView With TextView */
- (SwsAlertView *)initWithTitle:(NSString *)title
                    placeholder:(NSString *)placeholder
                       delegate:(id)delegate
                       leftText:(NSString *)leftText
                      rightText:(NSString *)rightText;

/** show */
- (void)show;

@end

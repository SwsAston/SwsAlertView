//
//  SwsAlertView.m
//
//  Created by sws on 6/6/6.
//  Copyright © 666年 sws. All rights reserved.
//

#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height

#define Button_NormalColor   [UIColor clearColor]
#define Button_HightedColor  [UIColor grayColor]

#define CenterView_Left_To_View 50

#define DetailedView_Left_To_View 20

#define TextView_BorderColor    [UIColor grayColor]
#define TextView_Border_Width   1.0
#define TextView_CornerRadius   5.0
#define TextView_Left_To_View   20
#define TextView_Max_Height     60

#import "SwsAlertView.h"
#import "AppDelegate.h"
#import "UITextView+Sws.h"

@interface SwsAlertView () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerViewCenterY;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerViewLeftToView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerViewRightToView;

@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleViewHeight;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelToBottom;

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@property (weak, nonatomic) IBOutlet UIView *detailedView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailedViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailedViewHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewLeftToView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewRightToView;
@property (nonatomic, assign) BOOL isTextView;

@property (weak, nonatomic) IBOutlet UIView *optionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *optionViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *optionVerViewCenterX;
@property (weak, nonatomic) IBOutlet UIView *leftLabelView;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UIView *rightLabelView;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

@end

@implementation SwsAlertView

#pragma mark - SwsAlertView With Message
- (SwsAlertView *)initWithTitle:(NSString *)title
                        message:(NSString *)message
                       delegate:(id)delegate
                       leftText:(NSString *)leftText
                      rightText:(NSString *)rightText {
    
    SwsAlertView *alertView = [[[NSBundle mainBundle] loadNibNamed:@"SwsAlertView" owner:nil options:nil] firstObject];
    alertView.frame = [UIScreen mainScreen].bounds;
    alertView.delegate = delegate;
    
    [alertView.textView removeFromSuperview];
    [alertView.detailedView removeFromSuperview];

    alertView.centerViewLeftToView.constant = CenterView_Left_To_View;
    alertView.centerViewRightToView.constant = CenterView_Left_To_View;
    
    // Title
    if (title) {
        
        [alertView.titleView removeConstraint:alertView.titleViewHeight];
        alertView.titleLabel.text = title;
    } else {
        
        [alertView.titleView removeConstraint:alertView.titleLabelToBottom];
        alertView.titleViewHeight.constant = 0;
        alertView.titleLabel.text = nil;
    }
    
    // Message
    if (message) {
        
        alertView.messageLabel.text = message;
    } else {
        
        alertView.messageLabel.text = nil;
    }
    
    // Left And Right
    if (!leftText && !rightText) {
        
        alertView.leftLabel.text = nil;
        alertView.rightLabel.text = nil;
        for (UIView *view in alertView.optionView.subviews) {
            
            [view removeFromSuperview];
        }
        alertView.optionViewHeight.constant = 0;
        return alertView;
    }
    
    // Left
    if (leftText) {
        
        alertView.leftLabel.text = leftText;
        [alertView.leftButton setBackgroundImage:[alertView createImageWithColor:Button_NormalColor] forState:UIControlStateNormal];
        [alertView.leftButton setBackgroundImage:[alertView createImageWithColor:Button_HightedColor] forState:UIControlStateHighlighted];
    } else {
        
        alertView.leftLabel.text = nil;
        [alertView.leftLabelView removeFromSuperview];
        alertView.optionVerViewCenterX.constant = - (Width / 2 - CenterView_Left_To_View);
    }
    
    // Right
    if (rightText) {
        
        alertView.rightLabel.text = rightText;
        [alertView.rightButton setBackgroundImage:[alertView createImageWithColor:Button_NormalColor] forState:UIControlStateNormal];
        [alertView.rightButton setBackgroundImage:[alertView createImageWithColor:Button_HightedColor] forState:UIControlStateHighlighted];
    } else {
        
        alertView.rightLabel.text = nil;
        [alertView.rightLabelView removeFromSuperview];
        alertView.optionVerViewCenterX.constant = Width / 2 - CenterView_Left_To_View;
    }
    return alertView;
}


#pragma mark - AlertView With View
- (SwsAlertView *)initWithTitle:(NSString *)title
                           view:(UIView *)view
                       delegate:(id)delegate
                       leftText:(NSString *)leftText
                      rightText:(NSString *)rightText {
    SwsAlertView *alertView = [[[NSBundle mainBundle] loadNibNamed:@"SwsAlertView" owner:nil options:nil] firstObject];
    alertView.frame = [UIScreen mainScreen].bounds;
    alertView.delegate = delegate;
    
    [alertView.messageLabel removeFromSuperview];
    [alertView.textView removeFromSuperview];
    
    alertView.centerViewLeftToView.constant = CenterView_Left_To_View;
    alertView.centerViewRightToView.constant = CenterView_Left_To_View;
    
    // Title
    if (title) {
        
        [alertView.titleView removeConstraint:alertView.titleViewHeight];
        alertView.titleLabel.text = title;
    } else {
        
        [alertView.titleView removeConstraint:alertView.titleLabelToBottom];
        alertView.titleViewHeight.constant = 0;
        alertView.titleLabel.text = nil;
    }
    
    // DetailedView
    alertView.detailedViewHeight.constant = view.bounds.size.height;
    if (view.bounds.size.width > Width - 2 * (CenterView_Left_To_View + DetailedView_Left_To_View)) {
        
        view.frame = CGRectMake(0, 0, Width - 2 * (CenterView_Left_To_View + DetailedView_Left_To_View), view.bounds.size.height);
    }
    NSLog(@"%lf,%lf",view.bounds.size.width, view.bounds.size.height);
    alertView.detailedViewWidth.constant = view.bounds.size.width;
    [alertView.detailedView layoutIfNeeded];
    [alertView.detailedView addSubview:view];
    
    // Left And Right
    if (!leftText && !rightText) {
        
        alertView.leftLabel.text = nil;
        alertView.rightLabel.text = nil;
        for (UIView *view in alertView.optionView.subviews) {
            
            [view removeFromSuperview];
        }
        alertView.optionViewHeight.constant = 0;
        return alertView;
    }
    
    // Left
    if (leftText) {
        
        alertView.leftLabel.text = leftText;
        [alertView.leftButton setBackgroundImage:[alertView createImageWithColor:Button_NormalColor] forState:UIControlStateNormal];
        [alertView.leftButton setBackgroundImage:[alertView createImageWithColor:Button_HightedColor] forState:UIControlStateHighlighted];
    } else {
        
        alertView.leftLabel.text = nil;
        [alertView.leftLabelView removeFromSuperview];
        alertView.optionVerViewCenterX.constant = - (Width / 2 - CenterView_Left_To_View);
    }
    
    // Right
    if (rightText) {
        
        alertView.rightLabel.text = rightText;
        [alertView.rightButton setBackgroundImage:[alertView createImageWithColor:Button_NormalColor] forState:UIControlStateNormal];
        [alertView.rightButton setBackgroundImage:[alertView createImageWithColor:Button_HightedColor] forState:UIControlStateHighlighted];
    } else {
        
        alertView.rightLabel.text = nil;
        [alertView.rightLabelView removeFromSuperview];
        alertView.optionVerViewCenterX.constant = Width / 2 - CenterView_Left_To_View;
    }
    return alertView;

    
}

#pragma mark - AlertView With TextView
- (SwsAlertView *)initWithTitle:(NSString *)title
                    placeholder:(NSString *)placeholder
                       delegate:(id)delegate
                       leftText:(NSString *)leftText
                      rightText:(NSString *)rightText {
    
    SwsAlertView *alertView = [[[NSBundle mainBundle] loadNibNamed:@"SwsAlertView" owner:nil options:nil] firstObject];
    alertView.frame = [UIScreen mainScreen].bounds;
    alertView.delegate = delegate;
    
    [alertView.messageLabel removeFromSuperview];
    [alertView.detailedView removeFromSuperview];
    
    alertView.centerViewLeftToView.constant = CenterView_Left_To_View;
    alertView.centerViewRightToView.constant = CenterView_Left_To_View;
    alertView.textViewLeftToView.constant = TextView_Left_To_View;
    alertView.textViewRightToView.constant = TextView_Left_To_View;
    
    // Title
    if (title) {
        
        [alertView.titleView removeConstraint:alertView.titleViewHeight];
        alertView.titleLabel.text = title;
    } else {
        
        [alertView.titleView removeConstraint:alertView.titleLabelToBottom];
        alertView.titleViewHeight.constant = 0;
        alertView.titleLabel.text = nil;
    }
    
    // TextView
    alertView.isTextView = YES;
    alertView.textViewHeight.constant = alertView.textView.font.pointSize + 4 + 2 * 7;
    alertView.textView.placeholder = placeholder;
    alertView.textView.delegate = alertView;
    alertView.textView.layer.borderWidth = TextView_Border_Width;
    alertView.textView.layer.borderColor = TextView_BorderColor.CGColor;
    alertView.textView.layer.cornerRadius = TextView_CornerRadius;
    alertView.textView.layer.masksToBounds = YES;
    
    // Left And Right
    if (!leftText && !rightText) {
        
        alertView.leftLabel.text = nil;
        alertView.rightLabel.text = nil;
        for (UIView *view in alertView.optionView.subviews) {
            
            [view removeFromSuperview];
        }
        alertView.optionViewHeight.constant = 0;
        return alertView;
    }
    
    // Left
    if (leftText) {
        
        alertView.leftLabel.text = leftText;
        [alertView.leftButton setBackgroundImage:[alertView createImageWithColor:Button_NormalColor] forState:UIControlStateNormal];
        [alertView.leftButton setBackgroundImage:[alertView createImageWithColor:Button_HightedColor] forState:UIControlStateHighlighted];
    } else {
        
        alertView.leftLabel.text = nil;
        [alertView.leftLabelView removeFromSuperview];
        alertView.optionVerViewCenterX.constant = - (Width / 2 - CenterView_Left_To_View);
    }
    
    // Right
    if (rightText) {
        
        alertView.rightLabel.text = rightText;
        [alertView.rightButton setBackgroundImage:[alertView createImageWithColor:Button_NormalColor] forState:UIControlStateNormal];
        [alertView.rightButton setBackgroundImage:[alertView createImageWithColor:Button_HightedColor] forState:UIControlStateHighlighted];
    } else {
        
        alertView.rightLabel.text = nil;
        [alertView.rightLabelView removeFromSuperview];
        alertView.optionVerViewCenterX.constant = Width / 2 - CenterView_Left_To_View;
    }
    return alertView;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    
    if (_textViewHeight.constant > TextView_Max_Height) {
        
        return;
    }
    
    CGFloat width = [self witdhWithString:textView.text andFontSize:textView.font.pointSize];
    CGFloat heigth = 0;
    if (width >= Width - 2 * (CenterView_Left_To_View + TextView_Left_To_View + 6)) {
        
        heigth = [self heightWithString:textView.text andFontSize:textView.font.pointSize andWidth: Width - 2 * (CenterView_Left_To_View + TextView_Left_To_View + 6)];
        _textViewHeight.constant = heigth + 2 * 7;
    } else {
        
        _textViewHeight.constant =  _textView.font.pointSize + 4 + 2 * 7;
    }
}

#pragma mark - WidthWithString
- (float)witdhWithString:(NSString*)string andFontSize:(CGFloat)fontSize {
    
    CGSize size = CGSizeMake(MAXFLOAT, 0);
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont fontWithName:self.textView.font.fontName size:fontSize]};
    CGSize detailSize = [string boundingRectWithSize:size
                                             options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    return detailSize.width;
}

#pragma mark - HeightWithString
- (float)heightWithString:(NSString*)string andFontSize:(CGFloat)fontSize andWidth:(float)width {
    
    CGSize size = CGSizeMake(width,MAXFLOAT) ;
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont fontWithName:self.textView.font.fontName size:fontSize]};
    CGSize detailSize = [string boundingRectWithSize:size
                                             options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    return detailSize.height;
}

#pragma mark - KeyBoard
- (void)keyboardWillShow:(NSNotification *)notification {
    
    CGRect frame = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    if (frame.size.height > Height / 2) {
        
        _centerViewCenterY.constant = - (self.centerView.bounds.size.height / 2 + 30);
    } else {
    
        _centerViewCenterY.constant = - 30;
    }
    
    __weak SwsAlertView *view = self;
    [UIView animateWithDuration:0.5 animations:^{
        
        [view layoutSubviews];
    }];
}

-(void)keyboardWillHide:(NSNotification *)aNotification{
    
    _centerViewCenterY.constant = 0;

    __weak SwsAlertView *view = self;
    [UIView animateWithDuration:0.2 animations:^{
        
        [view layoutSubviews];
    }];
}

#pragma mark - ClickButton
- (IBAction)clickButton:(UIButton *)sender {
    
    // 0:Left  1:Right  2:BackgroundButton
    if (_delegate && [_delegate respondsToSelector:@selector(clickSwsAlertViewButtonAtIndex:swsAlertView:)]) {
        
        [_delegate clickSwsAlertViewButtonAtIndex:sender.tag swsAlertView:self];
    }
    [self dismiss];
}

#pragma mark - show / dismiss
- (void)show {
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIWindow *window = appDelegate.window;
    [window addSubview:self];
    
    __weak SwsAlertView *view = self;
    view.alpha = 0;
    view.centerView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    
    [UIView animateWithDuration:.2 animations:^{
        
        view.centerView.transform = CGAffineTransformIdentity;
        view.alpha = 1;
    } completion:^(BOOL finished) {
        
        if (view.isTextView) {
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                         name:UIKeyboardWillShowNotification object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                         name:UIKeyboardWillHideNotification object:nil];
        }
    }];
}

- (void)dismiss {
    
    __weak SwsAlertView *view = self;
    [UIView animateWithDuration:.2 animations:^{
        
        view.centerView.transform = CGAffineTransformMakeScale(0.5, 0.5);
        view.alpha = 0;
    } completion:^(BOOL finished) {
        
        [view removeFromSuperview];
    }];
}

#pragma mark - ImageWithColor
- (UIImage *)createImageWithColor:(UIColor*)color {
    
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end

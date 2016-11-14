//
//  UITextView+Sws.m
//
//  Created by sws on 6/6/6.
//  Copyright © 666年 sws. All rights reserved.
//

#import "UITextView+Sws.h"
#import <objc/runtime.h>

#define Left 6
#define Top  7

@interface UITextView ()

@property (nonatomic, strong) UILabel *placeholderLabel;

@end

@implementation UITextView (Sws)

#pragma mark - PlaceholderLabel
- (UILabel *)placeholderLabel {
    
    return objc_getAssociatedObject(self, @selector(placeholderLabel));
}

- (void)setPlaceholderLabel:(UILabel *)placeholderLabel {
    
    objc_setAssociatedObject(self, @selector(placeholderLabel), placeholderLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - PlaceholderColor
- (UIColor *)placeholderColor {
    
    return self.placeholderLabel.textColor;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    
    self.placeholderLabel.textColor = placeholderColor;
}

#pragma mark - Placeholder
- (NSString *)placeholder {
    
    return objc_getAssociatedObject(self, @selector(placeholder));
}

- (void)setPlaceholder:(NSString *)placeholder {
    
    objc_setAssociatedObject(self, @selector(placeholder), placeholder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self createPlacelabelWithString:placeholder];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateSwsTextView)
                                                 name:UITextViewTextDidChangeNotification
                                               object:self];
}

- (void)createPlacelabelWithString:(NSString *)string {
    
    [self layoutIfNeeded];
    self.placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(Left, Top, self.bounds.size.width - 2 * Left, 0)];
    self.placeholderLabel.text = string;
    self.placeholderLabel.font = [UIFont fontWithName:self.font.fontName size:self.font.pointSize];
    self.placeholderLabel.numberOfLines = 0;
    self.placeholderLabel.textColor = [UIColor colorWithRed:199.0 / 255.0 green:199.0 / 255.0 blue:205.0/ 255.0 alpha:1.0];
    self.placeholderLabel.backgroundColor = [UIColor clearColor];
    [self.placeholderLabel sizeToFit];
    [self addSubview:self.placeholderLabel];
}

#pragma mark - UpdateSwsTextView
- (void)updateSwsTextView {
    
    self.placeholderLabel.hidden = self.text.length > 0 ? YES : NO;
}

#pragma mark - dealloc
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
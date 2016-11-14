//
//  CustomView.m
//
//  Created by sws on 6/6/6.
//  Copyright © 666年 sws. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

+ (CustomView *)initWithFrame:(CGRect)frame {
    
    CustomView *customView = [[[NSBundle mainBundle] loadNibNamed:@"CustomView" owner:self options:nil] firstObject];
    customView.frame = frame;
    return customView;
}

@end

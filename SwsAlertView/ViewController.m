//
//  ViewController.m
//
//  Created by sws on 6/6/6.
//  Copyright © 666年 sws. All rights reserved.
//

#import "ViewController.h"
#import "SwsAlertView.h"
#import "CustomView.h"

@interface ViewController () <SwsAlertViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

#pragma mark - NoTitle
- (IBAction)noTitle:(UIButton *)sender {
    
    SwsAlertView *alertView = [[SwsAlertView alloc] initWithTitle:nil message:@"No Title" delegate:self leftText:@"Left" rightText:@"Right"];
    [alertView show];
}

#pragma mark - NoLeft
- (IBAction)noLeft:(UIButton *)sender {
    
    SwsAlertView *alertView = [[SwsAlertView alloc] initWithTitle:@"SwsAlertView" message:@"No Left" delegate:self leftText:nil rightText:@"Right"];
    [alertView show];
}

#pragma mark - NoRight
- (IBAction)noRight:(UIButton *)sender {
    
    SwsAlertView *alertView = [[SwsAlertView alloc] initWithTitle:@"SwsAlertView" message:@"No Right" delegate:self leftText:@"Left" rightText:nil];
    [alertView show];
}

#pragma mark - None
- (IBAction)none:(UIButton *)sender {
    
    SwsAlertView *alertView = [[SwsAlertView alloc] initWithTitle:@"SwsAlertView SwsAlertView SwsAlertView SwsAlertView SwsAlertView" message:@"None None None None None None None None None None None None None None None None None" delegate:self leftText:nil rightText:nil];
    [alertView show];
}

#pragma mark - CustomView
- (IBAction)customView:(UIButton *)sender {
    
    CustomView *customView = [CustomView initWithFrame:CGRectMake(0, 0, 200, 100)];
    SwsAlertView *alertView = [[SwsAlertView alloc] initWithTitle:@"Title" view:customView delegate:self leftText:@"Left" rightText:nil];
    [alertView show];
}

#pragma mark - TextView
- (IBAction)textView:(UIButton *)sender {
    
    SwsAlertView *alertView = [[SwsAlertView alloc] initWithTitle:@"Title" placeholder:@"placeholder" delegate:self leftText:@"left" rightText:@"right"];
    [alertView show];
}

#pragma mark - SwsAlertViewDelegate
- (void)clickSwsAlertViewButtonAtIndex:(NSInteger)index swsAlertView:(SwsAlertView *)swsAlertView {
    
    NSLog(@"%ld", (long)index);
    if (swsAlertView.textView.text.length > 0) {
        
        NSLog(@"%@", swsAlertView.textView.text);
    }
}

@end

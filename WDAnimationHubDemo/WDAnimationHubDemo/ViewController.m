//
//  ViewController.m
//  WDAnimationHubDemo
//
//  Created by apple on 2017/8/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController.h"
#import "WDAnimationHub.h"

@interface ViewController ()

@end

@implementation ViewController
- (IBAction)btnClick:(UIButton *)sender {
    
    [WDAnimationHub showWithText:@"正在加载中，请稍后。。。" imageNames:@[
                                                              @"WDAnimationHub.bundle/WifiMan_4",
                                                              @"WDAnimationHub.bundle/WifiMan_3",
                                                              @"WDAnimationHub.bundle/WifiMan_2",
                                                              @"WDAnimationHub.bundle/WifiMan_1",
                                                              @"WDAnimationHub.bundle/WifiMan_2",
                                                              @"WDAnimationHub.bundle/WifiMan_3",
                                                              @"WDAnimationHub.bundle/WifiMan_4"
                                                              ]];
    
    [WDAnimationHub show];

    
    for (int i = 0 ; i < 10; i++) {
        [WDAnimationHub showWithText:@"正在努力加载中。。。"];
    }
    
    //打开Debug View Hierarchy可以发现keyWindow上只有一个hub对象
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [WDAnimationHub dismiss];
        
    });

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
@end

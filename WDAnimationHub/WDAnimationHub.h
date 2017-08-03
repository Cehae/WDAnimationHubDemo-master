//
//  WDAnimationHub.h
//  WDHubTest
//
//  Created by apple on 2017/8/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WDAnimationHub : NSObject

+(void)showWithText:(NSString*)text imageNames:(NSArray<NSString*>*)images;

+(void)showWithText:(NSString*)text;

+(void)show;

+(void)dismiss;

@end

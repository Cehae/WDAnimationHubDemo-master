//
//  WDAnimationHub.m
//  WDHubTest
//
//  Created by apple on 2017/8/3.
//  Copyright © 2017年 apple. All rights reserved.
//
//  地址：https://github.com/Cehae/WDAnimationHubDemo-master
//  博客：http://blog.csdn.net/Cehae/article/details/76626018
//

#import "WDAnimationHub.h"

static CGFloat contentView_Width = 200.0f;
static CGFloat contentView_Height = 120.0f;

static CGFloat imageVLayer_Width = 85.0f;
static CGFloat imageVLayer_Height = 85.0f;

@interface WDAnimationHub()

/** hubView */
@property (nonatomic,strong) UIView * hubView;


/** 内容视图 */
@property (nonatomic,weak) UIView * contentView;


/** 放文字 */
@property (nonatomic,weak) UILabel * textLab;

/** 放图片 */
@property (nonatomic,weak) CALayer *imageVLayer;

/** 图片数组 */
@property (nonatomic,strong) NSArray<NSString*> * imageArr;

@end

@implementation WDAnimationHub

#pragma mark - 单例

static WDAnimationHub * _instance;

+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

-(id)copyWithZone:(NSZone *)zone
{
    return _instance;
}

-(id)mutableCopyWithZone:(NSZone *)zone
{
    return _instance;
}

+(instancetype)sharedHub
{
    if (!_instance)
    {
        _instance = [[WDAnimationHub alloc] init];
    }
    return _instance;
}
#pragma mark - init

-(instancetype)init
{
    if (self = [super init]) {
        [self initHubView];
        [self initContentView];
        [self initImageLayer];
        [self initTextLab];
    }
    return self;
}

-(void)initHubView
{
    _hubView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _hubView.backgroundColor = [UIColor clearColor];
}
-(void)initContentView
{
    
    UIView * contentView =[[UIView alloc]initWithFrame:CGRectMake((_hubView.bounds.size.width-contentView_Width)*0.5,(_hubView.bounds.size.height-contentView_Height)*0.5, contentView_Width, contentView_Height)];
    [_hubView addSubview:contentView];
    
    _contentView = contentView;
    
    _contentView.backgroundColor = [UIColor whiteColor];
    
    _contentView.layer.cornerRadius = 10.0f;
    
    _contentView.clipsToBounds = YES;
}
-(void)initImageLayer
{
    
    CALayer * layer = [CALayer layer];
    
    layer.frame =CGRectMake((_contentView.bounds.size.width-imageVLayer_Width)*0.5,10,imageVLayer_Width, imageVLayer_Height);
    
    [_contentView.layer addSublayer:layer];
    
    _imageVLayer = layer;
    _imageVLayer.backgroundColor = [UIColor clearColor].CGColor;
}

-(void)initTextLab
{
    UILabel * lab = [[UILabel alloc] init];
    [_contentView addSubview:lab];
    _textLab = lab;
    [self addTextLabConstraint];
    
    _textLab.font = [UIFont boldSystemFontOfSize:12];
    _textLab.numberOfLines = 1;
    _textLab.backgroundColor = [UIColor clearColor];
    _textLab.textAlignment = NSTextAlignmentCenter;
    _textLab.textColor = [UIColor blackColor];
}


- (void)addTextLabConstraint{
    
    //禁用antoresizing
    _textLab.translatesAutoresizingMaskIntoConstraints = NO;
    
    //创建约束
    //y方向
    NSLayoutConstraint *LayBottom = [NSLayoutConstraint constraintWithItem:_textLab attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_textLab.superview attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-5];
    
    [_textLab.superview addConstraint:LayBottom];
    
    
    //x方向约束
    NSLayoutConstraint *LayCenterX = [NSLayoutConstraint constraintWithItem:_textLab attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_textLab.superview attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [_textLab.superview addConstraint:LayCenterX];
    
    
    //宽度约束
    NSLayoutConstraint *LayW = [NSLayoutConstraint constraintWithItem:_textLab attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_textLab.superview attribute:NSLayoutAttributeWidth multiplier:1.0 constant:-5];
    
    [_textLab.superview addConstraint:LayW];
}

#pragma mark - public
+(void)showWithText:(NSString*)text
{
    [self showWithText:text imageNames:nil];
}

+(void)show
{
    [self showWithText:nil imageNames:nil];
}
+(void)showWithText:(NSString*)text imageNames:(NSArray<NSString*>*)images
{
    [[WDAnimationHub sharedHub] showWithText:text imageNames:images];
}

+(void)dismiss
{
    [[WDAnimationHub sharedHub] dismiss];
}


#pragma mark - private
-(void)showWithText:(NSString*)text imageNames:(NSArray<NSString*>*)images
{
    _imageArr = images;
    
    if (text.length) {
        
        _textLab.hidden = NO;
        
        _textLab.text = text;
        
        [_textLab sizeToFit];
        
    }else
    {
        _textLab.hidden = YES;
    }
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:_hubView];
    
    [self startAnimation];
}

-(void)startAnimation
{
    NSMutableArray * values = [NSMutableArray array];
    
    [self getValue:values];
    
    if (!values.count)
    {
        _imageArr=@[
                    @"WDAnimationHub.bundle/WifiMan_1",
                    @"WDAnimationHub.bundle/WifiMan_2",
                    @"WDAnimationHub.bundle/WifiMan_3",
                    @"WDAnimationHub.bundle/WifiMan_4",
                    @"WDAnimationHub.bundle/WifiMan_3",
                    @"WDAnimationHub.bundle/WifiMan_2",
                    @"WDAnimationHub.bundle/WifiMan_1"
                    ];
        
        [self getValue:values];
    }
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
    
    [anim setValues:values];
    
    [anim setDuration:values.count *0.5];
    
    anim.repeatCount = MAXFLOAT;
    
    [_imageVLayer addAnimation:anim forKey:@"contents"];
}

-(void)getValue:(NSMutableArray *)values
{
    for (int i = 0; i <_imageArr.count; i++)
    {
        
        UIImage * image = [UIImage imageNamed:_imageArr[i]];
        
        if (image) {
            [values addObject:(id)image.CGImage];
        }
        
    }
}

-(void)dismiss
{
    [_imageVLayer removeAllAnimations];
    
    [_hubView removeFromSuperview];
}

@end

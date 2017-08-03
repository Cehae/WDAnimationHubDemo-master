# WDAnimationHubDemo-master 自定义加载动画

利用单例设计模式和核心动画封装的加载动画，带有文字描述，文字可隐藏，动画图片可更换，使用灵活方便。

效果图：
![效果图](http://img.blog.csdn.net/20170803154614879?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvQ2VoYWU=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

欢迎star
地址：[GitHub](https://github.com/Cehae/WDAnimationHubDemo-master)
博客：[博客](http://blog.csdn.net/Cehae/article/details/76626018)

```
- (IBAction)btnClick:(UIButton *)sender {

//用法1
[WDAnimationHub showWithText:@"正在加载中，请稍后。。。" imageNames:@[
@"WDAnimationHub.bundle/WifiMan_4",
@"WDAnimationHub.bundle/WifiMan_3",
@"WDAnimationHub.bundle/WifiMan_2",
@"WDAnimationHub.bundle/WifiMan_1",
@"WDAnimationHub.bundle/WifiMan_2",
@"WDAnimationHub.bundle/WifiMan_3",
@"WDAnimationHub.bundle/WifiMan_4"
]];

//用法2
[WDAnimationHub show];

//用法3
//打开Debug View Hierarchy可以发现keyWindow上只有一个hub对象
for (int i = 0 ; i < 10; i++) {
[WDAnimationHub showWithText:@"正在努力加载中。。。"];
}

dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

[WDAnimationHub dismiss];

});

}
```





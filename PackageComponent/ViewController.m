//
//  ViewController.m
//  PackageComponent
//
//  Created by zrq on 2018/8/17.
//  Copyright © 2018年 com.baidu.www. All rights reserved.
//

#import "ViewController.h"
#import "SuccessErrorView.h"
#import "UIView+GestureCallBack.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   //成功或失败视图的展示
    [self successErrorView];
    //利用runtime手势点击
    //[self gestureTap];
    
}
#pragma mark --手势点击事件
- (void)gestureTap{
    [self.view addTapGestureRecognizer:^(UITapGestureRecognizer *recognizer, NSString *gestureId) {
        //执行单击事件
        NSLog(@"%@----%@",recognizer,gestureId);
    } tapGestureId:@"TAP"];
}
#pragma mark --成功或失败视图
- (void)successErrorView{
    [self.view configBlank:SuccessNoData hasData:NO hasError:YES reloadButtonBlock:^(id sender) {
        NSLog(@"sender == %@",sender);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

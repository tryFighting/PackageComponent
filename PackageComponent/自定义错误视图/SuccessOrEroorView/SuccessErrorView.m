//
//  SuccessErrorView.m
//  PackageComponent
//
//  Created by zrq on 2018/8/17.
//  Copyright © 2018年 com.baidu.www. All rights reserved.
//

#import "SuccessErrorView.h"
#import <objc/runtime.h>
@interface SuccessErrorView()
/** 加载按钮 */
@property (strong, nonatomic) UIButton *reloadBtn;
/** 图片 */
@property (strong, nonatomic) UIImageView *imageView;
/** 提示 label */
@property (strong, nonatomic) UILabel *tipLabel;
//按钮点击
@property(nonatomic,copy)void(^reloadBlock)(UIButton *sender);
@end
@implementation SuccessErrorView
- (void)configWithType:(BlankViewType)blankType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void (^)(UIButton *))block{
    if (hasData) {
        [self removeFromSuperview];
        return;
    }
    self.reloadBtn.hidden = YES;
    self.tipLabel.hidden = YES;
    self.imageView.hidden = YES;
    self.reloadBlock = block;
    if (hasError) {
        //解析错误
        [self.imageView setImage:[UIImage imageNamed:@"common_noNetWork"]];
        self.tipLabel.text = @"服务器或客户端解析错误";
        self.reloadBtn.hidden = NO;
        self.tipLabel.hidden = NO;
        self.imageView.hidden = NO;
    }else{
        if (blankType == SuccessNoData) {
            //成功了没数据
            [self.imageView setImage:[UIImage imageNamed:@"common_noRecord"]];
            self.tipLabel.text = @"暂无数据";
            self.reloadBtn.hidden = NO;
            self.tipLabel.hidden = NO;
            self.imageView.hidden = NO;
        }else{
            //网络错误
            [self.imageView setImage:[UIImage imageNamed:@"common_noNetWork"]];
            self.tipLabel.text = @"貌似出了点差错";
            self.reloadBtn.hidden = NO;
            self.tipLabel.hidden = NO;
            self.imageView.hidden = NO;
        }
    }
}
- (void)reloadClick:(UIButton *)btn{
    !self.reloadBlock ?:self.reloadBlock(btn);
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2-100, 0, 200, 50)];
        self.tipLabel.numberOfLines = 0;
        self.tipLabel.textAlignment = NSTextAlignmentCenter;
        self.tipLabel.backgroundColor = [UIColor lightGrayColor];
        self.tipLabel.textColor = [UIColor blackColor];
        self.tipLabel.font = [UIFont systemFontOfSize:16];
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width/2-100, 50, 200, 100)];
        
        self.reloadBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width/2-100, 150, 200, 50)];
        [self.reloadBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.reloadBtn setBackgroundColor:[UIColor lightGrayColor]];
//        [self.reloadBtn setBackgroundgColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//        [self.reloadBtn setBackgroundColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
        [self.reloadBtn setTitle:@"点击重新加载" forState:UIControlStateNormal];
        [self.reloadBtn addTarget:self action:@selector(reloadClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.tipLabel];
        [self addSubview:self.imageView];
        [self addSubview:self.reloadBtn];
    }
    return self;
}
@end
static void *BlankViewKey = &BlankViewKey;
@implementation UIView (ConfigBlock)
- (void)setSuccessErrorView:(SuccessErrorView *)successErrorView{
    objc_setAssociatedObject(self, BlankViewKey, successErrorView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (SuccessErrorView *)successErrorView{
    return objc_getAssociatedObject(self, BlankViewKey);
}
- (void)configBlank:(BlankViewType)blankType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void (^)(id))block{
    if (hasData) {
        if (self.successErrorView) {
            self.successErrorView.hidden = YES;
            [self.successErrorView removeFromSuperview];
        }
    }else{
        if (!self.successErrorView) {
            self.successErrorView = [[SuccessErrorView alloc] initWithFrame:CGRectMake(self.frame.size.width/2-100, 200, 200, 200)];
            self.successErrorView.hidden = NO;
            [self addSubview:self.successErrorView];
            [self.successErrorView configWithType:SuccessNoData hasData:hasData hasError:hasError reloadButtonBlock:block];
        }
    }
}
@end























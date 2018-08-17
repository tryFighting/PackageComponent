//
//  SuccessErrorView.h
//  PackageComponent
//
//  Created by zrq on 2018/8/17.
//  Copyright © 2018年 com.baidu.www. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum :NSUInteger {
    SuccessNoData,
    NoNetwork
}BlankViewType;
@interface SuccessErrorView : UIView
- (void)configWithType:(BlankViewType)blankType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(UIButton *sender))block;
@end
@interface UIView(ConfigBlock)
- (void)configBlank:(BlankViewType)blankType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(id sender))block;
@end

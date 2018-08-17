//
//  UIView+GestureCallBack.h
//  PackageComponent
//
//  Created by zrq on 2018/8/17.
//  Copyright © 2018年 com.baidu.www. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface GestureCallbackValues:NSObject
@property(nonatomic,copy)void(^tapCallback)(UITapGestureRecognizer *recognizer,NSString *gestureId);

@property(nonatomic,retain)UIGestureRecognizer *gesture;
@property(nonatomic,retain)NSString *gestureId;
@end
@interface UIView (GestureCallBack)
@property(nonatomic,strong)NSMutableDictionary *gestures;
@property(nonatomic,strong)NSMutableDictionary *gestureKeyHash;
//tap
//- (NSString *)addTapGestureRecognizer:(void(^)(UITapGestureRecognizer *recognizer,NSString *gestureId))tapCallback;
//-(NSString*)addTapGestureRecognizer:(void(^)(UITapGestureRecognizer* recognizer, NSString* gestureId))tapCallback  numberOfTapsRequired:(NSUInteger)numberOfTapsRequired  numberOfTouchesRequired:(NSUInteger)numberOfTouchesRequired;
-(void)addTapGestureRecognizer:(void(^)(UITapGestureRecognizer* recognizer, NSString* gestureId))tapCallback  tapGestureId:(NSString*)tapGestureId;
-(void)addTapGestureRecognizer:(void(^)(UITapGestureRecognizer* recognizer, NSString* gestureId))tapCallback  tapGestureId:(NSString*)tapGestureId  numberOfTapsRequired:(NSUInteger)numberOfTapsRequired  numberOfTouchesRequired:(NSUInteger)numberOfTouchesRequired;
-(void)removeTapGesture:(NSString*)tapGestureId;
-(void)removeAllTapGestures;
-(void)tapHandler:(UITapGestureRecognizer*)recognizer;
@end

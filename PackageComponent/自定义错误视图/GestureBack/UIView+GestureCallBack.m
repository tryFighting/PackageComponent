//
//  UIView+GestureCallBack.m
//  PackageComponent
//
//  Created by zrq on 2018/8/17.
//  Copyright © 2018年 com.baidu.www. All rights reserved.
//

#import "UIView+GestureCallBack.h"
#import <objc/runtime.h>
const NSString *UIView_GestureCallback_gesturesKey = @"UIView_GestureCallback_gesturesKey";
const NSString *UIView_GestureCallback_gestureKeysHashKey = @"UIView_GestureCallback_gestureKeysHashKey";
@implementation GestureCallbackValues
@synthesize tapCallback;
@synthesize gesture,gestureId;
@end
@implementation UIView (GestureCallBack)
@dynamic gestures,gestureKeyHash;

- (void)addTapGestureRecognizer:(void (^)(UITapGestureRecognizer *, NSString *))tapCallback tapGestureId:(NSString *)tapGestureId{
    [self addTapGestureRecognizer:tapCallback tapGestureId:tapGestureId numberOfTapsRequired:1 numberOfTouchesRequired:1];
}
- (void)tapHandler:(UITapGestureRecognizer *)recognizer{
    GestureCallbackValues *v = [self.gestureKeyHash objectForKey:[NSString stringWithFormat:@"%lu",(unsigned long)recognizer.hash]];
    if (v != nil) {
        if (v.tapCallback!=nil) {
            v.tapCallback((UITapGestureRecognizer *)v.gesture, v.gestureId);
        }
    }
}
-(void)addTapGestureRecognizer:(void(^)(UITapGestureRecognizer* recognizer, NSString* gestureId))tapCallback  tapGestureId:(NSString*)tapGestureId  numberOfTapsRequired:(NSUInteger)numberOfTapsRequired  numberOfTouchesRequired:(NSUInteger)numberOfTouchesRequired{
    UIGestureRecognizer *r = [self.gestures objectForKey:tapGestureId];
    if (r != nil) {
        [self removeTapGesture:tapGestureId];
    }
    
    UITapGestureRecognizer *tg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];
    tg.numberOfTapsRequired = numberOfTapsRequired;
    tg.numberOfTouchesRequired = numberOfTouchesRequired;
    
    GestureCallbackValues *v = [GestureCallbackValues new];
    v.gesture = tg;
    v.tapCallback = tapCallback;
    v.gestureId = tapGestureId;
    
    [self.gestureKeyHash setValue:v forKey:[NSString stringWithFormat:@"%lu", (unsigned long)v.gesture.hash]];
    [self.gestures setValue:v forKey:tapGestureId];
    [self addGestureRecognizer:tg];
}
//移除轻按手势
- (void)removeTapGesture:(NSString *)tapGestureId{
    GestureCallbackValues *v = [self.gestures objectForKey:tapGestureId];
    if (v!=nil) {
        [self.gestures removeObjectForKey:tapGestureId];
        [self.gestureKeyHash removeObjectForKey:[NSString stringWithFormat:@"%lu",(unsigned long)v.gesture.hash]];
         [self removeGestureRecognizer:v.gesture];
    }
}
//移除所有
-(void)removeAllTapGestures
{
    NSArray *arr = self.gestures.allValues;
    for (GestureCallbackValues *v in arr) {
        if ([v.gesture isMemberOfClass:[UITapGestureRecognizer class]]) {
            [self removeTapGesture:v.gestureId];
        }
    }
}
//setter // getter
- (void)setGestureKeyHash:(NSMutableDictionary *)gestureKeyHash{
    objc_setAssociatedObject(self, &UIView_GestureCallback_gestureKeysHashKey, gestureKeyHash, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSMutableDictionary *)gestureKeyHash{
   NSMutableDictionary *dict = objc_getAssociatedObject(self, &UIView_GestureCallback_gestureKeysHashKey);
    if (dict == nil) {
        dict = [NSMutableDictionary new];
        self.gestureKeyHash = dict;
    }
    return dict;
}
- (void)setGestures:(NSMutableDictionary *)gestures{
    objc_setAssociatedObject(self, &UIView_GestureCallback_gesturesKey, gestures, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSMutableDictionary *)gestures{
    NSMutableDictionary *dict = objc_getAssociatedObject(self, &UIView_GestureCallback_gesturesKey);
    if (dict == nil) {
        dict = [NSMutableDictionary new];
        self.gestures = dict;
    }
    return dict;
}












@end

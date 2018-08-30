//
//  LoopQueue.h
//  PackageComponent
//
//  Created by zrq on 2018/8/29.
//  Copyright © 2018年 com.baidu.www. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoopQueue : NSObject
- (instancetype)initWithItem:(NSObject *)item addCapcity:(NSUInteger)capacity;
- (instancetype)init;
- (void)enqueue:(NSObject *)item;
- (NSObject *)dequeue;
@end

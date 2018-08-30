//
//  LoopQueue.m
//  PackageComponent
//
//  Created by zrq on 2018/8/29.
//  Copyright © 2018年 com.baidu.www. All rights reserved.
//

#import "LoopQueue.h"
@interface LoopQueue()
@property(nonatomic)int first;
@property(nonatomic)int last;
@property(nonatomic)NSUInteger capacity;
@property(nonatomic)NSMutableArray *elementData;
@end
#define DEFAULT_SIZE 10
@implementation LoopQueue
///入列操作
- (void)enqueue:(NSObject *)item{
    if (![self isFull]) {
        if (_last == _capacity -1 ||_last == -1) {
            self.elementData[0] = item;
            _last = 0;
            if (_first == -1) {
                _first = 0;
            }
        }else{
            self.elementData[++ _last] = item;
        }
    }else{
        self.capacity ++;
        self.last ++;
        [self.elementData addObject:item];
    }
}
///出列操作
- (NSObject *)dequeue{
    if (![self isEmpty]) {
        NSObject *temp = self.elementData[_first];
        if (_first == _last) {
            _last = _first = -1;
        }else if (_first == _capacity -1){
            _first = 0;
        }else{
            _first++;
        }
        return temp;
    }else{
    NSLog(@"Fail:Queue is Empty");
     return nil;
    }
    
}
- (BOOL)isFull{
    return (_first == 0 && _last == _capacity - 1)||_first == _last + 1;
}
- (BOOL)isEmpty{
    return self.first == -1;
}
- (instancetype)initWithItem:(NSObject *)item addCapcity:(NSUInteger)capacity{
    self.first = -1;
    self.last = -1;
    self.capacity = capacity;
    self.elementData = [NSMutableArray arrayWithCapacity:capacity];
    if (item == nil) {
        return self;
    }
    [self.elementData addObject:item];
    return self;
}
- (instancetype)init{
    self = [[LoopQueue alloc] initWithItem:nil addCapcity:DEFAULT_SIZE];
    return self;
}

@end

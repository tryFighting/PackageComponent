//
//  AppDelegate.m
//  PackageComponent
//
//  Created by zrq on 2018/8/17.
//  Copyright © 2018年 com.baidu.www. All rights reserved.
//

#import "AppDelegate.h"
#import "LoopQueue.h"
/*
 逆向传值
 第一种:代理传值
 第二种：通知传值
 第三种：单例传值
 第四种：block传值
 第五种：extern传值
 第六种：KVO传值
 
 iOS 延迟加载
 1.performSelector
 2.NSTimer定时器
 3.NSThread线程的sleep
 4.GCD的after加载
 */
/*
 ViewController生命周期
 - initWithCoder:通过nib文件初始化时触发
 - awakeFromNib:nib文件被加载的时候，会发生一个awakeFromNib消息到nib文件中的每个对象
 - loadView: 开始加载视图控制器自带的view
 - viewDidLoad:视图控制器的view被加载完
 - viewWillAppear:视图控制器view将要显示在window
 - updateViewConstraints:视图控制器的view开始更新
 - viewWillLayoutSubviews 视图控制器view将要更新到视图的位置
 - viewDidLayoutSubviews:控制器view已经更新到视图的位置上
 - viewDidAppear 视图控制器的view已经展示到window上
 - viewwillDisappear 视图控制器view将要从window上消失
 - viewDidDisappear:视图控制器的view已经从window上消失
 */
/*
 KVC底层实现
 当一个对象调用setValue方法时，方法内部会做以下操作
 1.检查是否存在相应的key的set方法，如果存在，就调用set方法
 2.如果set方法不存在，就会查找与key相同名称并且带有下划线的成员变量，如果有，则直接给成员变量属性赋值
 3.如果没有找到_key，就会查找相同名称的属性key，如果有就直接赋值
 4.如果没有找到_key，则调用valueForUndefinedkey方法
 */
/*
 weak实现原理
 Runtime维护了一个weak表，用于存储指向某个对象的所有weak指针。weak表其实是一个hash表，key是指对象的地址，value是weak指针的地址，Value是weak指针的地址数组
 初始化：runtime会调用objc_initWeak函数，初始化一个新的weak指针指向对象的地址
 添加引用时：objc_initWeak函数会调用objc_storeWeak()函数，objc_storeWeak()的作用是更新指针指向，创建对应的
 弱引用表
 释放时，调用clearDeallocating函数，首先根据对象地址获得所有weak指针地址的数组，然后遍历这个数组把其中的数据设为nil,然后遍历这个数组把其中的数据设为nil,最后把这个entry从weak表中删除，最后清理对象的记录
 
 
 weak引用对象被释放时，处理weak指针：
 1.调用objc_release
 2.引用计数为0，所以执行dealloc
 3.在dealloc中，调用了objc_rootDealloc函数
 4.在objc_rootDealloc中，调用了object_dispose函数
 5.调用objc_destructInstance
 6.最后调用objc_clear_deallocating
 */
/*

 死锁必要条件：
 互斥条件:一个资源每次只能被一个进程使用
 请求与保持条件:一个进程因请求资源而阻塞时,对已获得的资源保持不放
 不剥夺条件:进程已获得的资源，在未使用完之前，不能强行剥夺
 循环等待条件:若干进程之间形成一种头尾相接的循环等待资源关系。
 异步和同步针对的是线程，串行与并行针对的是队列，最大的区别是同步线程要阻塞当前线程，必须要等待同步线程中的任务执行完，返回以后，才能继续执行下一任务；而异步线程则不用等待。
 */
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //当应用程序需要加载一张比较大的图片并且使用一次性，那么其实是没必要去缓存这个图片
    UIImage *image = [UIImage imageNamed:@"耗内存"];//图片是要加载到内存上,加载速度快，消耗大量的CPU开销
    //图片是不会缓存的，加载速度慢
    UIImage *image1 = [UIImage imageWithContentsOfFile:@"一次性加载切慢"];
    /**NSCache;
     NSCache类结合了各种自动删除策略，以确保不会占用过多的系统内存，最大限度减少内存的占用
     是线程安全的，我们可以在不同的线程中添加，删除和查询缓存中的对象，而不需要锁定缓存区域
     NSCache是一个容器类，类似于NSDictionary,通过key-value形式存储和查询值，用于临时存储对象
     区别：NSCache的key不必实现copy,字典里的key必须实现copy，NSCache中存储的对象不必实现NSCoding协议，因为毕竟是临时存储，类似于内存缓存，程序退出后就被释放了
    **/
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

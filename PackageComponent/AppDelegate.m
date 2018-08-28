//
//  AppDelegate.m
//  PackageComponent
//
//  Created by zrq on 2018/8/17.
//  Copyright © 2018年 com.baidu.www. All rights reserved.
//

#import "AppDelegate.h"

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

//
//  JLRouter.m
//  PackageComponent
//
//  Created by zrq on 2018/11/27.
//  Copyright © 2018年 com.baidu.www. All rights reserved.
//

#import "JLRouter.h"
///初始化常量 ---通配符
static NSString *const JLRouterWildcard = @"*";
///特殊字符
static NSString *JLSpecialCharcters = @"/?&.";

static NSString *const JLRouterCoreKey = @"JLRouterCore";
static NSString *const JLRouterCoreBlockKey = @"JLRouterCoreBlock";
static NSString *const JLRounterCoreTypeKey = @"JLRouterCoreType";

NSString *const JLRouterParameterURLKey = @"JLRouterParameterURL";
typedef NS_ENUM(NSInteger,JLRouterType) {
    JLRouterTypeDefault = 0,
    JLRounterTypeObject = 1,
    JLRouterTypeCallback = 2,
};
@interface JLRouter()
@property(nonatomic,strong)NSMutableDictionary *routes;

@property(nonatomic,strong)JLRouterUnregisterURLHandler routerUnregisterURLHandler;
@end
@implementation JLRouter
+ (instancetype)sharedInstance{
    static JLRouter *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}
#pragma mark --注册url public methods
+ (void)registerRouteURL:(NSString *)routeURL handler:(JLRouterHandle)handlerBlock{
    [[self sharedInstance] addRouteURL:routeURL handler:handlerBlock];
}
#pragma getter lazy load
- (NSMutableDictionary *)routes{
    if (!_routes) {
        _routes = [[NSMutableDictionary alloc] init];
    }
    return _routes;
}
#pragma mark ---private methods
- (void)addRouteURL:(NSString *)routeUrl handler:(JLRouterHandle)handlerBlock{
    NSMutableDictionary *subRoutes = [self addURLPattern:routeUrl];
    if (handlerBlock && subRoutes) {
        NSDictionary *coreDic = @{JLRouterCoreBlockKey:[handlerBlock copy],JLRounterCoreTypeKey:@(JLRouterTypeDefault)};
        subRoutes[JLRouterCoreKey] = coreDic;
    }
}
- (NSMutableDictionary *)addURLPattern:(NSString *)URLPattern{
    NSArray *pathComponents = [self pathComponentsFromURL:URLPattern];
    NSMutableDictionary *subRoutes = self.routes;
    for (NSString *pathComponent in pathComponents) {
        if (![subRoutes objectForKey:pathComponent]) {
            subRoutes[pathComponent] = [[NSMutableDictionary alloc] init];
        }
        subRoutes = subRoutes[pathComponent];
    }
    return subRoutes;
}
- (NSArray *)pathComponentsFromURL:(NSString *)URL{
    NSMutableArray *pathComponents = [NSMutableArray array];
    if ([URL rangeOfString:@"://"].location != NSNotFound) {
        NSArray *pathSegments = [URL componentsSeparatedByString:@"://"];
        [pathComponents addObject:pathSegments[0]];
        for (NSInteger idx = 1; idx < pathSegments.count; idx ++) {
            if (idx == 1) {
                URL = [pathSegments objectAtIndex:idx];
            }else{
                URL = [NSString stringWithFormat:@"%@://%@",URL,[pathSegments objectAtIndex:idx]];
            }
        }
    }
    if ([URL hasPrefix:@":"]) {
        if ([URL rangeOfString:@"/"].location != NSNotFound) {
            NSArray *pathSegments = [URL componentsSeparatedByString:@"/"];
            [pathComponents addObject:pathSegments[0]];
        }else{
            [pathComponents addObject:URL];
        }
    }else{
        for (NSString *pathComponent in [[NSURL URLWithString:URL] pathComponents]) {
            if ([pathComponent isEqualToString:@"/"]) continue;
            if ([[pathComponent substringToIndex:1] isEqualToString:@"?"]) break;
            [pathComponents addObject:pathComponent];
        }
    }
    return [pathComponents copy];
}
@end


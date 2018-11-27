//
//  JLRouter.h
//  PackageComponent
//
//  Created by zrq on 2018/11/27.
//  Copyright © 2018年 com.baidu.www. All rights reserved.
//

#import <Foundation/Foundation.h>
///未初始化的常量
extern NSString *const JLRouterParameterURLKey;
/**
 无返回值 路由block
 
 @param routerParameters <#routerParameters description#>
 */
typedef void(^JLRouterHandle)(NSDictionary *routerParameters);
/**
 有返回值的路由block
 
 @param routerParameters <#routerParameters description#>
 @return <#return value description#>
 */
typedef id(^JLObjectRouterHandler)(NSDictionary *routerParameters);

typedef void(^JLRouterCallback)(id callbackObjc);
typedef void(^JLCallbackRouterHandler)(NSDictionary *routerParameters,JLRouterCallback targetCallback);

typedef void(^JLRouterUnregisterURLHandler)(NSString *routerURL);
NS_ASSUME_NONNULL_BEGIN

@interface JLRouter : NSObject
/**
 注册路由url

 @param routeURL 要注册的URL
 @param handlerBlock URL被Route后的回调
 */
+ (void)registerRouteURL:(NSString *)routeURL handler:(JLRouterHandle)handlerBlock;
/**
 注册URL.可以返回一个Object

 @param routeURL 要注册的URL
 @param handlerBlock 被Route后的回调，可在回调中返回一个Object
 */
+ (void)registerObjectRouteURL:(NSString *)routeURL handler:(JLObjectRouterHandler)handlerBlock;

/**
 注册URL,可异步返回一个Object

 @param routeURL 路由url
 @param handlerBlock 可异步返回一个object
 */
+ (void)registerCallbackRouteURL:(NSString *)routeURL handler:(JLCallbackRouterHandler)handlerBlock;

/**
 判断URL是否可被注册

 @param URL <#URL description#>
 @return <#return value description#>
 */
+ (BOOL)canRouteURL:(NSString *)URL;

/**
 注册一个URL

 @param URL <#URL description#>
 */
+ (void)routeURL:(NSString *)URL;

/**
 注册一个URL,并带上额外的参数

 @param URL <#URL description#>
 @param parameters <#parameters description#>
 */
+ (void)routeURL:(NSString *)URL withParameters:(NSDictionary<NSString *,id >*)parameters;
/**
 路由一个URL,可获得返回的Object

 @param URL <#URL description#>
 @return <#return value description#>
 */
+ (id)routeObjectURL:(NSString *)URL;
/**
 路由一个URL，并带上相关的参数。可范湖Object

 @param URL <#URL description#>
 @param parameters <#parameters description#>
 @return <#return value description#>
 */
+ (id)routeObjectURL:(NSString *)URL withParameters:(NSDictionary<NSString *,id>*)parameters;

/**
 路由一个URL,可以异步回调返回一个Object

 @param URL <#URL description#>
 @param targetCallBack <#targetCallBack description#>
 */
+ (void)routeCallbackURL:(NSString *)URL targetCallback:(JLRouterCallback)targetCallBack;
/**
 路由一个URL，并带上额外参数，可异步回调以返回一个Object

 @param URL <#URL description#>
 @param parameters <#parameters description#>
 @param targetCallBack <#targetCallBack description#>
 */
+ (void)routeCallbackURL:(NSString *)URL withParameters:(NSDictionary<NSString *,id>*)parameters targetCallback:(JLRouterCallback)targetCallBack;


/**
 路由一个未注册 URL回调

 @param handler <#handler description#>
 */
+ (void)routeUnregisterURLHandler:(JLRouterUnregisterURLHandler)handler;

/**
 取消注册某个URL

 @param URL <#URL description#>
 */
+ (void)unregisterRouteURL:(NSString *)URL;
/**
 取消注册所有URL
 */
+ (void)unregisterAllRoutes;
/**
 是否显示log

 @param enable <#enable description#>
 */
+ (void)setLogEnabled:(BOOL)enable;
@end

NS_ASSUME_NONNULL_END

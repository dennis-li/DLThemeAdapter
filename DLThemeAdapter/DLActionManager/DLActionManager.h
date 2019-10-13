//
//  DLActionManager.h
//  QYShortVideo
//
//  Created by 李旭 on 2019/8/21.
//  Copyright © 2019 iQiYi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^DLActionManagerBlock)(id _Nullable actionInfo);

NS_ASSUME_NONNULL_BEGIN

@class DLActionInfo;
@interface DLActionManager : NSObject


- (instancetype)initWithNotification:(NSString *) notificationName;

/*
 *监听到通知后会执行info.block，
 *info.keyPath用于区分唯一需要执行的操作，避免同一个target重复执行同一操作
 *info.actionAdapterBlock为nil，即可撤销之前的info
 */
- (void) addTarget:(id) target actionInfo:(DLActionInfo *) info;

/*
 *注册通知
 *该方法会先取消之前的通知(如果有)，并且清理addTarget:themeInfo:绑定的所有target
 *如果是new出来的当前对象，可用该方法注册通知
 */
- (void) registerNotification:(NSString *) notificationName;

/*
 *取消通知
 *取消之前的通知(如果有)，并且清理addTarget:themeInfo:绑定的所有target
 */
- (void) cancelRegistration;

@end


@interface DLActionInfo : NSObject

/*
 *用于标识同一对象的唯一事件
 *切换主题时，同一对象可能会触发多个事件
 *比如button会触发更新image，更新backgroundImage两个事件
 **/
@property (nonatomic ,copy) NSString *keyPath;

//如果是nil，则会撤销之前的info
@property (nonatomic ,copy) DLActionManagerBlock actionManagerBlock;

@end

NS_ASSUME_NONNULL_END

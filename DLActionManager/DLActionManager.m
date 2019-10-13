//
//  DLActionManager.m
//  QYShortVideo
//
//  Created by 李旭 on 2019/8/21.
//  Copyright © 2019 iQiYi. All rights reserved.
//

#import "DLActionManager.h"
#import <pthread/pthread.h>


@interface DLActionManager ()

@end

@implementation DLActionManager
{
    NSMapTable<id, NSMutableSet<DLActionInfo *> *> *_objectInfosMap;
    pthread_mutex_t _mutex;
}

- (void)dealloc
{
    [self _clear];
    pthread_mutex_destroy(&_mutex);
}

- (void) registerNotification:(NSString *)notificationName
{
    [self _clear];
    [self _registerNotification:notificationName];
}

- (void) cancelRegistration
{
    [self _clear];
}

- (instancetype) initWithNotification:(NSString *)notificationName
{
    self = [super init];
    if (self) {
        _objectInfosMap = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsWeakMemory|NSPointerFunctionsObjectPointerPersonality valueOptions:NSPointerFunctionsStrongMemory|NSPointerFunctionsObjectPersonality capacity:0];
        pthread_mutex_init(&_mutex, NULL);
        [self _registerNotification:notificationName];
    }
    
    return self;
}

- (void) listen:(NSNotification *) notification
{
    pthread_mutex_lock(&_mutex);
    NSMapTable *objectInfoMaps = [_objectInfosMap copy];
    pthread_mutex_unlock(&_mutex);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        for (id object in objectInfoMaps) {
            NSMutableSet *infos = [objectInfoMaps objectForKey:object];
            [infos enumerateObjectsUsingBlock:^(DLActionInfo *info, BOOL *stop) {
                if (info.actionManagerBlock) {
                    info.actionManagerBlock(notification.userInfo);
                }
            }];
        }
    });
    
}

- (void) addTarget:(id) target actionInfo:(DLActionInfo *) info
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self _addTarget:target actionInfo:info];
    });
}

- (void) _addTarget:(id) target actionInfo:(DLActionInfo *) info
{
    if (!target || !info) {
        return;
    }
    
    pthread_mutex_lock(&_mutex);
    
    NSMutableSet *infos = [_objectInfosMap objectForKey:target];
    
    //这里是根据type找到找到相同的info
    DLActionInfo *existingInfo = [infos member:info];
    if (nil != existingInfo) {
        //撤销之前的info
        if (!info.actionManagerBlock) {
            [infos removeObject:existingInfo];
        }
        
        if (0 == infos.count) {
            [_objectInfosMap removeObjectForKey:target];
        }
        pthread_mutex_unlock(&_mutex);
        return;
    }
    
    if (nil == infos) {
        infos = [NSMutableSet set];
        [_objectInfosMap setObject:infos forKey:target];
    }
    
    [infos addObject:info];
    
    pthread_mutex_unlock(&_mutex);
}

- (void) _clear
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_objectInfosMap removeAllObjects];
}

- (void) _registerNotification:(NSString *)notificationName
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(listen:) name:notificationName object:nil];
}

@end

@implementation DLActionInfo

- (NSUInteger)hash
{
    return [_keyPath hash];
}

- (BOOL)isEqual:(id)object
{
    if (nil == object) {
        return NO;
    }
    if (self == object) {
        return YES;
    }
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    return [_keyPath isEqualToString:((DLActionInfo *)object).keyPath];
}

@end

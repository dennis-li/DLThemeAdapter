//
//  DLThemeAdapter.m
//  Dennis
//
//  Created by 李旭 on 2019/10/3.
//  Copyright © 2019 李旭. All rights reserved.
//

#import "DLThemeAdapter.h"
#import "DLActionManager.h"

@interface DLThemeAdapter ()

@property (nonatomic ,strong) DLActionManager *actionManager;

@end

@implementation DLThemeAdapter

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static DLThemeAdapter *adapter = nil;
    dispatch_once(&onceToken, ^{
        adapter = [DLThemeAdapter new];
    });
    return adapter;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _actionManager = [[DLActionManager alloc] initWithNotification:kDLThemeNotificationName];
    }
    
    return self;
}

- (void) addTarget:(id<DLThemeAdapterProtocol>) target
         parameter:(id) param
        forKeyPath:(NSString *) keyPath;

{
    __weak id<DLThemeAdapterProtocol> weakTarget = target;
    //负责切换主题的block
    DLActionManagerBlock block = ^(id actionInfo) {
        __strong id<DLThemeAdapterProtocol> strongTarget = weakTarget;
        if (!strongTarget) {
            return ;
        }
        
        if ([strongTarget respondsToSelector:@selector(dl_updateThemeWithParameter:keyPath:)]) {
            [strongTarget dl_updateThemeWithParameter:param keyPath:keyPath];
        }
    };
    
    /*
     *切换theme后需要执行block
     *info负责保存block
     *keyPath区分不同的block，确保同一个target的某个操作(keyPath)对应唯一的block
     */
    DLActionInfo *info = [DLActionInfo new];
    info.keyPath = keyPath;
    if (param) {
        info.actionManagerBlock = block;
    }
    
    //添加到actionManager
    [_actionManager addTarget:target actionInfo:info];
}

- (void) addTarget:(id<DLThemeAdapterProtocol>)target
         parameter:(id)param
       forSelector:(SEL)selector
{
    __weak id<DLThemeAdapterProtocol> weakTarget = target;
    //负责切换主题的block
    DLActionManagerBlock block = ^(id actionInfo) {
        __strong id<DLThemeAdapterProtocol> strongTarget = weakTarget;
        if (!strongTarget) {
            return ;
        }
        
        if ([strongTarget respondsToSelector:@selector(dl_updateThemeWithParameter:keyPath:)]) {
            [strongTarget dl_updateThemeWithParameter:param selector:selector];
        }
    };
    
    /*
     *切换theme后需要执行block
     *info负责保存block
     *keyPath区分不同的block，确保同一个target的某个操作(keyPath)对应唯一的block
     */
    DLActionInfo *info = [DLActionInfo new];
    info.keyPath = NSStringFromSelector(selector);
    if (param) {
        info.actionManagerBlock = block;
    }
    
    //添加到actionManager
    [_actionManager addTarget:target actionInfo:info];
}

- (void) addTarget:(id<DLThemeAdapterProtocol>)target
         parameter:(id)param
       forSelector:(SEL) selector
         withValue:(NSInteger)value
{
    __weak id<DLThemeAdapterProtocol> weakTarget = target;
    //负责切换主题的block
    DLActionManagerBlock block = ^(id actionInfo) {
        __strong id<DLThemeAdapterProtocol> strongTarget = weakTarget;
        if (!strongTarget) {
            return ;
        }
        
        if ([strongTarget respondsToSelector:@selector(dl_updateThemeWithParameter:selector:withValue:)]) {
            [strongTarget dl_updateThemeWithParameter:param selector:selector withValue:value];
        }
    };
    
    /*
     *切换theme后需要执行block
     *info负责保存block
     *keyPath区分不同的block，确保同一个target的某个操作(keyPath)对应唯一的block
     */
    DLActionInfo *info = [DLActionInfo new];
    info.keyPath = [NSString stringWithFormat:@"%@%@",NSStringFromSelector(selector),@(value)];
    if (param) {
        info.actionManagerBlock = block;
    }
    
    //添加到actionManager
    [_actionManager addTarget:target actionInfo:info];
}

- (void) addTarget:(id<DLThemeAdapterProtocol>)target
         parameter:(id)param
       forSelector:(nonnull SEL)selector
        withObject:(nonnull id)object
{
    __weak id<DLThemeAdapterProtocol> weakTarget = target;
    //负责切换主题的block
    DLActionManagerBlock block = ^(id actionInfo) {
        __strong id<DLThemeAdapterProtocol> strongTarget = weakTarget;
        if (!strongTarget) {
            return ;
        }
        
        if ([strongTarget respondsToSelector:@selector(dl_updateThemeWithParameter:selector:withObject:)]) {
            [strongTarget dl_updateThemeWithParameter:param selector:selector withObject:object];
        }
    };
    
    /*
     *切换theme后需要执行block
     *info负责保存block
     *keyPath区分不同的block，确保同一个target的某个操作(keyPath)对应唯一的block
     */
    DLActionInfo *info = [DLActionInfo new];
    info.keyPath = [NSString stringWithFormat:@"%@%@",NSStringFromSelector(selector),object];
    if (param) {
        info.actionManagerBlock = block;
    }
    
    //添加到actionManager
    [_actionManager addTarget:target actionInfo:info];
}

@end

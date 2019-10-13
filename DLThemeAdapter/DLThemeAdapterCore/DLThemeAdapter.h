//
//  DLThemeAdapter.h
//  Dennis
//
//  Created by 李旭 on 2019/10/3.
//  Copyright © 2019 李旭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLThemeConfig.h"

@protocol DLThemeAdapterProtocol <NSObject>

@optional
- (void) dl_updateThemeWithParameter:(id _Nonnull) params
                             keyPath:(NSString *_Nullable) keyPath;

- (void) dl_updateThemeWithParameter:(id _Nonnull) params
                            selector:(SEL _Nonnull ) selector;

- (void) dl_updateThemeWithParameter:(id _Nonnull) params
                            selector:(SEL _Nonnull ) selector
                           withValue:(NSInteger) value;

- (void) dl_updateThemeWithParameter:(id _Nonnull) params
                            selector:(SEL _Nonnull ) selector
                          withObject:(id _Nonnull )object;

@end


NS_ASSUME_NONNULL_BEGIN

@interface DLThemeAdapter : NSObject

+ (instancetype)sharedInstance;

- (void) addTarget:(id<DLThemeAdapterProtocol>) target
         parameter:(id) param
        forKeyPath:(NSString *) keyPath;

- (void) addTarget:(id<DLThemeAdapterProtocol>) target
         parameter:(id) param
       forSelector:(SEL) selector;

- (void) addTarget:(id<DLThemeAdapterProtocol>) target
         parameter:(id) param
       forSelector:(SEL) selector
        withValue:(NSInteger) value;

- (void) addTarget:(id<DLThemeAdapterProtocol>) target
         parameter:(id) param
       forSelector:(SEL) selector
        withObject:(id)object;
@end

NS_ASSUME_NONNULL_END

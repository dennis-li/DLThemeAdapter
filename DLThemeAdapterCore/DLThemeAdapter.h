//
//  DLThemeAdapter.h
//  Dennis
//
//  Created by 李旭 on 2019/10/3.
//  Copyright © 2019 李旭. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DLThemeKeyPath(KEYPATH) \
@(((void)(NO && ((void)KEYPATH, NO)), \
({ const char *dlthemekeypath = strchr(#KEYPATH, '.'); NSCAssert(dlthemekeypath, @"Provided key path is invalid."); dlthemekeypath + 1; })))

@protocol DLThemeAdapterProtocol <NSObject>

@optional
- (void) dl_updateThemeWithParameter:(id _Nonnull) params keyPath:(NSString *_Nullable) keyPath;

- (void) dl_updateThemeWithParameter:(id _Nonnull) params
                             keyPath:(NSString *_Nullable) keyPath
                           withValue:(NSInteger) value;

- (void) dl_updateThemeWithParameter:(id _Nonnull) params
                             keyPath:(NSString *_Nullable) keyPath
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
        forKeyPath:(NSString *) keyPath
        withValue:(NSInteger) value;

- (void) addTarget:(id<DLThemeAdapterProtocol>) target
         parameter:(id) param
        forKeyPath:(NSString *) keyPath
        withObject:(id)object;
@end

NS_ASSUME_NONNULL_END

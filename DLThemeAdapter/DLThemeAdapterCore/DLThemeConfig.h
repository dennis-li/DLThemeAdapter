//
//  DLThemeConfig.h
//  Example
//
//  Created by 李旭 on 2019/10/13.
//  Copyright © 2019 李旭. All rights reserved.
//

#ifndef DLThemeConfig_h
#define DLThemeConfig_h

static NSString *const kDLThemeNotificationName   = @"kDLThemeNotificationName";

//当前主题的编号
static NSString *const kDLThemeIdentifier   = @"kDLThemeIdentifier";

#define DLThemeKeyPath(KEYPATH) \
@(((void)(NO && ((void)KEYPATH, NO)), \
({ const char *dlthemekeypath = strchr(#KEYPATH, '.'); NSCAssert(dlthemekeypath, @"Provided key path is invalid."); dlthemekeypath + 1; })))

#endif /* DLThemeConfig_h */

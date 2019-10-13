//
//  NSObject+DLThemeTool.h
//  Dennis
//
//  Created by 李旭 on 2019/10/13.
//  Copyright © 2019 李旭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLThemeAdapter.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (DLThemeTool) <DLThemeAdapterProtocol>

- (void) dl_setThemes:(NSArray *) themes forKeyPath:(NSString *) keyPath;

//value是第二个参数(不算self，_cmd) 比如UIButton的@selector(setTitleColor:forState:)中的state参数
- (void)dl_setThemes:(NSArray *)themes forSelector:(SEL)selector withValue:(NSInteger) value;

#warning 请注意selector返回值为对象时，可能出现内存泄露
- (void)dl_setThemes:(NSArray *)themes forSelector:(SEL)selector withObject:(id)object;

@end

NS_ASSUME_NONNULL_END

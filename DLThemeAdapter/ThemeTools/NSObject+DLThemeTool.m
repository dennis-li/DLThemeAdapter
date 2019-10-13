//
//  NSObject+DLThemeTool.m
//  Dennis
//
//  Created by 李旭 on 2019/10/13.
//  Copyright © 2019 李旭. All rights reserved.
//

#import "NSObject+DLThemeTool.h"

@implementation NSObject (DLThemeTool)

- (void) dl_setThemes:(NSArray *) themes forKeyPath:(NSString *) keyPath
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[DLThemeAdapter sharedInstance] addTarget:self parameter:themes forKeyPath:keyPath];
    });
    
    [self dl_updateThemeWithParameter:themes keyPath:keyPath];
}

- (void)dl_setThemes:(NSArray *)themes forSelector:(SEL)selector withValue:(NSInteger) value
{
    NSString *keyPath = NSStringFromSelector(selector);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[DLThemeAdapter sharedInstance] addTarget:self parameter:themes forKeyPath:keyPath withValue:value];
    });
    
    [self dl_updateThemeWithParameter:themes keyPath:keyPath withValue:value];
}

- (void) dl_setThemes:(NSArray *)themes forSelector:(SEL)selector withObject:(id)object
{
    NSString *keyPath = NSStringFromSelector(selector);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[DLThemeAdapter sharedInstance] addTarget:self parameter:themes forKeyPath:keyPath withObject:object];
    });
    
    [self dl_updateThemeWithParameter:themes keyPath:keyPath withObject:object];
}

#pragma mark - DLThemeAdapterProtocol
- (void) dl_updateThemeWithParameter:(id) params keyPath:(NSString *) keyPath
{
    NSArray *themes = params;
    if (![themes isKindOfClass:[NSArray class]] || ![keyPath isKindOfClass:[NSString class]]) {
        return;
    }
    
    NSNumber *identifier = [[NSUserDefaults standardUserDefaults] objectForKey:@"TestIdentifier"];

    
    NSInteger index = identifier.integerValue;
    if (index < 0 || index >= themes.count) {
        return;
    }
    
    [self setValue:themes[index] forKeyPath:keyPath];

}

- (void) dl_updateThemeWithParameter:(id)params keyPath:(NSString *)keyPath withValue:(NSInteger)value
{
    
    NSArray *themes = params;
    if (![themes isKindOfClass:[NSArray class]] || ![keyPath isKindOfClass:[NSString class]]) {
        return;
    }
    
    NSNumber *identifier = [[NSUserDefaults standardUserDefaults] objectForKey:@"TestIdentifier"];

    
    NSInteger index = identifier.integerValue;
    if (index < 0 || index >= themes.count) {
        return;
    }
    
    SEL selector = NSSelectorFromString(keyPath);
    if (![self respondsToSelector:selector]) {
        return;
    }
    
    NSInvocation * invocation = [NSInvocation invocationWithMethodSignature:[[self class] instanceMethodSignatureForSelector:selector]];
    [invocation setSelector:selector];
    [invocation setTarget:self];
    id theme = themes[index];
    NSInteger argument = value;
    [invocation setArgument:&theme atIndex:2];
    [invocation setArgument:&argument atIndex:3];
    [invocation invoke];
}

- (void) dl_updateThemeWithParameter:(id)params keyPath:(NSString *)keyPath withObject:(id)object
{
    
    NSArray *themes = params;
    if (![themes isKindOfClass:[NSArray class]] || ![keyPath isKindOfClass:[NSString class]]) {
        return;
    }
    
    NSNumber *identifier = [[NSUserDefaults standardUserDefaults] objectForKey:@"TestIdentifier"];

    
    NSInteger index = identifier.integerValue;
    if (index < 0 || index >= themes.count) {
        return;
    }
    
    SEL selector = NSSelectorFromString(keyPath);
    
    if ([self respondsToSelector:selector]) {
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:selector withObject:themes[index] withObject:object];
#pragma clang diagnostic pop
        
    }
}

@end

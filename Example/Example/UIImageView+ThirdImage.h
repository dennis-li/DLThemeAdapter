//
//  UIImageView+ThirdImage.h
//  Example
//
//  Created by 李旭 on 2019/10/13.
//  Copyright © 2019 李旭. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (ThirdImage)

//这里的NSString换成NSURL也是一样的
- (void) dl_setImageWithName:(NSString *) imageName;

@end

NS_ASSUME_NONNULL_END

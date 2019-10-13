//
//  UIImageView+ThirdImage.m
//  Example
//
//  Created by 李旭 on 2019/10/13.
//  Copyright © 2019 李旭. All rights reserved.
//

#import "UIImageView+ThirdImage.h"

@implementation UIImageView (ThirdImage)

- (void) dl_setImageWithName:(NSString *)imageName
{
    self.image = [UIImage imageNamed:imageName];
}

@end

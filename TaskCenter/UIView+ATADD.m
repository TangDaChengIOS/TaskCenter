//
//  UIView+ATADD.m
//  TaskCenter
//
//  Created by 汤达成 on 18/2/1.
//  Copyright © 2018年 Tang. All rights reserved.
//

#import "UIView+ATADD.h"

@implementation UIView (ATADD)

-(CGFloat)max_X{
    return CGRectGetMaxX(self.frame);
}

-(CGFloat)max_Y{
    return CGRectGetMaxY(self.frame);
}

-(CGFloat)height{
    return self.frame.size.height;
}
-(CGFloat)width{
    return self.frame.size.width;
}

-(void)setHeight:(CGFloat)height{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

-(void)setWidth:(CGFloat)width{
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}

-(void)setY:(CGFloat)y{
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}


@end

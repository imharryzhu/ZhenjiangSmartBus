//
//  UIView+ZH.m
//  Treitel
//
//  Created by 朱辉 on 16/2/8.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import "UIView+ZH.h"

@implementation UIView (ZH)

-(float)width{
    return self.bounds.size.width;
}

-(void)setWidth:(float)width{
    CGRect rect = self.bounds;
    rect.size.width = width;

    self.bounds = rect;
}

- (float)height{
    return self.bounds.size.height;
}

-(void)setHeight:(float)height{
    CGRect rect = self.bounds;
    rect.size.height = height;
    
    self.bounds = rect;
}

-(float)x{
    return self.frame.origin.x;
}

-(void)setX:(float)x{
    CGRect rect = self.frame;
    rect.origin.x = x;
    
    self.frame = rect;
}

-(float)y{
    return self.frame.origin.y;
}

-(void)setY:(float)y{
    CGRect rect = self.frame;
    rect.origin.y = y;
    
    self.frame = rect;
}



@end

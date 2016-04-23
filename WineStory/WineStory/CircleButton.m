//
//  CircleButton.m
//  WineStory
//
//  Created by 游峰 on 16/4/23.
//  Copyright © 2016年 yf. All rights reserved.
//

#import "CircleButton.h"

@implementation CircleButton

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.layer.borderColor = [UIColor redColor].CGColor;
    self.layer.borderWidth = 2.0;
    self.layer.cornerRadius = self.frame.size.width * 0.5;
    self.layer.masksToBounds = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

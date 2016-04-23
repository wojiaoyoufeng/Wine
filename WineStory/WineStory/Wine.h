//
//  Wine.h
//  WineStory
//
//  Created by 游峰 on 16/4/23.
//  Copyright © 2016年 yf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Wine : NSObject
@property (copy, nonatomic) NSString *money;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *image;

/** 数量 */
@property (nonatomic, assign) int count;



@end

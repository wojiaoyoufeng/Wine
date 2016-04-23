//
//  WineCell.h
//  WineStory
//
//  Created by 游峰 on 16/4/23.
//  Copyright © 2016年 yf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CircleButton,Wine,WineCell;

//@protocol WineCellDelegate <NSObject>
//@optional
//- (void)wineCellDidClickPlusButton:(WineCell *)wineCell;
//- (void)wineCellDidClickMinusButton:(WineCell *)wineCell;
//@end

@interface WineCell : UITableViewCell
@property (strong, nonatomic) Wine * wine;
//@property (weak, nonatomic) id<WineCellDelegate> delegate;

@end

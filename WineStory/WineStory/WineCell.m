//
//  WineCell.m
//  WineStory
//
//  Created by 游峰 on 16/4/23.
//  Copyright © 2016年 yf. All rights reserved.
//

#import "WineCell.h"
#import "Wine.h"
#import "CircleButton.h"

@interface WineCell ()
@property (weak, nonatomic) IBOutlet UIImageView *wineImageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet CircleButton *plusButton;
@property (weak, nonatomic) IBOutlet CircleButton *minusButton;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation WineCell

- (void)setWine:(Wine *)wine
{
    _wine = wine;
    
    self.wineImageView.image = [UIImage imageNamed:wine.image];
    self.nameLabel.text = wine.name;
    self.countLabel.text = [NSString stringWithFormat:@"%d", wine.count];
    self.priceLabel.text = wine.money;
    self.minusButton.enabled = (wine.count > 0);
}

- (IBAction)minusClick:(CircleButton *)sender {
    
    self.wine.count--;
    self.countLabel.text = [NSString stringWithFormat:@"%d", self.wine.count];
    if (self.wine.count <= 0) {
        self.minusButton.enabled = NO;
    }
//    if([self.delegate respondsToSelector:@selector(wineCellDidClickMinusButton:)])
//    {
//        [self.delegate wineCellDidClickMinusButton:self];
//    }
    
    //通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"minusClickNotification" object:self];
}

- (IBAction)plusClick:(CircleButton *)sender {
    
    self.wine.count++;
    self.minusButton.enabled = YES;
    self.countLabel.text = [NSString stringWithFormat:@"%d",self.wine.count];
    
//    if([self.delegate respondsToSelector:@selector(wineCellDidClickPlusButton:)])
//    {
//        [self.delegate wineCellDidClickPlusButton:self];
//    }
    
    //通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"plusClickNotification" object:self];
}



//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

@end

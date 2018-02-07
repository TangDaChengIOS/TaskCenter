//
//  SellResultTableViewCell.h
//  TaskCenter
//
//  Created by 汤达成 on 18/2/1.
//  Copyright © 2018年 Tang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kSellResultTableViewCellReuseID @"kSellResultTableViewCellReuseID"
@interface SellResultTableViewCell : UITableViewCell

@property (nonatomic,assign) BOOL isTopCell;
-(void)setCell:(BOOL)isSelected;
@end

//
//  MsgListTableViewCell.m
//  TaskCenter
//
//  Created by 汤达成 on 18/1/23.
//  Copyright © 2018年 Tang. All rights reserved.
//

#import "MsgListTableViewCell.h"

@interface MsgListTableViewCell ()

@property (nonatomic,strong) UILabel * leftLab;
@property (nonatomic,strong) UIView * splitLine;
@property (nonatomic,strong) UILabel * rightLab;

@end

@implementation MsgListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = TabBackColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _leftLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 120, 15)];
        _leftLab.textColor = SecTextColor;
        _leftLab.font = kFont(12);
        [self.contentView addSubview:_leftLab];
        
        _splitLine = [[UIView alloc]initWithFrame:CGRectMake(130, 0, 1, 35)];
        _splitLine.backgroundColor = SpliteColor;
        [self.contentView addSubview:_splitLine];
        
        _rightLab = [[UILabel alloc]initWithFrame:CGRectMake(131, 10, MAXWIDTH - 20 - CGRectGetMaxX(_splitLine.frame), 15)];
        _rightLab.textColor = MainTextColor;
        _rightLab.font = kFont(12);
        [self.contentView addSubview:_rightLab];
        
        UIView * boomLine = [[UIView alloc]initWithFrame:CGRectMake(0, 34,MAXWIDTH - 20, 1)];
        boomLine.backgroundColor = SpliteColor;
        [self.contentView addSubview:boomLine];
    }
    return self;
}

-(void)setShowStyle:(CellShowStyle)showStyle
{
    _showStyle = showStyle;
    if (showStyle == CellShowStyleLeftShort) {
        _leftLab.frame = CGRectMake(10, 10, 105, 15);
        _splitLine.frame = CGRectMake(120, 0, 1, 35);
        _rightLab.frame = CGRectMake(130, 10, MAXWIDTH - 20 - 135, 15);
    }else{
        _leftLab.frame = CGRectMake(10, 10, MAXWIDTH - 20 - 120, 15);
        _splitLine.frame = CGRectMake(MAXWIDTH - 20 - 105, 0, 1, 35);
        _rightLab.frame = CGRectMake(MAXWIDTH - 20 - 95, 10, 90, 15);
    }
}

-(void)setCellWith:(NSString *)leftStr isNeedRight:(BOOL)isNeedRight rightStr:(NSString *)rightStr{
    _splitLine.hidden = _rightLab.hidden = !isNeedRight;
    _leftLab.text = leftStr;
    _rightLab.text = rightStr;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

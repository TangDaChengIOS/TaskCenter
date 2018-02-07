//
//  SellResultTableViewCell.m
//  TaskCenter
//
//  Created by 汤达成 on 18/2/1.
//  Copyright © 2018年 Tang. All rights reserved.
//

#import "SellResultTableViewCell.h"

@interface SellResultTableViewCell ()

@property (nonatomic,strong) UIView * line;
@property (nonatomic,strong) UIButton * selectButton;
@property (nonatomic,strong) UILabel * titleLab;

@end

@implementation SellResultTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _line = [[UIView alloc]initWithFrame:CGRectMake(10, 15, 5, 20)];
        _line.backgroundColor = MainColor;
        [self.contentView addSubview:_line];

        _selectButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 12, 26, 26)];
        [_selectButton setImage:KIMAGE(@"checked_medium") forState:UIControlStateSelected];
        [_selectButton setImage:KIMAGE(@"check") forState:UIControlStateNormal];
//        [_selectButton addTarget:self action:@selector(onSelectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_selectButton];
        
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_selectButton.frame)+10, 15, 200, 20)];
        _titleLab.textColor = MainTextColor;
        _titleLab.font = kFont(12);
        [self.contentView addSubview:_titleLab];
    }
    return self;
}

-(void)setIsTopCell:(BOOL)isTopCell
{
    _isTopCell = isTopCell;
    
    _line.hidden = !isTopCell;
    _selectButton.hidden = isTopCell;
    _titleLab.frame = isTopCell ? CGRectMake(CGRectGetMaxX(_line.frame)+10, 15, 200, 20) :CGRectMake(CGRectGetMaxX(_selectButton.frame)+10, 15, 200, 20);
    _titleLab.text= @"原因X";
    _selectButton.selected = NO;
}

-(void)setCell:(BOOL)isSelected{
    _selectButton.selected = isSelected;
}


//-(void)onSelectButtonClick:(UIButton *)button{
//    button.selected = !button.selected;
//}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  ATAlterView.m
//  TaskCenter
//
//  Created by 汤达成 on 18/2/3.
//  Copyright © 2018年 Tang. All rights reserved.
//

#import "ATAlterView.h"

#define white_max_w (MAXWIDTH - 100 * kPROPORTION)

@interface ATAlterView ()

@property (nonatomic,strong) UIView * whiteBackView;
@property (nonatomic,strong) UILabel * titleLab;
@property (nonatomic,strong) UILabel * msgLab;
@property (nonatomic,strong) UILabel * priceLab;
@property (nonatomic,strong) UIButton * cancelBtn;
@property (nonatomic,strong) UIButton * okBtn;

@end

@implementation ATAlterView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        UIView * translucentView = [[UIView alloc]initWithFrame:self.bounds];
        translucentView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [self addSubview:translucentView];
        
        _whiteBackView = [[UIView alloc]initWithFrame:CGRectMake(50 * kPROPORTION, MAXHEIGHT /2 - 93, white_max_w, 186)];
        _whiteBackView.backgroundColor = [UIColor whiteColor];
        _whiteBackView.layer.cornerRadius = 7.5;
        [self addSubview:_whiteBackView];
        
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, white_max_w - 20, 20)];
        _titleLab.textColor = MainColor;
        _titleLab.font = kFont(17);
        _titleLab.text = @"提示消息";
        _titleLab.textAlignment = NSTextAlignmentCenter;
//        _titleLab.adjustsFontSizeToFitWidth = YES;
        [_whiteBackView addSubview:_titleLab];
        
        UIView * line = [[UIView alloc]initWithFrame:CGRectMake(10, 50, white_max_w - 20, 0.5)];
        line.backgroundColor = SpliteColor;
        [_whiteBackView addSubview:line];

        _msgLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 70, white_max_w - 40, 20)];
        _msgLab.textColor = MainTextColor;
        _msgLab.font = kFont(14);
        _msgLab.text = @"是否确认签出？";
        _msgLab.adjustsFontSizeToFitWidth = YES;
        _msgLab.numberOfLines = 0;
        [_whiteBackView addSubview:_msgLab];
        
        _cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(25, 130, (white_max_w - 75 )/2, 35)];
        _cancelBtn.layer.cornerRadius = 17.5f;
        _cancelBtn.backgroundColor = UIColorFromINTValue(218, 218, 218);
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:SecTextColor forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = kFont(14);
        [_cancelBtn addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_whiteBackView addSubview:_cancelBtn];
        
        _okBtn = [[UIButton alloc]initWithFrame:CGRectMake(white_max_w / 2 + 10, 130, (white_max_w - 75 )/2, 35)];
        _okBtn.layer.cornerRadius = 17.5f;
        _okBtn.backgroundColor = MainColor;
        [_okBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _okBtn.titleLabel.font = kFont(14);
        [_okBtn addTarget:self action:@selector(okBtnButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_whiteBackView addSubview:_okBtn];

    }
    return self;
}


-(void)cancelButtonClick{
    [self removeFromSuperview];
}


-(void)okBtnButtonClick{
    
}


-(UILabel *)priceLab{
    if (!_priceLab) {
        _priceLab = [[UILabel alloc]initWithFrame:CGRectMake(20, _msgLab.max_Y + 20, white_max_w - 40, 20)];
        _priceLab.textColor = RedColor;
        _priceLab.font = kFont(16);
        _priceLab.text = @"是否确认签出？";
        _priceLab.adjustsFontSizeToFitWidth = YES;
        _priceLab.textAlignment = NSTextAlignmentCenter;
    }
    return _priceLab;
}

-(void)setMessage:(NSString *)message{
    _message = message;
    self.msgLab.text = message;
    [self refreshUI];
}

-(void)setAttributeMessage:(NSAttributedString *)attributeMessage
{
    _attributeMessage = attributeMessage;
    self.msgLab.attributedText = attributeMessage;
    [self refreshUI];
}

-(void)setPrice:(NSString *)price{
    _price = price;
    [_whiteBackView addSubview:self.priceLab];
    self.priceLab.text = [NSString stringWithFormat:@"¥%@",price];
    [_cancelBtn setY:self.priceLab.max_Y + 20];
    [_okBtn setY:self.priceLab.max_Y + 20];
    
    [_whiteBackView setHeight:_cancelBtn.max_Y + 20];
    _whiteBackView.center = self.center;
}

-(void)refreshUI
{
    NSString * msg = _attributeMessage ? _attributeMessage.string : _message;
    CGSize size = [msg boundingRectWithSize:CGSizeMake(white_max_w - 40, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:kFont(12)} context:nil].size;
    [_msgLab setHeight:size.height];
    
    [_cancelBtn setY:_msgLab.max_Y + 30];
    [_okBtn setY:_msgLab.max_Y + 30];
    
    [_whiteBackView setHeight:_cancelBtn.max_Y + 20];
    _whiteBackView.center = self.center;
}


+(void)showAlertViewWithMessage:(NSString *)message andBlock:(AlertBlock)alertBlock
{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    ATAlterView * alterView = [[ATAlterView alloc]initWithFrame:window.bounds];
    alterView.message =  message;
    alterView.alertBlock = alertBlock;
    [window addSubview:alterView];
}

+(void)showAlertViewWithAttributeMessage:(NSAttributedString *)attributeMessage andBlock:(AlertBlock)alertBlock{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    ATAlterView * alterView = [[ATAlterView alloc]initWithFrame:window.bounds];
    alterView.attributeMessage = attributeMessage;
    alterView.alertBlock = alertBlock;
    [window addSubview:alterView];
}

+(void)showAlertViewWithAttributeMessage:(NSAttributedString *)attributeMessage andPrice:(NSString *)price andBlock:(AlertBlock)alertBlock{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    ATAlterView * alterView = [[ATAlterView alloc]initWithFrame:window.bounds];
    alterView.attributeMessage = attributeMessage;
    alterView.alertBlock = alertBlock;
    alterView.price = price;
    [window addSubview:alterView];
}



@end

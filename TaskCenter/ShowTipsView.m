//
//  ShowTipsView.m
//  TaskCenter
//
//  Created by 汤达成 on 18/2/3.
//  Copyright © 2018年 Tang. All rights reserved.
//

#import "ShowTipsView.h"

@interface ShowTipsView ()

@property (nonatomic,strong) UILabel * tipsLabel;

@end

@implementation ShowTipsView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        UIView * translucentView = [[UIView alloc]initWithFrame:self.bounds];
        translucentView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [self addSubview:translucentView];
        
        UIView * blackView = [[UIView alloc]initWithFrame:CGRectMake(50 * kPROPORTION, MAXHEIGHT /2 - 30, MAXWIDTH - 100 * kPROPORTION, 60)];
        blackView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        blackView.layer.cornerRadius = 7.5;
        [self addSubview:blackView];
        
        _tipsLabel = [[UILabel alloc]initWithFrame:CGRectMake(60 * kPROPORTION, MAXHEIGHT /2 - 10, MAXWIDTH - 120 * kPROPORTION, 20)];
        _tipsLabel.textColor = [UIColor whiteColor];
        _tipsLabel.font = kFont(14);
        _tipsLabel.text = @"已为您接通XX客户。。。";
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        _tipsLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_tipsLabel];
    }
    return self;
}


+(void)showTipsView:(NSString *)tips{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    ShowTipsView * tipsView = [[ShowTipsView alloc]initWithFrame:window.bounds];
    tipsView.tips = tips;
    [window addSubview:tipsView];

}

@end

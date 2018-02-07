//
//  ProjectTalkViewController.m
//  TaskCenter
//
//  Created by 汤达成 on 18/1/23.
//  Copyright © 2018年 Tang. All rights reserved.
//

#import "ProjectTalkViewController.h"

@interface ProjectTalkViewController (){
    CGFloat _current_y;
}

@property (nonatomic,strong) UIScrollView * scrollView;

@end

@implementation ProjectTalkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _current_y = 0;
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MAXWIDTH, self.view.height)];
    _scrollView.contentSize = CGSizeMake(MAXWIDTH, self.view.height);
    [self.view addSubview:_scrollView];
    [self createOneProjectWith:@"开场白" :@""];
    [self createOneProjectWith:@"切入语" :@""];
    [self createOneProjectWith:@"挽留语" :@""];
    [self createOneProjectWith:@"结束语" :@""];
    [_scrollView setContentSize:CGSizeMake(MAXWIDTH, _current_y + 20)];
    
    NSLog(@"%f------------%f",_current_y,self.view.height);
    [self requestData];
}

-(void)requestData{
    [RequestManager postWithPath:@"http://192.168.21.147:18081/work/talk" params:@{@"campaignId":@"1801180923262647"} success:^(id JSON, BOOL isSuccess) {
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.scrollView.frame = CGRectMake(0, 0, MAXWIDTH, self.view.height);
}


-(void)createOneProjectWith:(NSString *)title :(NSString *)content
{
    content = @"开场白开场白开场白开场白开场白开场白开场白开场白开场白开场白开场白开场白开场白开场白开场白开场白开场白开场白开场白开场白开场白开场白开场白开场白开场白开场白开场白";
    UIView * left = [[UIView alloc]initWithFrame:CGRectMake(MAXWIDTH / 2 - 43, _current_y + 23.5, 10, 3)];
    left.backgroundColor = RedColor;
    [_scrollView addSubview:left];
    
    UILabel * topLab = [[UILabel alloc]initWithFrame:CGRectMake(MAXWIDTH / 2 - 33, _current_y + 15, 66, 20)];
    topLab.textColor = MainTextColor;
    topLab.font = [UIFont boldSystemFontOfSize:15];
    topLab.text = title;
    topLab.textAlignment = NSTextAlignmentCenter;
    [_scrollView addSubview:topLab];
    
    UIView * right = [[UIView alloc]initWithFrame:CGRectMake(MAXWIDTH / 2 + 33, _current_y + 23.5, 10, 3)];
    right.backgroundColor = RedColor;
    [_scrollView addSubview:right];
    
    UILabel * contentLab = [[UILabel alloc]initWithFrame:CGRectMake(20, topLab.max_Y + 20, MAXWIDTH - 40, 40)];
    contentLab.textColor = SecTextColor;
    contentLab.font = kFont(12);
    contentLab.text = content;
    contentLab.numberOfLines = 0;
    [_scrollView addSubview:contentLab];
    
    CGSize size = [content boundingRectWithSize:CGSizeMake(MAXWIDTH - 40, MAXHEIGHT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:kFont(12)} context:nil].size;
    [contentLab setHeight:size.height];
    _current_y = contentLab.max_Y + 5;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  TaskDetailViewController.m
//  TaskCenter
//
//  Created by 汤达成 on 18/2/2.
//  Copyright © 2018年 Tang. All rights reserved.
//

#import "TaskDetailViewController.h"

@interface TaskDetailViewController ()

@property (nonatomic,strong) UIScrollView * scrollView;
@property (nonatomic,strong) UILabel * stateLab;
@property (nonatomic,strong) UILabel * typeLab;
@property (nonatomic,strong) UILabel * childTypeLab;
@property (nonatomic,strong) UILabel * callOutTypeLab;
@property (nonatomic,strong) UILabel * assignTypeLab;
@property (nonatomic,strong) UILabel * starRequestLab;
@property (nonatomic,strong) UILabel * voiceEnsureLab;
@property (nonatomic,strong) UILabel * leftNumLab;
@property (nonatomic,strong) UILabel * maxNumLab;
@property (nonatomic,strong) UILabel * timeLab;
@property (nonatomic,strong) UIScrollView * priceScrollView;

@end

@implementation TaskDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createSubViews];
    [self setText];
    [self creatList];
}

-(void)createSubViews{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MAXWIDTH, self.view.height)];
    _scrollView.contentSize = CGSizeMake(MAXWIDTH, self.view.height);
    [self.view addSubview:_scrollView];
    
    _stateLab = [self createLabWithFrame:CGRectMake(20, 10, MAXWIDTH - 40, 15)];
    _typeLab = [self createLabWithFrame:CGRectMake(20, 10 + 25, MAXWIDTH - 40, 15)];
    _childTypeLab = [self createLabWithFrame:CGRectMake(20, 10+ 50, MAXWIDTH - 40, 15)];
    _callOutTypeLab = [self createLabWithFrame:CGRectMake(20, 10+ 75, MAXWIDTH - 40, 15)];
    _assignTypeLab = [self createLabWithFrame:CGRectMake(20, 10+ 100, MAXWIDTH - 40, 15)];
    _starRequestLab = [self createLabWithFrame:CGRectMake(20, 10+ 125, MAXWIDTH - 40, 15)];
    _voiceEnsureLab = [self createLabWithFrame:CGRectMake(20, 10+ 150, MAXWIDTH - 40, 15)];
    _leftNumLab = [self createLabWithFrame:CGRectMake(20, 10+ 175, MAXWIDTH - 40, 15)];
    _maxNumLab = [self createLabWithFrame:CGRectMake(20, 10+ 200, MAXWIDTH - 40, 15)];
    _timeLab = [self createLabWithFrame:CGRectMake(20, 10+ 225, MAXWIDTH - 40, 15)];
    
    _priceScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(20, 270, MAXWIDTH - 40, 60)];
    _priceScrollView.layer.borderWidth = 1.0f;
    _priceScrollView.layer.borderColor = SpliteColor.CGColor;
    [_scrollView addSubview:_priceScrollView];
    
    UIView * line_center = [[UIView alloc]initWithFrame:CGRectMake(20, 300, MAXWIDTH - 40, 1)];
    line_center.backgroundColor = SpliteColor;
    [_scrollView addSubview:line_center];
}


-(void)setText
{
    _stateLab.text       = [NSString stringWithFormat:@"%@: %@",@"项目状态",@"进行中"];
    _typeLab.text        = [NSString stringWithFormat:@"%@: %@",@"业务类型",@"营销类"];
    _childTypeLab.text   = [NSString stringWithFormat:@"%@: %@",@"业务子类型",@"4G流量营销"];
    _callOutTypeLab.text = [NSString stringWithFormat:@"%@: %@",@"外呼类型",@"手动外呼"];
    _assignTypeLab.text  = [NSString stringWithFormat:@"%@: %@",@"分配方式",@"抢单"];
    _starRequestLab.text = [NSString stringWithFormat:@"%@: %@",@"星级要求",@"1星"];
    _voiceEnsureLab.text = [NSString stringWithFormat:@"%@: %@",@"语音确认",@"是"];
    _leftNumLab.text     = [NSString stringWithFormat:@"%@: %@",@"剩余名额数",@"3"];
    _maxNumLab.text      = [NSString stringWithFormat:@"%@: %@",@"执行资格最大数",@"3"];
    _timeLab.text        = [NSString stringWithFormat:@"%@: %@",@"抢单时间",@"10:30-12:30、10:30-12:30、10:30-12:30"];
}

-(void)creatList{
    int max = 5;
    CGFloat sing_W = (MAXWIDTH - 40)/5;
    NSArray * titleArr = @[@"拨打",@"接通",@"下单",@"支付成功",@"合计"];
    NSArray * priceArr = @[@"0.00",@"1.00",@"2.00",@"3.00",@"6.00"];

    for (int i = 0; i < max; i++) {
        UILabel * topLab = [[UILabel alloc]initWithFrame:CGRectMake(i * sing_W, 0, sing_W -1, 30)];
        topLab.backgroundColor = TabBackColor;
        topLab.textColor = SecTextColor;
        topLab.font = kFont(12);
        topLab.text = titleArr[i];
        topLab.textAlignment = NSTextAlignmentCenter;
        [_priceScrollView addSubview:topLab];
        
        UILabel * boomLab = [[UILabel alloc]initWithFrame:CGRectMake(i * sing_W, 31, sing_W -1, 30)];
        boomLab.backgroundColor = [UIColor whiteColor];
        boomLab.textColor = RedColor;
        boomLab.font = kFont(12);
        boomLab.text = [NSString stringWithFormat:@"¥%@",priceArr[i]];
        boomLab.textAlignment = NSTextAlignmentCenter;
        [_priceScrollView addSubview:boomLab];
        
        if (i < max -1) {
            UIView * line = [[UIView alloc]initWithFrame:CGRectMake(i * sing_W + sing_W -1, 0, 1, 60)];
            line.backgroundColor = SpliteColor;
            [_priceScrollView addSubview:line];
        }
    }
    _priceScrollView.contentSize = CGSizeMake(sing_W * max, 60);
}



-(UILabel *)createLabWithFrame:(CGRect)frame{
    UILabel * label = [[UILabel alloc]initWithFrame:frame];
    label.textColor = SecTextColor;
    label.font = kFont(12);
    //    label.adjustsFontSizeToFitWidth = YES;
    [self.scrollView addSubview:label];
    return label;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

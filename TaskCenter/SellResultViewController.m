//
//  SellResultViewController.m
//  TaskCenter
//
//  Created by 汤达成 on 18/2/1.
//  Copyright © 2018年 Tang. All rights reserved.
//

#import "SellResultViewController.h"
#import "SellResultTableViewCell.h"

@interface SellResultViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIView * topWhiteBackView;//白底
@property (nonatomic,strong) UILabel * nameAndPhoneLab;//姓名与电话
@property (nonatomic,strong) UIImageView * stateImageView;//状态图标
//@property (nonatomic,strong) UIButton * callAgainBtn;
@property (nonatomic,strong) UIButton * sellSuccessBtn;//营销成功按钮
@property (nonatomic,strong) UIButton * sellFailueBtn;//营销失败按钮

@property (nonatomic,strong) UITableView * tableView;//下方列表
@property (nonatomic,strong) NSMutableArray * dataSource;//数据源

@property (nonatomic,strong) UIView * boomContainerView;//底部单选内容容器
@property (nonatomic,strong) UIButton * signButton;//标记按钮

@property (nonatomic,assign) NSInteger selectIndex;//列表选中的行

@end

@implementation SellResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"营销结果";
    _selectIndex = -1;
    [self setNav];
    [self setUI];
    [self refreshUI];
}


-(void)forTabButtonsClick:(UIButton *)button
{
    _sellSuccessBtn.selected = _sellFailueBtn.selected = NO;
    _sellSuccessBtn.backgroundColor = _sellFailueBtn.backgroundColor = [UIColor whiteColor];
    _selectIndex = -1;
    if (button == _sellSuccessBtn) {
        _sellSuccessBtn.selected = YES;
        _sellSuccessBtn.backgroundColor = MainColor;
    }else{
        _sellFailueBtn.selected = YES;
        _sellFailueBtn.backgroundColor = MainColor;
    }
}


-(void)refreshUI
{
    [self.tableView setHeight:5 * 50];
    self.tableView.scrollEnabled = NO;
    _boomContainerView.frame = CGRectMake(0, self.tableView.max_Y, MAXWIDTH, 40);
}

#pragma mark -- 设置导航栏
-(void)setNav
{
    UIButton * backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 9, 16)];
    [backBtn setImage:KIMAGE_Ori(@"return") forState:UIControlStateNormal];
    backBtn.contentMode = UIViewContentModeScaleToFill;
    [backBtn addTarget:self action:@selector(leftBarButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClcik:)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark -- 导航栏按钮事件
-(void)leftBarButtonItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightBarButtonItemClcik:(UIBarButtonItem *)item{

}

-(void)setUI
{
    self.view.backgroundColor = BackColor;
    
    _topWhiteBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MAXWIDTH, 125)];
    _topWhiteBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_topWhiteBackView];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 65, 20)];
    label.textColor = MainTextColor;
    label.font = kFont(14);
//    label.adjustsFontSizeToFitWidth = YES;
    label.text = @"客户信息:";
    [_topWhiteBackView addSubview:label];
    
    _nameAndPhoneLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame) + 10, 15, MAXWIDTH - CGRectGetMaxX(label.frame) - 20, 20)];
    _nameAndPhoneLab.textColor = MainColor;
    _nameAndPhoneLab.font = kFont(14);
//    _nameAndPhoneLab.adjustsFontSizeToFitWidth = YES;
    _nameAndPhoneLab.text = @"李女士   138****623";
    [_topWhiteBackView addSubview:_nameAndPhoneLab];
    
    _stateImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(label.frame)+15, 60 * kPROPORTION, 60 * kPROPORTION)];
    _stateImageView.image = KIMAGE(@"checked_bigger");
    [_topWhiteBackView addSubview:_stateImageView];
    
    CGFloat left = 10 + 75 * kPROPORTION, margin = 15 * kPROPORTION;
    
    UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(left, CGRectGetMaxY(label.frame) + 15, 150, 20)];
    label2.textColor = MainTextColor;
    label2.font = kFont(12);
    //    label.adjustsFontSizeToFitWidth = YES;
    label2.text = @"本次通话结果:";
    [_topWhiteBackView addSubview:label2];
    
    CGFloat button_w = (MAXWIDTH - left - 3 * margin) /3;
//    _callAgainBtn = [self createButtonWithFrame:CGRectMake(left, CGRectGetMaxY(label2.frame)+10, button_w, 30) normalTitle:@"再次预约"];
    
    _sellSuccessBtn = [self createButtonWithFrame:CGRectMake(left, CGRectGetMaxY(label2.frame)+10, button_w, 30) normalTitle:@"营销成功"];
    _sellSuccessBtn.selected = YES;
    _sellSuccessBtn.backgroundColor = MainColor;
    
    _sellFailueBtn = [self createButtonWithFrame:CGRectMake(left + button_w + margin, CGRectGetMaxY(label2.frame)+10, button_w, 30) normalTitle:@"营销不成功"];
    
    [self.view addSubview:self.tableView];
    
    
    _boomContainerView = [[UIView alloc]initWithFrame:CGRectMake(0,self.tableView.max_Y, MAXWIDTH, 40)];
    _boomContainerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_boomContainerView];
    
    _signButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    [_signButton setImage:KIMAGE(@"checked_small") forState:UIControlStateSelected];
    [_signButton setImage:KIMAGE(@"check") forState:UIControlStateNormal];
    [_signButton addTarget:self action:@selector(onSelectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_boomContainerView addSubview:_signButton];
    
    UILabel * attLab = [[UILabel alloc]initWithFrame:CGRectMake(_signButton.max_X+10, 10, 200, 20)];
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithString:@"本次通话标记为预约电话" attributes:@{NSForegroundColorAttributeName:MainTextColor,NSFontAttributeName:kFont(12)}];
    [attStr setAttributes:@{NSForegroundColorAttributeName:MainColor,NSFontAttributeName:kFont(12)} range:NSMakeRange(7, 4)];
    attLab.attributedText = attStr;
    [_boomContainerView addSubview:attLab];
}

-(void)onSelectButtonClick:(UIButton *)button{
    button.selected = !button.selected;
}

#pragma mark -- 创建tab菜单按钮
-(UIButton *)createButtonWithFrame:(CGRect)frame normalTitle:(NSString *)normalTitle
{
    UIButton * button = [[UIButton alloc]initWithFrame:frame];
    [button setTitle:normalTitle forState:UIControlStateNormal];
    button.layer.cornerRadius = 15;
    button.layer.borderWidth = 1.0f;
    button.layer.borderColor = MainColor.CGColor;
    button.titleLabel.font = kFont(14);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [button setTitleColor:MainColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(forTabButtonsClick:) forControlEvents:UIControlEventTouchUpInside];
    [_topWhiteBackView addSubview:button];
    return button;
}

#pragma mark -- tableViewDelegate/tableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return self.dataSource.count;
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)    indexPath{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SellResultTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kSellResultTableViewCellReuseID forIndexPath:indexPath];
    cell.isTopCell = (indexPath.row ==0 ? YES : NO);
    [cell setCell:(indexPath.row == _selectIndex ? YES : NO)];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == _selectIndex) {
        _selectIndex = -1;
    }else{
        _selectIndex = indexPath.row;
    }
    [self.tableView reloadData];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_topWhiteBackView.frame)+10 , MAXWIDTH, 100) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[SellResultTableViewCell class] forCellReuseIdentifier:kSellResultTableViewCellReuseID];
    }
    return _tableView;
}

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

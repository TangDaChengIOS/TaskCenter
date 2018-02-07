//
//  PackageBusinessViewController.m
//  TaskCenter
//
//  Created by 汤达成 on 18/1/23.
//  Copyright © 2018年 Tang. All rights reserved.
//

#import "PackageBusinessViewController.h"
#import "MsgListTableViewCell.h"

@interface PackageBusinessViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataSource;

@property (nonatomic,strong) UILabel * packageNameLab;
@property (nonatomic,strong) UIButton * handleBtn;

@end

@implementation PackageBusinessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createSubViews];
    [self.view addSubview:self.tableView];
    self.dataSource = [NSMutableArray arrayWithArray:@[@"客户信息",@"客户姓名",@"客户级别",@"当前手机号",@"客户画像",@"",@"",@""]];
    CGRect rect = self.tableView.frame;
    rect.size.height = 35 * self.dataSource.count;
    self.tableView.frame = rect;
}

-(void)createSubViews{
    _packageNameLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 12, MAXWIDTH - 120, 26)];
    _packageNameLab.textColor = MainTextColor;
    _packageNameLab.font = kFont(15);
    _packageNameLab.text = @"话音短信不限量套餐-388元套餐";
    [self.view addSubview:_packageNameLab];
    
    _handleBtn = [[UIButton alloc]initWithFrame:CGRectMake(MAXWIDTH - 105, 10, 80, 30)];
    _handleBtn.layer.cornerRadius = 15.0f;
    _handleBtn.backgroundColor = MainColor;
    [_handleBtn setTitle:@"办理" forState:UIControlStateNormal];
    [self.view addSubview:_handleBtn];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MsgListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kMsgListTableViewCellReuseID forIndexPath:indexPath];
    cell.showStyle = CellShowStyleRightShort;

    if (indexPath.row % 2 == 1) {
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }else{
        cell.contentView.backgroundColor = TabBackColor;
    }
    [cell setCellWith:self.dataSource[indexPath.row] isNeedRight:YES rightStr:@"43234"];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 50, MAXWIDTH - 20, self.view.bounds.size.height - 70) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.layer.borderWidth = 1.0f;
        _tableView.layer.borderColor = SpliteColor.CGColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[MsgListTableViewCell class] forCellReuseIdentifier:kMsgListTableViewCellReuseID];
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


@end

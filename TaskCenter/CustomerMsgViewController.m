//
//  CustomerMsgViewController.m
//  TaskCenter
//
//  Created by 汤达成 on 18/1/23.
//  Copyright © 2018年 Tang. All rights reserved.
//

#import "CustomerMsgViewController.h"
#import "MsgListTableViewCell.h"
#import "UserMsgModel.h"

@interface CustomerMsgViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataSource;
@end

@implementation CustomerMsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.dataSource = [NSMutableArray arrayWithArray:@[@"客户信息",@"客户姓名",@"客户级别",@"当前手机号",@"客户画像",@"",@"",@""]];
    CGRect rect = self.tableView.frame;
    rect.size.height = 35 * self.dataSource.count;
    self.tableView.frame = rect;
}


-(void)requestData{
    [RequestManager postWithPath:@"http://192.168.21.147:18081/work/talk" params:@{@"campaignId":@"1801180923262647"} success:^(id JSON, BOOL isSuccess) {
        
    } failure:^(NSError *error) {
        
    }];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MsgListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kMsgListTableViewCellReuseID forIndexPath:indexPath];
    cell.showStyle = CellShowStyleLeftShort;
    if (indexPath.row % 2 == 1) {
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }else{
        cell.contentView.backgroundColor = TabBackColor;
    }
    [cell setCellWith:self.dataSource[indexPath.row] isNeedRight:(indexPath.row%4==0 ? NO : YES) rightStr:@""];
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
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 20, MAXWIDTH - 20, self.view.bounds.size.height - 40) style:UITableViewStylePlain];
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

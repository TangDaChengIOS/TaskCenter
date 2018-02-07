//
//  WorkStationViewController.m
//  TaskCenter
//
//  Created by 汤达成 on 18/1/19.
//  Copyright © 2018年 Tang. All rights reserved.
//

#import "WorkStationViewController.h"
#import "CustomerMsgViewController.h"
#import "PackageBusinessViewController.h"
#import "SellResultViewController.h"
#import "TaskDetailViewController.h"
#import "ResearchReportViewController.h"
#import "ProjectTalkViewController.h"
#import "TaskDetailModel.h"
#import "MJExtension.h"

@interface WorkStationViewController (){
    NSString * _vccID;
    NSString * _agentID;
    int _currentButtonIndex;//动态创建呼叫相关按钮时用到
}

@property (nonatomic,strong) UIBarButtonItem * rightItem;//导航栏右键

@property (nonatomic,strong) UILabel * titleLab;//工作标题
@property (nonatomic,strong) UILabel * timeLab;//工作时间

@property (nonatomic,strong) UIButton * call_out_btn;//外呼
@property (nonatomic,strong) UIButton * call_end_btn;//挂机
@property (nonatomic,strong) UIButton * call_ivr_btn;//IVR
@property (nonatomic,strong) UIButton * call_keep_btn;//保持通话
@property (nonatomic,strong) UIButton * call_request_btn;//请求来话（示闲）
@property (nonatomic,strong) UIButton * call_stop_btn;//进整理态（示忙）

@property (nonatomic,strong) UIButton * task_detail_btn;//项目详情
@property (nonatomic,strong) UIButton * customer_msg_btn;//客户信息
@property (nonatomic,strong) UIButton * package_business_btn;//套餐业务
@property (nonatomic,strong) UIButton * project_talk_btn;//项目话术
@property (nonatomic,strong) UIButton * research_report_btn;//调查问卷

@property (nonatomic,strong) UIImageView * tab_selected_imageView;//菜单下方小三角

@property (nonatomic,strong) TaskDetailModel * taskModel;

@end

@implementation WorkStationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
//    _isCallOut = YES;
    [self requestData];
}


-(void)requestData
{
    NSDictionary * dict = @{@"campaignId":@"1801180923262647",
                            @"provId":@"00030073",
                            @"sysNo":@"cstcs"};
    __weak typeof(self)weakSelf = self;
    [RequestManager postWithPath:@"http://192.168.21.147:18081/projecthall/projectinfo" params:dict success:^(id JSON, BOOL isSuccess) {
        if (isSuccess) {
            TaskDetailModel * model = [TaskDetailModel new];
            [model mj_setKeyValues:JSON[@"bean"]];
//            model.ivrFlag = @"1";
            model.surveyFlag = 1;
            weakSelf.taskModel = model;
            [weakSelf setUI];
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)setUI{
    [self createTopLabel];
    [self createAboutCallButtons];
    [self createAboutCenterMenu];
    [self createSubController];
    [self setDefaultBtnStates];
}

-(void)setDefaultBtnStates
{
    _call_end_btn.enabled = NO;
    _call_keep_btn.enabled = NO;

    if (_isCallOut) {
        _call_out_btn.enabled = NO;
    }else{
        _call_request_btn.enabled = NO;
        _call_stop_btn.enabled  = NO;
    }
    
    if ([_taskModel.ivrFlag isEqualToString:@"1"]) {
        _call_ivr_btn.enabled = NO;
    }

}

#pragma mark ---------------------------------------- SDK Delegate Begin
- (void)OnCallRing:(NSString *)callingNo CalledNo:(NSString *)calledno OrgCalledNo:(NSString *)orgcallno CallData:(NSString *)calldata SerialID:(NSString *)serialid ServiceDirect:(int)servicedirect CallID:(NSString *)callid UserParam:(NSString *)userparam TaskID:(NSString *)taskid UserDn:(NSString *)userdn AgentDn:(NSString *)agentdn AreaCode:(NSString *)areacode  Filename:(NSString *)filename NetWorkInfo:(NSString *)networkinfo QueueTime:(NSString *)queuetime OpAgentID:(NSString *)opagentid
{
    NSLog(@"MY_EVENT:OnCallRing\n");
   // [_debugController DisplayMessage:[NSString stringWithFormat:@"##OnCallRing(%@,%@)\n",callingNo,callid]];
}
- (void)OnCallConnectd:(NSString *)UserNo AnswerTime:(NSString *)answertime SerialID:(NSString *)serialid ServiceDirect:(int)servicedirect CallID:(NSString *)callid UserParam:(NSString *)userparam TaskID:(NSString *)taskid
{
    NSLog(@"MY_EVENT:OnCallConnectd\n");
   // [_debugController DisplayMessage:[NSString stringWithFormat:@"##OnCallConnectd(%@,%@)\n",UserNo,callid]];
}
- (void)OnCallEnd:(NSString *)callID SerialID:(NSString *)serialid ServiceDirect:(int)servicedirect UserNo:(NSString *)userno BgnTime:(NSString *)bgntime EndTime:(NSString *)endtime AgentAlertTime:(NSString *)agentalerttime UserAlertTime:(NSString *)useralerttime FileName:(NSString *)filename Directory:(NSString *)directory DisconnectType:(int)disconnecttype UserParam:(NSString *)userparam TaskID:(NSString *)taskid ServerName:(NSString *)servername NetWorkInfo:(NSString *)networkinfo
{
    NSLog(@"MY_EVENT:OnCallEnd\n");
   // [_debugController DisplayMessage:[NSString stringWithFormat:@"##OnCallEnd(%@,%d)\n",callID,servicedirect]];
}


- (void)OnPrompt:(int)code description:(NSString *)des
{
    NSLog(@"MY_EVENT:OnPrompt(%d,%@)\n", code, des);
    
   // [_debugController DisplayMessage:[NSString stringWithFormat:@"##OnPrompt(%d,%@)\n", code, des]];
}

- (void)OnReportBtnStatus:(NSString *)btnIDS
{
    NSLog(@"MY_EVENT:OnReportBtnStatus(%@)\n", btnIDS);
    NSArray * array = [btnIDS componentsSeparatedByString:@"|"];
    [self setDefaultBtnStates];
    for (NSString * item in array) {
        if([item isEqualToString:@"6"] ){//挂断
            _call_end_btn.enabled = YES;
        }
       else if ([item isEqualToString:@"4"] ){//保持
            _call_keep_btn.enabled = YES;
        }
       else if ([item isEqualToString:@"2"] ){//示闲
           _call_request_btn.enabled = YES;
       }
       else if ([item isEqualToString:@"1"] ){//后续态
           _call_stop_btn.enabled = YES;
       }
    }

}

- (void)OnInitialSuccess
{
    NSLog(@"MY_EVENT:OnInitialSuccess\n");
    self.title = @"签入成功";
    _rightItem.title = @"签出";
}

- (void)OnInitalFailure:(int)code description:(NSString *)des
{
    NSLog(@"MY_EVENT:OnInitalFailure(%d,%@)\n",code,des);
   
}

- (void)OnAgentWorkReport:(int)workStatus description:(NSString *)des
{
    NSLog(@"MY_EVENT:OnAgentWorkReport(%d,%@)\n",workStatus,des);
  //  NSString* strValue = [NSString stringWithFormat:@"状态:%@  场景:%@",[self GetAgentStatusDes:[_oCINVccBar GetAgentStatus]],des];
  //  [self SetViewTitle:strValue];
  //  [_debugController DisplayMessage:[NSString stringWithFormat:@"##OnAgentWorkReport(%d,%@)\n",workStatus,des]];
}
- (void)OnBarExit:(int)code  description:(NSString *)des
{
    NSLog(@"MY_EVENT:OnBarExit(%d,%@)\n",code,des);
    _rightItem.title = @"签入";
    self.title = @"未签入";
}
- (void)OnMethodResponseEvent:(NSString *)cmdName param:(NSString *)p
{
    NSLog(@"MY_EVENT:OnMethodResponseEvent(%@,%@)\n",cmdName,p);
   // [_debugController DisplayMessage:[NSString stringWithFormat:@"##OnMethodResponseEvent(%@,%@)\n",cmdName,p]];
}


- (void)OnEventPrompt:(int)eventIndex EventParam:(NSString *)eventparam
{
    NSLog(@"MY_EVENT:OnEventPrompt(%d,%@)\n",eventIndex,eventparam);
}

- (void)OnCallDataChanged:(NSString *)callData
{
    NSLog(@"MY_EVENT:OnCallDataChanged(%@)\n",callData);
}
- (void)OnSystemMessage:(int)code Description:(NSString *)des
{
    NSLog(@"MY_EVENT:OnSystemMessage(%d,%@)\n",code,des);
}

- (void)OnWorkStaticInfoReport:(NSString *)staticInfo
{
    NSLog(@"MY_EVENT:OnWorkStaticInfoReport(%@)\n",staticInfo);
}

- (void)OnQueueReport:(NSString *)serviceReportInfo
{
    NSLog(@"MY_EVENT:OnQueueReport(%@)\n",serviceReportInfo);
}
#pragma mark ----------------------------------------- SDK Delegate End


#pragma mark -- 呼叫相关的按钮的事件
-(void)forCallButtonsClick:(UIButton *)button
{
    if (button == _call_end_btn){
        [self.oCINVccBar Disconnect:0];
    }
    else if (button == _call_keep_btn){
        [self.oCINVccBar Hold];
    }
    else if (button == _call_request_btn)
    {
        [self gotoResultPage];
        [self callOut];
        [self.oCINVccBar SetIdle];
    }
    else if (button == _call_stop_btn){
        [self.oCINVccBar SetBusy:0];
    }
    
}

-(void)callOut{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"请输入您将要外呼的号码" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    //定义第一个输入框；
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入您将要外呼的号码";//
        textField.text = @"15090381570";
//        textField.text = @"18812345678";

        
    }];
    typeof(self) weakSelf = self;
    [alertController addAction:[UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //获取第1个输入框；
        UITextField *phoneTF = alertController.textFields.firstObject;
        [weakSelf.oCINVccBar CallOutSide:phoneTF.text serviceDirect:3 taskID:@"" transParentParam:@"" phoneID:@""];

    }]];
    [self presentViewController:alertController animated:true completion:nil];
}

#pragma mark -- 跳转营销结果页
-(void)gotoResultPage{
    SellResultViewController * resultVC = [[SellResultViewController alloc]init];
    [self.navigationController pushViewController:resultVC animated:YES];
}


#pragma mark -- 中间tab切换事件
-(void)forTabButtonsClick:(UIButton *)button
{
    _task_detail_btn.selected = _customer_msg_btn.selected = _package_business_btn.selected = _project_talk_btn.selected = _research_report_btn.selected = NO;
    CGPoint center = _tab_selected_imageView.center;

    NSInteger index = 0;
    if (button == _task_detail_btn) {
        _task_detail_btn.selected = YES;
        center.x = _task_detail_btn.center.x;
        _tab_selected_imageView.center = center;
    }
    else if (button == _customer_msg_btn)
    {
        _customer_msg_btn.selected = YES;
        center.x = _customer_msg_btn.center.x;
        _tab_selected_imageView.center = center;
        index = 1;
    }
    else if (button == _package_business_btn)
    {
        _package_business_btn.selected = YES;
        center.x = _package_business_btn.center.x;
        _tab_selected_imageView.center = center;
        index = 2;
    }
    else if (button == _project_talk_btn)
    {
        _project_talk_btn.selected = YES;
        center.x = _project_talk_btn.center.x;
        _tab_selected_imageView.center = center;
        index = (_taskModel.surveyFlag == 0 ? 3: 4);
    }
    else if (button == _research_report_btn)
    {
        _research_report_btn.selected = YES;
        center.x = _research_report_btn.center.x;
        _tab_selected_imageView.center = center;
        index = 3;
    }
    
    [self refreshUI:index];
    
}
-(void)refreshUI:(NSInteger)index{
    for (int i = 0; i < self.childViewControllers.count; i++) {
        UIViewController * gameVC  = self.childViewControllers[i];
        if (i == index) {
            gameVC.view.hidden = NO;
        }else{
            gameVC.view.hidden = YES;
        }
    }
}
#pragma mark -- 设置导航栏
-(void)setNav
{    
    self.title = @"未签入";

    UIButton * backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 9, 16)];
    [backBtn setImage:KIMAGE_Ori(@"return") forState:UIControlStateNormal];
    backBtn.contentMode = UIViewContentModeScaleToFill;
    [backBtn addTarget:self action:@selector(leftBarButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    _rightItem = [[UIBarButtonItem alloc]initWithTitle:@"签入" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClcik:)];
    
    self.navigationItem.rightBarButtonItem = _rightItem;
}

#pragma mark -- 导航栏按钮事件
-(void)leftBarButtonItemClick{
  [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightBarButtonItemClcik:(UIBarButtonItem *)item{
    int agenStatus = [self.oCINVccBar GetAgentStatus];
    if (agenStatus == 0) {
        [self login];
    }else{
        [_oCINVccBar UnInitial:0];
    }
}


-(void)login{
    [_oCINVccBar VccBarClear];
    [_oCINVccBar VccBarCreate];
    _vccID = @"111111";
    _agentID = @"5001";
    [_oCINVccBar setAgentID:[NSString stringWithFormat:@"000010%@%@",_vccID,_agentID]];
    [_oCINVccBar setVccID:_vccID];
    [_oCINVccBar setPassWord:@"111111"];
    [_oCINVccBar setDn:[NSString stringWithFormat:@"000002%@%@",_vccID,_agentID]];
    [_oCINVccBar setMainIp:@"192.168.20.122"];
    [_oCINVccBar setMainPort:14800];
    [_oCINVccBar setTaskId:@"0"];
    [_oCINVccBar setPhoneType:1];
    
    [_oCINVccBar setSipServer:@"192.168.20.122"];
    [_oCINVccBar setSipPort:5066];
    [_oCINVccBar setSipPassword:@"Q6v^!t@HS1Cd?qF"];
    [_oCINVccBar Initial];
}


#pragma mark -- 创建子视图
-(void)createTopLabel
{
    //项目标题
    _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, MAXWIDTH - 85, 20)];
    _titleLab.textColor = MainTextColor;
    _titleLab.font = kFont(14);
//    _titleLab.text = @"自动外呼在线办理测试";
    _titleLab.text = _taskModel.campaignName;
    [self.view addSubview:_titleLab];
    //时间
    _timeLab = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_titleLab.frame) + 10, MAXWIDTH - 85, 15)];
    _timeLab.textColor = ThirTexColor;
    _timeLab.font = kFont(12);
    _timeLab.adjustsFontSizeToFitWidth = YES;
//    _timeLab.text = @"2017-12-14 00:00:00至2017-12-30 23:59:59";
    _timeLab.text = [NSString stringWithFormat:@"%@至%@",_taskModel.beginDate,_taskModel.endDate];
    [self.view addSubview:_timeLab];
}


-(void)createAboutCallButtons
{
    //按钮《挂机、保持通话、请求来话、进整理态》
    _currentButtonIndex = 0;
    CGFloat btn_y = CGRectGetMaxY(_timeLab.frame)+30;
    CGFloat btn_w = 50 * kPROPORTION;
    NSInteger buttonNum = 4;
    if ([_taskModel.ivrFlag isEqualToString:@"1"] && !_isCallOut) {
        buttonNum++;
    }
    CGFloat margin = (MAXWIDTH - buttonNum * btn_w - 40 * kPROPORTION)/(buttonNum - 1);
    
    if (_isCallOut) {
        _call_out_btn = [self createButtonWithFrame:CGRectMake(20 * kPROPORTION + (btn_w + margin) * _currentButtonIndex, btn_y, btn_w, btn_w) normalImage:@"apply_call" unableImage:@"apply_call_disabled" andBoomLabTitle:@"呼出"];
    }
    
    _call_end_btn = [self createButtonWithFrame:CGRectMake(20 * kPROPORTION + (btn_w + margin) * _currentButtonIndex, btn_y, btn_w, btn_w) normalImage:@"hang_up" unableImage:@"hang_up_disabled" andBoomLabTitle:@"挂机"];
    
    if ([_taskModel.ivrFlag isEqualToString:@"1"]) {
        _call_ivr_btn = [self createButtonWithFrame:CGRectMake(20 * kPROPORTION + (btn_w + margin) * _currentButtonIndex, btn_y, btn_w, btn_w) normalImage:@"IVR_voice" unableImage:@"IVR_voice_disabled" andBoomLabTitle:@"IVR语音"];
    }
    
    _call_keep_btn = [self createButtonWithFrame:CGRectMake(20 * kPROPORTION + (btn_w + margin) * _currentButtonIndex, btn_y, btn_w, btn_w) normalImage:@"remain_connect" unableImage:@"remain_connect_disabled" andBoomLabTitle:@"保持通话"];
    
    if (!_isCallOut) {
        _call_request_btn = [self createButtonWithFrame:CGRectMake(20 * kPROPORTION + (btn_w + margin) * _currentButtonIndex, btn_y, btn_w, btn_w) normalImage:@"apply_call" unableImage:@"apply_call_disabled" andBoomLabTitle:@"请求来话"];
        
        _call_stop_btn = [self createButtonWithFrame:CGRectMake(20 * kPROPORTION + (btn_w + margin) * _currentButtonIndex, btn_y, btn_w, btn_w) normalImage:@"sort_state" unableImage:@"sort_state_disabled" andBoomLabTitle:@"进整理态"];
    }

    
    //分割线
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_call_end_btn.frame)+ 40, MAXWIDTH, 10)];
    line.backgroundColor = BackColor;
    [self.view addSubview:line];
}


-(void)createAboutCenterMenu
{
    CGFloat btn_num = (_taskModel.surveyFlag == 0 ? 4: 5);
    CGFloat btn_w = MAXWIDTH / btn_num -1;
    CGFloat btn_singleX = btn_w + 1;
    CGFloat btn_y = _call_end_btn.max_Y + 50 +10;
    
    _task_detail_btn = [self createButtonWithFrame:CGRectMake(0, btn_y, btn_w, 30) normalTitle:@"项目详情"];
    _task_detail_btn.selected = YES;
    
    _tab_selected_imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, btn_y + 30, 5, 3)];
    _tab_selected_imageView.image = KIMAGE(@"tab_selected");
    CGPoint center = _tab_selected_imageView.center;
    center.x = _task_detail_btn.center.x;
    _tab_selected_imageView.center = center;
    [self.view addSubview:_tab_selected_imageView];
    
    //分割线
    UIView * vert_line = [[UIView alloc]initWithFrame:CGRectMake(btn_w, btn_y + 10, 1, 10)];
    vert_line.backgroundColor = BackColor;
    [self.view addSubview:vert_line];
    
    _customer_msg_btn = [self createButtonWithFrame:CGRectMake(btn_singleX, btn_y, btn_w, 30) normalTitle:@"客户信息"];
    
    
    //分割线
    UIView * vert_line_one = [[UIView alloc]initWithFrame:CGRectMake(btn_singleX + btn_w, btn_y + 10, 1, 10)];
    vert_line_one.backgroundColor = BackColor;
    [self.view addSubview:vert_line_one];
    
    _package_business_btn = [self createButtonWithFrame:CGRectMake(2 *btn_singleX, btn_y, btn_w, 30) normalTitle:@"套餐业务"];
    
    //分割线
    UIView * vert_line_two = [[UIView alloc]initWithFrame:CGRectMake(btn_singleX * 2 + btn_w, btn_y + 10, 1, 10)];
    vert_line_two.backgroundColor = BackColor;
    [self.view addSubview:vert_line_two];
    
    if (_taskModel.surveyFlag == 0) {
        _project_talk_btn = [self createButtonWithFrame:CGRectMake(3* btn_singleX, btn_y, btn_w, 30) normalTitle:@"项目话术"];

    }else{
        _research_report_btn =  [self createButtonWithFrame:CGRectMake(3* btn_singleX, btn_y, btn_w, 30) normalTitle:@"调查问卷"];
        
        //分割线
        UIView * vert_line_thr = [[UIView alloc]initWithFrame:CGRectMake(btn_singleX * 3 + btn_w, btn_y + 10, 1, 10)];
        vert_line_thr.backgroundColor = BackColor;
        [self.view addSubview:vert_line_thr];
        
        _project_talk_btn = [self createButtonWithFrame:CGRectMake(4* btn_singleX, btn_y, btn_w, 30) normalTitle:@"项目话术"];
    }
    
    
    //分割线
    UIView * line2 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_project_talk_btn.frame)+ 15, MAXWIDTH, 5)];
    line2.backgroundColor = BackColor;
    [self.view addSubview:line2];
}

-(void)createSubController
{
    CGFloat vcHeight = MAXHEIGHT - CGRectGetMaxY(_project_talk_btn.frame)- 20;
    NSLog(@"%f-------",vcHeight);
    
    TaskDetailViewController * taskDetailVC = [[TaskDetailViewController alloc]init];
    [self addChildViewController:taskDetailVC];
    taskDetailVC.view.frame = CGRectMake(0, CGRectGetMaxY(_project_talk_btn.frame)+ 20, MAXWIDTH, vcHeight);
    [self.view addSubview:taskDetailVC.view];
    
    CustomerMsgViewController * customerMsgVC = [[CustomerMsgViewController alloc]init];
    [self addChildViewController:customerMsgVC];
    customerMsgVC.view.frame = CGRectMake(0, CGRectGetMaxY(_project_talk_btn.frame)+ 20, MAXWIDTH, vcHeight);
    [self.view addSubview:customerMsgVC.view];
    
    PackageBusinessViewController * packageBusinessMsgVC = [[PackageBusinessViewController alloc]init];
    [self addChildViewController:packageBusinessMsgVC];
    packageBusinessMsgVC.view.frame = CGRectMake(0, CGRectGetMaxY(_project_talk_btn.frame)+ 20, MAXWIDTH, vcHeight);
    [self.view addSubview:packageBusinessMsgVC.view];
    
    if (_taskModel.surveyFlag == 1) {
        ResearchReportViewController * researchReportVC = [[ResearchReportViewController alloc]init];
        [self addChildViewController:researchReportVC];
        researchReportVC.view.frame = CGRectMake(0, CGRectGetMaxY(_project_talk_btn.frame)+ 20, MAXWIDTH, vcHeight);
        [self.view addSubview:researchReportVC.view];
    }
    
    ProjectTalkViewController * projectTalkVC = [[ProjectTalkViewController alloc]init];
    [self addChildViewController:projectTalkVC];
    projectTalkVC.view.frame = CGRectMake(0, CGRectGetMaxY(_project_talk_btn.frame)+ 20, MAXWIDTH, vcHeight);
    [self.view addSubview:projectTalkVC.view];
    
    [self refreshUI:0];

}

#pragma mark -- 创建顶部的按钮及底部文字
-(UIButton *)createButtonWithFrame:(CGRect)frame normalImage:(NSString *)normalImage unableImage:(NSString *)unableImage andBoomLabTitle:(NSString *)title
{
    UIButton * button = [[UIButton alloc]initWithFrame:frame];
    [button setImage:KIMAGE(normalImage) forState:UIControlStateNormal];
    [button setImage:KIMAGE(unableImage) forState:UIControlStateDisabled];
    [button addTarget:self action:@selector(forCallButtonsClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    CGRect rect = frame;
    rect.size.height = 20;
    rect.origin.y = CGRectGetMaxY(frame)+ 10;
    UILabel * boomLab = [[UILabel alloc]initWithFrame:rect];
    boomLab.textColor = MainTextColor;
    boomLab.font = kFont(13);
    boomLab.textAlignment = NSTextAlignmentCenter;
    boomLab.adjustsFontSizeToFitWidth = YES;
    boomLab.text = title;
    [self.view addSubview:boomLab];
    _currentButtonIndex ++;
    return button;
}

#pragma mark -- 创建tab菜单按钮
-(UIButton *)createButtonWithFrame:(CGRect)frame normalTitle:(NSString *)normalTitle
{
    UIButton * button = [[UIButton alloc]initWithFrame:frame];
    [button setTitle:normalTitle forState:UIControlStateNormal];
    button.titleLabel.font = kFont(13);
    button.titleLabel.adjustsFontSizeToFitWidth = YES;
    [button setTitleColor:MainColor forState:UIControlStateSelected];
    [button setTitleColor:MainTextColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(forTabButtonsClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    return button;
}

-(CINVccBarCore *)oCINVccBar{
    if (!_oCINVccBar) {
        _oCINVccBar = [[CINVccBarCore alloc]init];
        _oCINVccBar.delegate = self;
        [_oCINVccBar SetAcpTraceFlag:(1+2+4+8+16+32)];
        [_oCINVccBar SetSipTraceFlag:3];
    }
    return _oCINVccBar;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

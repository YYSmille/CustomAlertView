//
//  LFViewController.m
//  CustomAlertView
//
//  Created by 505878400@qq.com on 11/20/2018.
//  Copyright (c) 2018 505878400@qq.com. All rights reserved.
//

#import "LFViewController.h"
#import "CustomAlertView.h"
#import "SVProgressHUD+extension.h"
#import "FieldInfo.h"
#import "CustomTipView.h"

@interface LFViewController ()<UITableViewDelegate, UITableViewDataSource,CustomAlertViewDelegate>
@property (nonatomic, strong) NSMutableArray <FieldInfo *>*dataList;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation LFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initData];
    _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 44;
}

- (void)initData{
    _dataList = [NSMutableArray array];
    FieldInfo *info = nil;
    
    info = [FieldInfo fieldInfoWithTitle:@"showLoading" selector:@selector(showLoading)];
    [_dataList addObject:info];

    
    info = [FieldInfo fieldInfoWithTitle:@"show" selector:@selector(show)];
    [_dataList addObject:info];
    
    info = [FieldInfo fieldInfoWithTitle:@"showTime" selector:@selector(showTime)];
    [_dataList addObject:info];
    
    info = [FieldInfo fieldInfoWithTitle:@"showTimeComplete" selector:@selector(showTimeComplete)];
    [_dataList addObject:info];
    
    info = [FieldInfo fieldInfoWithTitle:@"dissmiss" selector:@selector(dissmiss)];
    [_dataList addObject:info];
    
    info = [FieldInfo fieldInfoWithTitle:@"showText" selector:@selector(showText)];
    [_dataList addObject:info];
    
    info = [FieldInfo fieldInfoWithTitle:@"customTip" selector:@selector(customTip)];
    [_dataList addObject:info];

    
}

#pragma mark - event
- (void)showLoading{
    [SVProgressHUD show];
}

- (void)show{
    [SVProgressHUD showMessage:@"show"];
}

- (void)showTime{
    [SVProgressHUD showMessage:@"显示3秒" duration:3.f];
}

- (void)showTimeComplete{
    [SVProgressHUD showMessage:@"回调" completed:^{
        CustomAlertView *alertView = [[CustomAlertView alloc] initWithTitle:@"提示" message:@"回调完成三角阀开发老师，发啦，浪费了没释放马发了没" delegate:self btnTitles:@[@"取消_#fa1220_#12a233", @"确定"]];
        [alertView show];
        //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"回调完成" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
        //        [alertView show];
    }];
}

- (void)showText{
    CustomAlertView *alertView = [[CustomAlertView alloc] initWithTextViewTitle:@"text" message:@"内如x什么模式" placeholder:@"placeholder内容" maxEditNum:10 delegate:self btnTitles:@[@"取消_#fa1220_#12a233", @"确定"]];
    [alertView show];
}

- (void)dissmiss{
    [SVProgressHUD dismiss];
}

- (void)customTip{
    [CustomTipView showTipWithTitle:@"分件那份件案件发" duration:3.0 complete:^{
        NSLog(@"提示结束");
    }];
}

#pragma mark -  CustomAlertViewDelegate
- (void)customAlertView:(CustomAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"CustomAlertViewDelegate-clickedButtonAtIndex--%zd", buttonIndex);
}

- (void)customAlertView:(CustomAlertView *)alertView textDidChanged:(NSString *)text{
    NSLog(@"CustomAlertViewDelegate-textDidChanged--%@", text);
    
}

#pragma mark - tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    FieldInfo *info = _dataList[indexPath.row];
    cell.textLabel.text = info.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FieldInfo *info = _dataList[indexPath.row];
    [self performSelector:info.selector];
}

@end

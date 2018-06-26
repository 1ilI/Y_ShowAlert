//
//  ViewController.m
//  Y_ShowAlertExample
//
//  Created by Yue on 2017/6/26.
//  Copyright © 2017年 Yue. All rights reserved.
//

#import "ViewController.h"
#import "UIAlertController+Show.h"

static NSString *const tableViewCellID = @"tableViewCellReuseIdentifier";
@interface ViewController ()

@property (copy, nonatomic) NSArray *dataArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.dataArr = @[@"Alert-Style1-单个选项",@"Alert-Style2-正常两个选项",@"Alert-Style3-多个选项",@"Alert-WithTextField-限制最大长度",@"Alert-WithTextField-限制最小长度",@"Alert-WithTextField-多个TextField"];
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.contentInset = UIEdgeInsetsMake(150, 0, 0, 0);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:tableViewCellID];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellID forIndexPath:indexPath];
    cell.textLabel.text = _dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [self showAlertStyle1];
    }
    else if (indexPath.row == 1) {
        [self showAlertStyle2];
    }
    else if (indexPath.row == 2) {
        [self showAlertStyle3];
    }
    else if (indexPath.row == 3) {
        [self showAlertWithTextFieldStyle1];
    }
    else if (indexPath.row == 4) {
        [self showAlertWithTextFieldStyle2];
    }
    else if (indexPath.row == 5) {
        [self showAlertWithTextFieldStyle3];
    }
}

#pragma mark - ===== ShowAlert =====
- (void)showAlertStyle1 {
    UIAlertController *alert = [UIAlertController alertWithTitle:@"标题2 Title 🙃" message:@"消息 Message " actionsTitleArr:@[@"确定"] alertAction:^(NSInteger actionIdx, UIAlertController *alertController) {
        NSLog(@"AlertStyle1---->点击事件");
    }];
    [alert showAlert];
}

- (void)showAlertStyle2 {
    UIAlertController *alert = [UIAlertController alertWithTitle:@"标题2 Title 🙃" message:@"消息 ✅ Message " actionsTitleArr:@[@"取消",@"确认"] alertAction:^(NSInteger actionIdx, UIAlertController *alertController) {
        if (actionIdx == 0) {
            NSLog(@"AlertStyle2---->点击 确定");
        }
        else if (actionIdx == 1) {
            NSLog(@"AlertStyle2---->点击 取消");
        }
    }];
    [alert showAlert];
}

- (void)showAlertStyle3 {
    NSArray *actionTitle = @[@"选项一",@"选项二",@"选项三",@"取消"];
    UIAlertController *alert = [UIAlertController alertWithTitle:@"标题3 Title 🙃" message:@"消息 ✅ Message " actionsTitleArr:actionTitle alertAction:^(NSInteger actionIdx, UIAlertController *alertController) {
        NSLog(@"AlertStyle3---->点击了 %@",actionTitle[actionIdx]);
    }];
    [alert showAlert];
}

//TextField最大长度限制
- (void)showAlertWithTextFieldStyle1 {
    NSInteger maxLenngth = 10;
    NSArray *actionTitle = @[@"取消",@"确认"];
    UIAlertController *alert = [UIAlertController alertWithTitle:@"TextField 标题1" message:@"消息 Message " actionsTitleArr:actionTitle alertAction:^(NSInteger actionIdx, UIAlertController *alertController) {
        NSLog(@"TextFieldStyle1---->点击了 %@ --->输入内容：%@",actionTitle[actionIdx],alertController.textFields.firstObject.text);
    }];
    [alert addTextFieldWithConfiguration:^(UITextField *textFieldConf) {
        textFieldConf.placeholder = [NSString stringWithFormat:@"最大长度:%ld",(long)maxLenngth];
    } observerTextFieldChanged:^(UITextField *textFieldObserver) {
        if (textFieldObserver.text.length >= maxLenngth) {
            textFieldObserver.text = [textFieldObserver.text substringToIndex:maxLenngth];
        }
    }];
    [alert showAlert];
}

//TextField最小长度限制
- (void)showAlertWithTextFieldStyle2 {
    NSInteger minLenngth = 10;
    NSArray *actionTitle = @[@"取消",@"确认"];
    UIAlertController *alert = [UIAlertController alertWithTitle:@"TextField 标题2" message:@"消息 Message " actionsTitleArr:actionTitle alertAction:^(NSInteger actionIdx, UIAlertController *alertController) {
        NSLog(@"TextFieldStyle1---->点击了 %@ --->输入内容：%@",actionTitle[actionIdx],alertController.textFields.firstObject.text);
    }];
    
    __weak typeof(alert) weakAlert = alert;
    //找出确认按钮
    UIAlertAction *okAction = [weakAlert.actions objectAtIndex:1];
    okAction.enabled = NO;
    // TextField
    [alert addTextFieldWithConfiguration:^(UITextField *textFieldConf) {
        textFieldConf.textColor = [UIColor orangeColor];
        textFieldConf.placeholder = [NSString stringWithFormat:@"最小长度:%ld",(long)minLenngth];
    } observerTextFieldChanged:^(UITextField *textFieldObserver) {
        okAction.enabled = (textFieldObserver.text.length >= minLenngth);
    }];
    [alert showAlert];
}

//多个TextField
- (void)showAlertWithTextFieldStyle3 {
    NSInteger minLenngth = 1;
    NSArray *actionTitle = @[@"取消",@"确认"];
    UIAlertController *alert = [UIAlertController alertWithTitle:@"TextField 标题3" message:@"消息 Message " actionsTitleArr:actionTitle alertAction:^(NSInteger actionIdx, UIAlertController *alertController) {
        NSLog(@"---->输入用户名：%@",alertController.textFields.firstObject.text);
        NSLog(@"---->输入密码：%@",alertController.textFields.lastObject.text);
        NSLog(@"TextFieldStyle3---->点击了 %@",actionTitle[actionIdx]);
    }];
    
    __weak typeof(alert) weakAlert = alert;
    __block BOOL hasUserName = NO;
    __block BOOL hasPassword = NO;
    //确认按钮
    UIAlertAction *okAction = weakAlert.actions.lastObject;
    okAction.enabled = NO;
    //用户名
    [alert addTextFieldWithConfiguration:^(UITextField *textFieldConf) {
        textFieldConf.placeholder = @"请输入用户名";
    } observerTextFieldChanged:^(UITextField *textFieldObserver) {
        hasUserName = (textFieldObserver.text.length >= minLenngth);
        okAction.enabled = (hasUserName && hasPassword);
    }];
    //密码
    [alert addTextFieldWithConfiguration:^(UITextField *textFieldConf) {
        textFieldConf.placeholder = @"请输入密码";
        textFieldConf.secureTextEntry = YES;
    } observerTextFieldChanged:^(UITextField *textFieldObserver) {
        hasPassword = (textFieldObserver.text.length >= minLenngth);
        okAction.enabled = (hasUserName && hasPassword);
    }];
    //show
    [alert showAlertCompletion:^{
        NSLog(@"---->已弹出输入用户名、密码界面");
    }];
}

@end

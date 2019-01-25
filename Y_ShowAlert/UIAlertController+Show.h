//
//  UIAlertController+Show.h
//  Y_ShowAlertExample
//
//  Created by Yue on 2017/6/26.
//  Copyright © 2017年 Yue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Show)

/**
 创建 UIAlertController，第一个按钮的样式为 UIAlertActionStyleCancel ，其他的则为 UIAlertActionStyleDefault
 @param title 标题
 @param message 内容
 @param titleArr 按钮标题数组
 @param alertAction 按钮的回调，actionIdx 为对应数组的 index ，alertController 为当前创建的 UIAlertController
 @return 返回创建的 UIAlertController
 */
+ (instancetype)alertWithTitle:(nullable NSString *)title message:(nullable NSString *)message actionsTitleArr:(NSArray <NSString *> *)titleArr alertAction:(void(^)(NSInteger actionIdx , UIAlertController *alertController))alertAction;

/**
 在 Alert 中增加一个 TextField， observer 中用了 TextFieldTextDidChange 来监听 TextField
 @param configuration 配置 TextField
 @param observer 根据 TextFieldTextDidChange 观察到的 TextField
 */
- (void)addTextFieldWithConfiguration:(void (^ __nullable)(UITextField *textFieldConf))configuration observerTextFieldChanged:(void (^)(UITextField *textFieldObserver))observer;

/**
 在指定VC上显示
 @param currentVC 指定VC
 */
- (void)showOnVC:(UIViewController *)currentVC;

/**
 在当前的 ViewController 中弹出 UIAlertController
 @param completed 弹出完成后的回调
 */
- (void)showAlertCompletion:(void(^)(void))completed;

/**
 在当前的 ViewController 中弹出 UIAlertController
 */
- (void)showAlert;

@end

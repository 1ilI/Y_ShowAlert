//
//  UIAlertController+Show.m
//  Y_ShowAlertExample
//
//  Created by Yue on 2017/6/26.
//  Copyright © 2017年 Yue. All rights reserved.
//

#import "UIAlertController+Show.h"

typedef UITextField *(^ObserverBlock)(UITextField *inputTextField);

@interface UIAlertController ()

@property (copy, nonatomic) ObserverBlock observerBlock;
@property (strong, nonatomic) UITextField *tmpTextField;

@end

@implementation UIAlertController (Show)
+ (instancetype)alertWithTitle:(nullable NSString *)title message:(nullable NSString *)message actionsTitleArr:(NSArray <NSString *> *)titleArr alertAction:(void(^)(NSInteger actionIdx , UIAlertController *alertController))alertAction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    __weak typeof(alert) weakAlert = alert;
    [titleArr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIAlertActionStyle style = UIAlertActionStyleDefault;
        //若选项多余两个的，则最后一个 Style 为 Cancel 其他的都是 Default
        if (titleArr.count > 2) {
            style = (idx == titleArr.count-1) ? UIAlertActionStyleCancel : UIAlertActionStyleDefault;
        }
        //若选项 为一个或两个的，则第一个 Style 为 Cancel 其他的都是 Default
        else {
            style = (idx == 0) ? UIAlertActionStyleCancel : UIAlertActionStyleDefault;
        }

        UIAlertAction *action = [UIAlertAction actionWithTitle:obj style:style handler:^(UIAlertAction * _Nonnull action) {
            __strong typeof(weakAlert) strongAlert = weakAlert;
            if (alertAction) {
                alertAction (idx, strongAlert);
            }
        }];
        [alert addAction:action];
    }];
    
//        for (NSInteger idx = 0; idx != titleArr.count; idx++) {
//            UIAlertActionStyle style = UIAlertActionStyleDefault;
//            //若选项多余两个的，则最后一个 Style 为 Cancel 其他的都是 Default
//            if (titleArr.count > 2) {
//                style = (idx == titleArr.count-1) ? UIAlertActionStyleCancel : UIAlertActionStyleDefault;
//            }
//            //若选项 为一个或两个的，则第一个 Style 为 Cancel 其他的都是 Default
//            else {
//                style = (idx == 0) ? UIAlertActionStyleCancel : UIAlertActionStyleDefault;
//            }
//            UIAlertAction *action = [UIAlertAction actionWithTitle:titleArr[idx] style:style handler:^(UIAlertAction * _Nonnull action) {
//                __strong typeof(weakAlert) strongAlert = weakAlert;
//                if (alertAction) {
//                    alertAction(idx, strongAlert);
//                }
//            }];
//            [alert addAction:action];
//        }
    return alert;
}

- (void)addTextFieldWithConfiguration:(void (^ __nullable)(UITextField *textFieldConf))configuration observerTextFieldChanged:(void (^)(UITextField *textFieldObserver))observer {
    [self addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        //观察 textField DidChange 通知
        [[NSNotificationCenter defaultCenter] addObserverForName:UITextFieldTextDidChangeNotification object:textField queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
            //获取到观察到的textField，返回给 observer()
            UITextField *observerTF = (UITextField *) note.object;
            observer (observerTF);
        }];
        
        //配置 alert 中的 textfield
        if (configuration) {
            configuration(textField);
        }
    }];
}

- (void)showAlert {
    [[self getCurrentVC] presentViewController:self animated:YES completion:nil];
}

- (void)showAlertCompletion:(void (^)(void))completed {
    [[self getCurrentVC] presentViewController:self animated:YES completion:completed];
}

//获取到当前的 ViewController
-(UIViewController *)getCurrentVC {
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tempWindow in windows) {
            if (tempWindow.windowLevel == UIWindowLevelNormal) {
                window = tempWindow;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    return result;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

@end

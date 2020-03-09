//
//  UIViewController+WXMLoadingHUD.m
//  ModuleDebugging
//
//  Created by edz on 2019/8/21.
//  Copyright © 2019 wq. All rights reserved.
//
#define WXMCurrentController (self.navigationController.visibleViewController == self)
#import <objc/runtime.h>
#import "WXMLoadingHUD.h"
#import "WXMLoadingHUDConfiguration.h"
#import "UIViewController+WXMLoadingHUD.h"

@implementation UIViewController (WXMLoadingHUD)

/** 普通 */
- (void)showLoadingView {
    if (WXMCurrentController) [WXMLoadingHUD hiddenLoadingWithSup:self.navigationController];
    [WXMLoadingHUD showLoadingWithSup:self
                          loadingType:WXMLoadingTypeLoading
                      interactionType:WXMLoadingInteractionDefault
                       contontMessage:nil
                        contontMargin:WXMLoadingMargin
                          hiddenDelay:0];
}

/** 禁止交互(全屏带颜色) */
- (void)showLoadingView_full {
    if (WXMCurrentController) [WXMLoadingHUD hiddenLoadingWithSup:self.navigationController];
    [WXMLoadingHUD showLoadingWithSup:self
                          loadingType:WXMLoadingTypeLoading
                      interactionType:WXMLoadingInteractionFull
                       contontMessage:nil
                        contontMargin:WXMLoadingMargin
                          hiddenDelay:0];
}

/** 禁止交互(非全屏)  */
- (void)showLoadingView_noEnd {
    if (WXMCurrentController) [WXMLoadingHUD hiddenLoadingWithSup:self.navigationController];
    [WXMLoadingHUD showLoadingWithSup:self
                          loadingType:WXMLoadingTypeLoading
                      interactionType:WXMLoadingInteractionNoEnabled
                       contontMessage:nil
                        contontMargin:WXMLoadingMargin
                          hiddenDelay:0];
}

/** 禁止界面和手势 */
- (void)showLoadingView_forbid {
    if (WXMCurrentController) [WXMLoadingHUD hiddenLoadingWithSup:self.navigationController];
    [WXMLoadingHUD showLoadingWithSup:self
                          loadingType:WXMLoadingTypeLoading
                      interactionType:WXMLoadingInteractionForbid
                       contontMessage:nil
                        contontMargin:WXMLoadingMargin
                          hiddenDelay:0];
}

/** 菊花 + 内容 */
- (void)showLoadingMessage:(NSString *)message {
    if (WXMCurrentController) [WXMLoadingHUD hiddenLoadingWithSup:self.navigationController];
    [WXMLoadingHUD showLoadingWithSup:self
                          loadingType:WXMLoadingTypeLoadingMessage
                      interactionType:WXMLoadingInteractionNoEnabled
                       contontMessage:message
                        contontMargin:WXMLoadingMargin
                          hiddenDelay:0];
    
}

/** 提示 */
- (void)showMessage:(NSString *)message {
    [WXMLoadingHUD showLoadingWithSup:self.navigationController
                          loadingType:WXMLoadingTypeMessage
                      interactionType:WXMLoadingInteractionDefault
                       contontMessage:message
                        contontMargin:WXMLoadingMargin
                          hiddenDelay:WXMHiddenDelay];
}

/** 成功 */
- (void)showSuccessMessage:(NSString * _Nullable)message {
    [WXMLoadingHUD showLoadingWithSup:self.navigationController
                          loadingType:WXMLoadingTypeSuccess
                      interactionType:WXMLoadingInteractionDefault
                       contontMessage:message
                        contontMargin:WXMLoadingMargin
                          hiddenDelay:WXMHiddenDelay];
    
}

/** 失败 */
- (void)showFailMessage:(NSString * _Nullable)message {
    [WXMLoadingHUD showLoadingWithSup:self.navigationController
                          loadingType:WXMLoadingTypeFail
                      interactionType:WXMLoadingInteractionDefault
                       contontMessage:message
                        contontMargin:WXMLoadingMargin
                          hiddenDelay:WXMHiddenDelay];
    
}

- (void)hiddenLoadingView {
    [WXMLoadingHUD hiddenLoadingWithSup:self];
}

+ (void)load {
    Method method1 = class_getInstanceMethod(self, @selector(viewWillAppear:));
    Method method2 = class_getInstanceMethod(self, @selector(__wxmloadingviewWillAppear:));
    method_exchangeImplementations(method1, method2);
}

/** 出现的时候把导航栏上的菊花先隐藏掉 */
- (void)__wxmloadingviewWillAppear:(BOOL)animated {
    [self __wxmloadingviewWillAppear:animated];
    if (![WXMLoadingHUD isLoadingWithSup:self]) return;
    [WXMLoadingHUD hiddenLoadingWithSup:self.navigationController];
}

@end

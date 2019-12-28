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
                          hiddenDelay:0];
}

/** 成功 */
- (void)showSuccessMessage:(NSString * _Nullable)message {
    [WXMLoadingHUD showLoadingWithSup:self.navigationController
                          loadingType:WXMLoadingTypeSuccess
                      interactionType:WXMLoadingInteractionDefault
                       contontMessage:message
                        contontMargin:WXMLoadingMargin
                          hiddenDelay:0];
    
}

/** 失败 */
- (void)showFailMessage:(NSString * _Nullable)message {
    [WXMLoadingHUD showLoadingWithSup:self.navigationController
                          loadingType:WXMLoadingTypeFail
                      interactionType:WXMLoadingInteractionDefault
                       contontMessage:message
                        contontMargin:WXMLoadingMargin
                          hiddenDelay:0];
    
}

- (void)hiddenLoadingView {
    [WXMLoadingHUD hiddenLoadingWithSup:self];
}

+ (void)load {
    SEL method1 = @selector(viewWillAppear:);
    SEL method2 = @selector(__wxmloadingviewWillAppear:);
    [self swizzleInstanceMethod:method1 with:method2];
}

- (void)__wxmloadingviewWillAppear:(BOOL)animated {
    [self __wxmloadingviewWillAppear:animated];
    if (![WXMLoadingHUD isLoadingWithSup:self]) return;
    [WXMLoadingHUD hiddenLoadingWithSup:self.navigationController];
}

/** -方法 */
+ (BOOL)swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel {
    Method original = class_getInstanceMethod(self, originalSel);
    Method newMethod = class_getInstanceMethod(self, newSel);
    if (!original || !newMethod) return NO;
    
    IMP originalImp = class_getMethodImplementation(self, originalSel);
    IMP newMethodImp = class_getMethodImplementation(self, newSel);
    class_addMethod(self, originalSel, originalImp, method_getTypeEncoding(original));
    class_addMethod(self, newSel, newMethodImp, method_getTypeEncoding(newMethod));
    method_exchangeImplementations(class_getInstanceMethod(self, originalSel),
                                   class_getInstanceMethod(self, newSel));
    return YES;
}
@end

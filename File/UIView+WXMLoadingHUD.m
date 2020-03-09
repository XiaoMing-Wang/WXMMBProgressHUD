//
//  UIView+WXMLoadingHUD.m
//  ModuleDebugging
//
//  Created by edz on 2019/8/21.
//  Copyright © 2019 wq. All rights reserved.
//

#import "UIView+WXMLoadingHUD.h"
#import "WXMLoadingHUDConfiguration.h"

@implementation UIView (WXMLoadingHUD)

/** 普通 */
- (void)showLoadingView {
    [WXMLoadingHUD showLoadingWithSup:self
                          loadingType:WXMLoadingTypeLoading
                      interactionType:WXMLoadingInteractionDefault
                       contontMessage:nil
                        contontMargin:WXMLoadingMargin
                          hiddenDelay:0];
}

/** 禁止交互(全屏带颜色) */
- (void)showLoadingView_full {
    [WXMLoadingHUD showLoadingWithSup:self
                          loadingType:WXMLoadingTypeLoading
                      interactionType:WXMLoadingInteractionFull
                       contontMessage:nil
                        contontMargin:WXMLoadingMargin
                          hiddenDelay:0];
}

/** 禁止交互(非全屏)  */
- (void)showLoadingView_noEnd {
    [WXMLoadingHUD showLoadingWithSup:self
                          loadingType:WXMLoadingTypeLoading
                      interactionType:WXMLoadingInteractionNoEnabled
                       contontMessage:nil
                        contontMargin:WXMLoadingMargin
                          hiddenDelay:0];
}

/** 菊花 + 内容 */
- (void)showLoadingMessage:(NSString *)message {
    [WXMLoadingHUD showLoadingWithSup:self
                          loadingType:WXMLoadingTypeLoadingMessage
                      interactionType:WXMLoadingInteractionNoEnabled
                       contontMessage:message
                        contontMargin:WXMLoadingMargin
                          hiddenDelay:0];
    
}

/** 提示 */
- (void)showMessage:(NSString *)message {
    [WXMLoadingHUD showLoadingWithSup:self
                          loadingType:WXMLoadingTypeMessage
                      interactionType:WXMLoadingInteractionDefault
                       contontMessage:message
                        contontMargin:WXMLoadingMargin
                          hiddenDelay:0];
}

/** 成功 */
- (void)showSuccessMessage:(NSString * _Nullable)message {
    [WXMLoadingHUD showLoadingWithSup:self
                          loadingType:WXMLoadingTypeSuccess
                      interactionType:WXMLoadingInteractionDefault
                       contontMessage:message
                        contontMargin:WXMLoadingMargin
                          hiddenDelay:0];
    
}

/** 失败 */
- (void)showFailMessage:(NSString * _Nullable)message {
    [WXMLoadingHUD showLoadingWithSup:self
                          loadingType:WXMLoadingTypeFail
                      interactionType:WXMLoadingInteractionDefault
                       contontMessage:message
                        contontMargin:WXMLoadingMargin
                          hiddenDelay:0];
    
}

@end

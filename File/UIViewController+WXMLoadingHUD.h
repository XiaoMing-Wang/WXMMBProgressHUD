//
//  UIViewController+WXMLoadingHUD.h
//  ModuleDebugging
//
//  Created by edz on 2019/8/21.
//  Copyright © 2019 wq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (WXMLoadingHUD)

#pragma mark 显示在viewcontroller上
#pragma mark 显示在viewcontroller上
#pragma mark 显示在viewcontroller上

/** 普通 */
- (void)showLoadingView;

/** 禁止交互(全屏带颜色) */
- (void)showLoadingView_full;

/** 禁止交互(非全屏)  */
- (void)showLoadingView_noEnd;

/** 禁止界面和手势 */
- (void)showLoadingView_forbid;

/** 隐藏 */
- (void)hiddenLoadingView;

/** 菊花 + 内容 */
- (void)showLoadingMessage:(NSString *)message;

#pragma mark 显示在导航控制器上
#pragma mark 显示在导航控制器上
#pragma mark 显示在导航控制器上

/** 内容 持续时间WXMHiddenDelay */
- (void)showMessage:(NSString *)message;

/** 成功 持续时间WXMHiddenDelay */
- (void)showSuccessMessage:(NSString *_Nullable)message;

/** 失败 持续时间WXMHiddenDelay */
- (void)showFailMessage:(NSString *_Nullable)message;

@end

NS_ASSUME_NONNULL_END

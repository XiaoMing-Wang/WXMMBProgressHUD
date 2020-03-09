//
//  UIView+WXMLoadingHUD.h
//  ModuleDebugging
//
//  Created by edz on 2019/8/21.
//  Copyright © 2019 wq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXMLoadingHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (WXMLoadingHUD)

/** 普通 */
- (void)showLoadingView;

/** 禁止交互(全屏带颜色) */
- (void)showLoadingView_full;

/** 禁止交互(非全屏)  */
- (void)showLoadingView_noEnd;

/** 隐藏 */
- (void)hiddenLoadingView;

/** 菊花 + 内容 */
- (void)showLoadingMessage:(NSString *)message;

/** 内容 */
- (void)showMessage:(NSString *)message;

/** 成功 */
- (void)showSuccessMessage:(NSString *_Nullable)message;

/** 失败 */
- (void)showFailMessage:(NSString *_Nullable)message;

@end

NS_ASSUME_NONNULL_END

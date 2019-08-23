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

/** 普通 */
- (void)showLoadingView;

/** 禁止交互(全屏带颜色) */
- (void)showLoadingView_full;

/** 禁止交互(非全屏)  */
- (void)showLoadingView_noEnd;

/** 禁止界面和手势 */
- (void)showLoadingView_forbid;

/** message */
- (void)showLoadingMessage:(NSString *)message;
- (void)showSuccessMessage:(NSString *_Nullable)message;
- (void)showFailMessage:(NSString *_Nullable)message;
- (void)hiddenLoadingView;
@end

NS_ASSUME_NONNULL_END

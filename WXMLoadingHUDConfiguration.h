//
//  WXMLoadingHUDConfiguration.h
//  ModuleDebugging
//
//  Created by edz on 2019/8/21.
//  Copyright © 2019 wq. All rights reserved.
//

#ifndef WXMLoadingHUDConfiguration_h
#define WXMLoadingHUDConfiguration_h

/** loading大小 */
#define WXMLoadSize CGSizeMake(76.5, 77.5)

/** 状态大小 */
#define WXMLoadStatusSize CGSizeMake(93.5, 93.5)

/** icon大小 */
#define WXMLoadIconSize CGSizeMake(35, 35)

/** 显示动画 */
#define WXMAnimationDisplay YES

/** 切换动画 */
#define WXMAnimationChange YES

/** 隐藏时间 */
#define WXMHiddenDelay 4.0f

/** 字体 */
#define WXMLoadFont [UIFont systemFontOfSize:15.0]

/** tag */
#define WXMLoadingTag 10555

/** 垂直偏移 */
#define WXMLoadingMargin 0.0

/** 外边距 */
#define WXMLoadingOutsideMargin 40.0

/** 内边距 */
#define WXMLoadingpadMargin 17.0

/** 圆角 */
#define WXMLoadingRounded 11.0

/** 导航偏移 */
#define WXMLoadingNavigationOff 8.0

/** 最小高度 */
#define WXMLoadingMinHeight 49.0

/**  */
#define WXMLSWidth [UIScreen mainScreen].bounds.size.width

/** 全局颜色 */
#define WXMLoadingFullColor [UIColor whiteColor]

/** 背景色 */
#define WXMLoadingBackColor [[UIColor blackColor] colorWithAlphaComponent:0.90]

#define kLoadingIPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);\
})

#endif /* WXMLoadingHUDConfiguration_h */

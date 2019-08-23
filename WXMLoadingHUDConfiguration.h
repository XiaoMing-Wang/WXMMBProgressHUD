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
#define WXMHiddenDelay 3.5f

/** 字体 */
#define WXMLoadFont [UIFont systemFontOfSize:15.5]

/** tag */
#define WXMLoadingTag 102000

/** 垂直偏移 */
#define WXMLoadingMargin -10

/** 外边距 */
#define WXMLoadingOutsideMargin 40

/** 内边距 */
#define WXMLoadingpadMargin 20

/** 圆角 */
#define WXMLoadingRounded 12

/** 导航偏移 */
#define WXMLoadingNavigationOff 8

/** 最小高度 */
#define WXMLoadingMinHeight 49

/**  */
#define WXMLSWidth [UIScreen mainScreen].bounds.size.width

/** 全局颜色 */
#define WXMLoadingFullColor [UIColor whiteColor]

/** 背景色 */
#define WXMLoadingBackColor UIColor.blackColor


#endif /* WXMLoadingHUDConfiguration_h */

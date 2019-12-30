//
//  WXMLoadingHUD.h
//  ModuleDebugging
//
//  Created by edz on 2019/8/21.
//  Copyright © 2019 wq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger, WXMLoadingInteractionType) {
    
    /** 默认 */
    WXMLoadingInteractionDefault = 0,
    
    /** 不响应 */
    WXMLoadingInteractionNoEnabled,
    
    /** 全局颜色 */
    WXMLoadingInteractionFull,
    
    /** 禁止交互包括手势 */
    WXMLoadingInteractionForbid,
};

typedef NS_ENUM(NSUInteger, WXMLoadingType) {
    
    /** 菊花 */
    WXMLoadingTypeLoading = 0,
    
    /** 提示 */
    WXMLoadingTypeMessage,
    
    /** 菊花+提示 */
    WXMLoadingTypeLoadingMessage,
    
    /** 成功 */
    WXMLoadingTypeSuccess,
    
    /** 失败 */
    WXMLoadingTypeFail,
};

@interface WXMLoadingHUD : UIView

/** 类型 */
@property (nonatomic, assign) WXMLoadingType loadingType;

/** 是否能响应 */
@property (nonatomic, assign) WXMLoadingInteractionType interactionType;

/** 延迟时间 */
@property (nonatomic, assign) CGFloat hiddenDelay;


+ (void)showLoadingWithSup:(id)supMedium
               loadingType:(WXMLoadingType)loadingType
           interactionType:(WXMLoadingInteractionType)interactionType
            contontMessage:(NSString * _Nullable)message
             contontMargin:(CGFloat)contontMargin
               hiddenDelay:(CGFloat)hiddenDelay;

+ (void)hiddenLoadingWithSup:(id)supMedium;
+ (BOOL)isLoadingWithSup:(id)supMedium;
@end

NS_ASSUME_NONNULL_END

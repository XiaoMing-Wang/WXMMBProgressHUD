//
//  WXMLoadingHUD.m
//  ModuleDebugging
//
//  Created by edz on 2019/8/21.
//  Copyright © 2019 wq. All rights reserved.
//

#import "WXMLoadingHUD.h"
#import "WXMLoadingHUDConfiguration.h"
@interface WXMLoadingHUD ()

#pragma mark UI
@property (nonatomic, weak) UIView *displayView;
@property (nonatomic, weak) UIViewController *displayViewController;

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

/**  */
@property (nonatomic, copy) NSString *contontMessage;

/** 垂直偏移 */
@property (nonatomic, assign) CGFloat contontMargin;
@property (nonatomic, assign) BOOL exsitBefore;
@property (nonatomic, assign) BOOL needOffset;
@property (nonatomic, assign) BOOL lastPopGesture;
@end

@implementation WXMLoadingHUD

+ (void)showLoadingWithSup:(id)supMedium
               loadingType:(WXMLoadingType)loadingType
           interactionType:(WXMLoadingInteractionType)interactionType
            contontMessage:(NSString * _Nullable)message
             contontMargin:(CGFloat)contontMargin
               hiddenDelay:(CGFloat)hiddenDelay {
    
    if (supMedium == nil) return;
    WXMLoadingHUD *currentLoading = [self currentLoading:supMedium];
    UIView *displayView = [WXMLoadingHUD supViewSupMedium:supMedium];
    if (!currentLoading) currentLoading = [[WXMLoadingHUD alloc] init];
    if ([supMedium isKindOfClass:UIViewController.class]) {
        currentLoading.displayViewController = (UIViewController *)supMedium;
    }
    
    currentLoading.tag = WXMLoadingTag;
    currentLoading.contontMessage = message.copy;
    currentLoading.displayView = displayView;
    currentLoading.hiddenDelay = hiddenDelay;
    currentLoading.loadingType = loadingType;
    currentLoading.interactionType = interactionType;
    [currentLoading setDifferentInterfaces];
    [currentLoading setDifferentConfiguration];
    [currentLoading showInSupView];
}

+ (void)hiddenLoadingWithSup:(id)supMedium {
    if (supMedium == nil) return;
    WXMLoadingHUD *currentLoading = [self currentLoading:supMedium];
    [currentLoading hiddenInSupView];
}

+ (BOOL)isLoadingWithSup:(id)supMedium {
    if (supMedium == nil) return NO;
    WXMLoadingHUD *currentLoading = [self currentLoading:supMedium];
    if (currentLoading == nil) return NO;
    return (currentLoading.loadingType == WXMLoadingTypeLoading);
}

/** 设置不同的界面 */
- (void)setDifferentInterfaces {
    self.frame = (CGRect) { CGPointZero, self.displayView.frame.size };
    if (self.interactionType == WXMLoadingInteractionDefault) {
        self.userInteractionEnabled = NO;
        self.backgroundColor = [UIColor clearColor];
    } else if (self.interactionType == WXMLoadingInteractionNoEnabled) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
    } else if (self.interactionType == WXMLoadingInteractionFull) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = WXMLoadingFullColor;
    } else if (self.interactionType == WXMLoadingInteractionForbid) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
        
        self.lastPopGesture = self.displayViewController.navigationController.
        interactivePopGestureRecognizer.enabled;
        self.displayViewController.navigationController.
        interactivePopGestureRecognizer.enabled = NO;
    }
    
    
    /** 菊花 */
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (self.loadingType == WXMLoadingTypeLoading) {
        self.contentView.frame = (CGRect) { CGPointZero, WXMLoadSize };
        [self.contentView addSubview:self.indicatorView];
        
    /** 提示 */
    } else if (self.loadingType == WXMLoadingTypeMessage) {
        self.messageLabel.text = self.contontMessage;
        self.contentView.frame = (CGRect) { CGPointZero, self.getMessageSize };
        [self.contentView addSubview:self.messageLabel];
        
    /** 成功失败 */
    } else if (self.loadingType == WXMLoadingTypeSuccess ||
               self.loadingType == WXMLoadingTypeFail) {
        
        self.messageLabel.text = self.contontMessage;
        CGSize statusSize = self.getSuccessOrFailSize;
        if (self.loadingType == WXMLoadingTypeSuccess) {
            self.iconImageView.image = [UIImage imageNamed:@"MBHUD_Success"];
        } else if (self.loadingType == WXMLoadingTypeFail) {
            self.iconImageView.image = [UIImage imageNamed:@"MBHUD_Warn"];
        }
        
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.messageLabel];
        self.contentView.frame = (CGRect) { CGPointZero, statusSize };
    }
    
    [self addSubview:self.contentView];
    [self displayCenter:(self.loadingType == WXMLoadingTypeLoading ||
                         self.loadingType == WXMLoadingTypeMessage)];
}

/** 不同的配置 */
- (void)setDifferentConfiguration {
    SEL sel = @selector(hiddenInSupViewWithType);
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:sel object:nil];
    if (self.loadingType == WXMLoadingTypeLoading) {
    } else if (self.loadingType == WXMLoadingTypeMessage) {
        [self performSelector:sel withObject:nil afterDelay:WXMHiddenDelay];
    } else if (self.loadingType == WXMLoadingTypeSuccess) {
        [self performSelector:sel withObject:nil afterDelay:WXMHiddenDelay];
    } else if (self.loadingType == WXMLoadingTypeFail) {
        [self performSelector:sel withObject:nil afterDelay:WXMHiddenDelay];
    }
}

/** 显示在中心 */
- (void)displayCenter:(BOOL)inCenter {
    CGFloat x = self.frame.size.width / 2;
    CGFloat y = self.frame.size.height / 2;
    self.contentView.center = CGPointMake(x, y + self.contontMargin);
    
    CGFloat cX = self.contentView.frame.size.width / 2;
    CGFloat cY = self.contentView.frame.size.height / 2;
    if (inCenter) {
        self.indicatorView.center = CGPointMake(cX, cY);
        self.messageLabel.center = CGPointMake(cX, cY);
    } else {
        CGFloat x = (self.contentView.frame.size.width - WXMLoadIconSize.width) / 2;
        CGPoint oringin = CGPointMake(x, WXMLoadingpadMargin - 3);
        self.iconImageView.frame = (CGRect) {oringin, WXMLoadIconSize};
        
        CGFloat top = self.iconImageView.frame.origin.y + self.iconImageView.frame.size.height;
        CGPoint oringinMess = CGPointMake(0, top + 10);
        self.messageLabel.frame = (CGRect) {oringinMess, self.messageLabel.frame.size};
        self.messageLabel.center = CGPointMake(cX, self.messageLabel.center.y);
    }
}

/** 显示 */
- (void)showInSupView {
    [self.displayView addSubview:self];
}

/** 消失 */
- (void)hiddenInSupView {
    self.displayViewController.navigationController.
    interactivePopGestureRecognizer.enabled = self.lastPopGesture;
    [self removeFromSuperview];
}

- (void)hiddenInSupViewWithType {
    if (self.loadingType == WXMLoadingTypeLoading) return;
    [self hiddenInSupView];
}

/** 获取文字的大size */
- (CGSize)getMessageSize {
    if (self.messageLabel.text.length == 0) return CGSizeZero;
    [self.messageLabel sizeToFit];
    
    CGSize size = self.messageLabel.frame.size;
    CGFloat maxWidth = WXMLSWidth - 2 * WXMLoadingOutsideMargin;
    
    /** 内边距 */
    CGFloat padding = WXMLoadingpadMargin * 2;
    
    /** 宽度  */
    CGFloat width = MIN(maxWidth, size.width + padding);
    
    /** 高度 */
    CGFloat height = MAX(WXMLoadingMinHeight, size.height + padding);
    
    return CGSizeMake(width, height);
}

/** 获取状态的size */
- (CGSize)getSuccessOrFailSize {
    CGSize messageSize = self.getMessageSize;
    if (CGSizeEqualToSize(messageSize, CGSizeZero)) return WXMLoadSize;
    if (self.contontMessage.length <= 8) return WXMLoadStatusSize;
    CGFloat width = messageSize.width;
    CGFloat height = messageSize.height;
    if (width < WXMLoadStatusSize.width) width = WXMLoadStatusSize.width;
    height = WXMLoadIconSize.height + messageSize.height + 7;
    return CGSizeMake(width, height);
}

/** 获取父视图 */
+ (UIView *)supViewSupMedium:(id)supMedium {
    if ([supMedium isKindOfClass:[UIViewController class]]) {
        return ((UIViewController *) supMedium).view;
    } else if ([supMedium isKindOfClass:[UIView class]]) {
        return ((UIView *) supMedium);
    }
    return nil;
}

/** 获取当前 WXMLoadingHUD */
+ (WXMLoadingHUD *)currentLoading:(id)supMedium {
    UIView *supView = [self supViewSupMedium:supMedium];
    WXMLoadingHUD *currentView = [supView viewWithTag:WXMLoadingTag];
    if (currentView) currentView.exsitBefore = YES;
    return currentView ?: nil;
}

- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] init];
        _indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        _indicatorView.hidesWhenStopped = NO;
        [_indicatorView startAnimating];
    }
    return _indicatorView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        _contentView.backgroundColor = [WXMLoadingBackColor colorWithAlphaComponent:.85];
        _contentView.layer.cornerRadius = WXMLoadingRounded;
        _contentView.layer.masksToBounds = YES;
    }
    return _contentView;
}

- (UILabel *)messageLabel {
    if (!_messageLabel) {
        CGFloat width = WXMLSWidth - (2 * WXMLoadingOutsideMargin) - 2 * WXMLoadingpadMargin;
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
        _messageLabel.textAlignment = NSTextAlignmentLeft;
        _messageLabel.font = WXMLoadFont;
        _messageLabel.textColor = [UIColor whiteColor];;
        _messageLabel.numberOfLines = 0;
    }
    return _messageLabel;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.frame = (CGRect) { CGPointZero, WXMLoadIconSize };
    }
    return _iconImageView;
}
@end

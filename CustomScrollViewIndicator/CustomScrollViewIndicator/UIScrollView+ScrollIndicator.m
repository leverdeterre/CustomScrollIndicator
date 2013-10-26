//
//  UIScrollView+ScrollIndicator.m
//  CustomScrollViewIndicator
//
//  Created by Jerome Morissard on 10/25/13.
//  Copyright (c) 2013 Jerome Morissard. All rights reserved.
//

#import "UIScrollView+ScrollIndicator.h"
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>

#define BNPScrollIndicatorHeight 7.0f
#define BNPScrollIndicatorBottomSpace 2.0f
#define BNPScrollIndicatorWidth 50.0f

static char viewScrollIndicatorKey;
static char viewScrollIndicatorVerticalPosKey;
static char viewScrollIndicatorHorizontalPosKey;

@implementation UIScrollView (ScrollIndicator)

#pragma mark - Storage

- (void) setViewHForHorizontalScrollIndicator:(UIView*)viewScrollIndicator {
    objc_setAssociatedObject(self, &viewScrollIndicatorKey,
                             viewScrollIndicator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView*) getViewForHorizontalScrollIndicator {
    return objc_getAssociatedObject(self, &viewScrollIndicatorKey);
}

- (void) setVerticalIndicatorPosition:(JMOVerticalScrollIndicatorPosition)position {
    objc_setAssociatedObject(self, &viewScrollIndicatorVerticalPosKey,
                             [NSNumber numberWithInteger:position], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (JMOVerticalScrollIndicatorPosition)getVerticalIndicatorPosition
{
    return [objc_getAssociatedObject(self, &viewScrollIndicatorVerticalPosKey) integerValue];
}

- (void) setHorizontalIndicatorPosition:(JMOHorizontalScrollIndicatorPosition)position {
    objc_setAssociatedObject(self, &viewScrollIndicatorHorizontalPosKey,
                             [NSNumber numberWithInteger:position], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (JMOHorizontalScrollIndicatorPosition)getHorizontalIndicatorPosition
{
    return [objc_getAssociatedObject(self, &viewScrollIndicatorHorizontalPosKey) integerValue];
}

#pragma mark -

- (void) enableCustomHorizontalWithScrollVerticalIndicator:(JMOVerticalScrollIndicatorPosition)vPos withHorizontalIndicator:(JMOHorizontalScrollIndicatorPosition)hPos withColor:(UIColor *)indicatorColor
{
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    [self setVerticalIndicatorPosition:vPos];
    [self setHorizontalIndicatorPosition:hPos];
    
    CGRect frame = CGRectZero;
    if (hPos == JMOHorizontalScrollIndicatorPositionBottom) {
        frame = CGRectMake(0.0f, self.frame.size.height - BNPScrollIndicatorHeight - BNPScrollIndicatorBottomSpace, BNPScrollIndicatorWidth,BNPScrollIndicatorHeight);
    }
    else {
        frame = CGRectMake(0.0f, BNPScrollIndicatorBottomSpace, BNPScrollIndicatorWidth,BNPScrollIndicatorHeight);
    }
    
    
    UIView *viewScrollIndicator = [[UIView alloc] initWithFrame:frame];
    viewScrollIndicator.alpha = 0.0f;
    viewScrollIndicator.layer.cornerRadius = BNPScrollIndicatorHeight/2.0f;
    
    /*
    viewScrollIndicator.layer.borderWidth = 1.0f;
    viewScrollIndicator.layer.borderColor = indicatorColor.CGColor;
    */
    
    [viewScrollIndicator setBackgroundColor:[indicatorColor colorWithAlphaComponent:0.75]];
    [self setViewHForHorizontalScrollIndicator:viewScrollIndicator];
    [self addSubview:viewScrollIndicator];
}

- (void) enableCustomHorizontalScroll
{    
    [self enableCustomHorizontalWithScrollVerticalIndicator:JMOVerticalScrollIndicatorPositionRight withHorizontalIndicator:JMOHorizontalScrollIndicatorPositionBottom withColor:[UIColor blackColor]];
}

- (void)refreshCustomScrollIndicatorWithAlpha:(CGFloat)alpha
{
    JMOVerticalScrollIndicatorPosition posV = [self getVerticalIndicatorPosition];
    JMOHorizontalScrollIndicatorPosition posH = [self getHorizontalIndicatorPosition];
        
    UIView *viewScrollIndicator = [self getViewForHorizontalScrollIndicator];
    viewScrollIndicator.alpha = alpha;
    CGFloat pourcent = self.contentOffset.x / (self.contentSize.width - self.frame.size.width);
    CGRect rect =  viewScrollIndicator.frame;
    
    if (posH == JMOHorizontalScrollIndicatorPositionBottom) {
        rect.origin.x =  self.contentOffset.x + MAX(0.0f,(pourcent * self.frame.size.width) - viewScrollIndicator.frame.size.width);
    }
    else {
        rect.origin.x =  self.contentOffset.x + MAX(0.0f,(pourcent * self.frame.size.width) - viewScrollIndicator.frame.size.width);
    }
    
    rect.origin.x =  self.contentOffset.x + MAX(0.0f,(pourcent * self.frame.size.width) - viewScrollIndicator.frame.size.width);
    viewScrollIndicator.frame = rect;
}

- (void)refreshCustomScrollIndicator
{
    [self refreshCustomScrollIndicatorWithAlpha:1.0f];
}


@end

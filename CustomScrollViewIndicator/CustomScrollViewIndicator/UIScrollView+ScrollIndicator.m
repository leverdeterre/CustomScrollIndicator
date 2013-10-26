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

#define JMOScrollIndicatorHeight 7.0f
#define JMOScrollIndicatorHeightPageControl 20.0f
#define JMOScrollIndicatorBottomSpace 2.0f
#define JMOScrollIndicatorWidth 50.0f

#define JMOScrollIndicatorPageControlNumberOfPages 5

static char viewScrollIndicatorKey;
static char viewScrollIndicatorVerticalPosKey;
static char viewScrollIndicatorHorizontalPosKey;
static char viewScrollIndicatorTypeKey;

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

- (void) setScrollIndicatorType:(JMOScrollIndicatorType)type
{
    objc_setAssociatedObject(self, &viewScrollIndicatorTypeKey,
                             [NSNumber numberWithInteger:type], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (JMOScrollIndicatorType)getScrollIndicatorType
{
    return [objc_getAssociatedObject(self, &viewScrollIndicatorTypeKey) integerValue];
}

#pragma mark -

- (void) enableCustomHorizontalWithScrollVerticalIndicator:(JMOVerticalScrollIndicatorPosition)vPos withHorizontalIndicator:(JMOHorizontalScrollIndicatorPosition)hPos withColor:(UIColor *)indicatorColor withIndicatorStyle:(JMOScrollIndicatorType)style
{
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    [self setVerticalIndicatorPosition:vPos];
    [self setHorizontalIndicatorPosition:hPos];
    [self setScrollIndicatorType:style];

    CGRect frame = CGRectZero;
    CGFloat height = 0.0f;
    if (style == JMOScrollIndicatorTypeDefault) {
        height = JMOScrollIndicatorHeight;
    }
    else {
        height = JMOScrollIndicatorHeightPageControl;
    }
    
    if (hPos == JMOHorizontalScrollIndicatorPositionBottom) {
        frame = CGRectMake(0.0f, self.frame.size.height - height - JMOScrollIndicatorBottomSpace, JMOScrollIndicatorWidth,height);
    }
    else {
        frame = CGRectMake(0.0f, JMOScrollIndicatorBottomSpace, JMOScrollIndicatorWidth,height);
    }
    
    if (style == JMOScrollIndicatorTypeDefault) {
        UIView *viewScrollIndicator = [[UIView alloc] initWithFrame:frame];
        viewScrollIndicator.alpha = 0.0f;
        viewScrollIndicator.layer.cornerRadius = height/2.0f;
        
        /*
         viewScrollIndicator.layer.borderWidth = 1.0f;
         viewScrollIndicator.layer.borderColor = indicatorColor.CGColor;
         */
        
        [viewScrollIndicator setBackgroundColor:[indicatorColor colorWithAlphaComponent:0.75]];
        [self setViewHForHorizontalScrollIndicator:viewScrollIndicator];
        [self addSubview:viewScrollIndicator];
    }
    else if (style == JMOScrollIndicatorTypePageControl) {
        UIPageControl *pageCOntrol = [[UIPageControl alloc] initWithFrame:frame];
        [pageCOntrol setNumberOfPages:JMOScrollIndicatorPageControlNumberOfPages];
        [pageCOntrol setCurrentPage:0];
        pageCOntrol.backgroundColor = [UIColor clearColor];
        pageCOntrol.alpha = 0.0f;

        if ([pageCOntrol respondsToSelector:@selector(pageIndicatorTintColor)]) {
            pageCOntrol.pageIndicatorTintColor = [indicatorColor colorWithAlphaComponent:0.15];
            pageCOntrol.currentPageIndicatorTintColor = indicatorColor;
        }
        
        [self setViewHForHorizontalScrollIndicator:pageCOntrol];
        [self addSubview:pageCOntrol];
    }
}

- (void) enableCustomHorizontalScroll
{
    [self enableCustomHorizontalWithScrollVerticalIndicator:JMOVerticalScrollIndicatorPositionRight withHorizontalIndicator:JMOHorizontalScrollIndicatorPositionBottom withColor:[UIColor blackColor] withIndicatorStyle:JMOScrollIndicatorTypeDefault];
}

- (void)refreshCustomScrollIndicatorWithAlpha:(CGFloat)alpha
{
    JMOVerticalScrollIndicatorPosition posV = [self getVerticalIndicatorPosition];
    JMOHorizontalScrollIndicatorPosition posH = [self getHorizontalIndicatorPosition];
    
    UIView *viewScrollIndicator = [self getViewForHorizontalScrollIndicator];
    JMOScrollIndicatorType style = [self getScrollIndicatorType];
    
    viewScrollIndicator.alpha = alpha;
    CGFloat pourcent = self.contentOffset.x / (self.contentSize.width - self.frame.size.width);
    CGRect rect =  viewScrollIndicator.frame;
    
    if (style == JMOScrollIndicatorTypePageControl) {
        if ([viewScrollIndicator isKindOfClass:[UIPageControl class]]) {
            UIPageControl *pageControl = (UIPageControl *)viewScrollIndicator;
            [pageControl setCurrentPage:pageControl.numberOfPages*pourcent];
        }
        
        rect.origin.x =  self.contentOffset.x + MAX(0.0f,(0.5 * self.frame.size.width) - viewScrollIndicator.frame.size.width/2);
    }
    else {
        rect.origin.x =  self.contentOffset.x + MAX(0.0f,(pourcent * self.frame.size.width) - viewScrollIndicator.frame.size.width);
    }
    
    viewScrollIndicator.frame = rect;
}

- (void)refreshCustomScrollIndicator
{
    [self refreshCustomScrollIndicatorWithAlpha:1.0f];
}


@end

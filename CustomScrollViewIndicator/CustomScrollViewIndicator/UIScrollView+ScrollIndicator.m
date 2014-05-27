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

static char viewScrollIndicatorKeyH;
static char viewScrollIndicatorKeyV;
static char viewScrollIndicatorVerticalPosKey;
static char viewScrollIndicatorHorizontalPosKey;
static char viewScrollIndicatorTypeKey;

@implementation UIScrollView (ScrollIndicator)

#pragma mark - Storage

- (void) setViewHForHorizontalScrollIndicator:(UIView*)viewScrollIndicator {
    objc_setAssociatedObject(self, &viewScrollIndicatorKeyH,
                             viewScrollIndicator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView*) getViewForHorizontalScrollIndicator {
    return objc_getAssociatedObject(self, &viewScrollIndicatorKeyH);
}

- (void) setViewHForVerticalScrollIndicator:(UIView*)viewScrollIndicator {
    objc_setAssociatedObject(self, &viewScrollIndicatorKeyV,
                             viewScrollIndicator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView*) getViewForVerticalScrollIndicator {
    return objc_getAssociatedObject(self, &viewScrollIndicatorKeyV);
}


- (void) setVerticalIndicatorPosition:(JMOScrollIndicatorPosition)position {
    objc_setAssociatedObject(self, &viewScrollIndicatorVerticalPosKey,@(position), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (JMOScrollIndicatorPosition)getVerticalIndicatorPosition
{
    return (int)[objc_getAssociatedObject(self, &viewScrollIndicatorVerticalPosKey) integerValue];
}

- (void) setHorizontalIndicatorPosition:(JMOScrollIndicatorPosition)position {
    objc_setAssociatedObject(self, &viewScrollIndicatorHorizontalPosKey, @(position), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (JMOScrollIndicatorPosition)getHorizontalIndicatorPosition
{
    return (int)[objc_getAssociatedObject(self, &viewScrollIndicatorHorizontalPosKey) integerValue];
}

- (void) setScrollIndicatorType:(JMOScrollIndicatorType)type
{
    objc_setAssociatedObject(self, &viewScrollIndicatorTypeKey,@(type), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (JMOScrollIndicatorType)getScrollIndicatorType
{
    return (int)[objc_getAssociatedObject(self, &viewScrollIndicatorTypeKey) integerValue];
}

#pragma mark -

-(void) enableCustomVerticalScrollIndicator:(JMOScrollIndicatorPosition)vPos withColor:(UIColor *)indicatorColor withIndicatorStyle:(JMOScrollIndicatorType)style
{
    self.showsVerticalScrollIndicator = NO;
    [self setVerticalIndicatorPosition:vPos];
    [self setScrollIndicatorType:style];

    CGRect frame = CGRectZero;
    CGFloat width = 0.0f;
    if (style == JMOScrollIndicatorTypeClassic) {
        width = JMOScrollIndicatorHeight;
    }
    else {
        width = JMOScrollIndicatorHeightPageControl;
    }
    
    if (vPos == JMOVerticalScrollIndicatorPositionRight) {
        frame = CGRectMake(self.frame.size.width - width - JMOScrollIndicatorBottomSpace, 0.0f, JMOScrollIndicatorHeight,JMOScrollIndicatorWidth);
    }
    else {
        frame = CGRectMake(JMOScrollIndicatorBottomSpace, 0.0f, JMOScrollIndicatorHeight,JMOScrollIndicatorWidth);
    }
    
    
    if (style == JMOScrollIndicatorTypeClassic) {
        UIView *viewScrollIndicator = [[UIView alloc] initWithFrame:frame];
        viewScrollIndicator.alpha = 0.0f;
        viewScrollIndicator.layer.cornerRadius = width/2.0f;
        
        /*
         viewScrollIndicator.layer.borderWidth = 1.0f;
         viewScrollIndicator.layer.borderColor = indicatorColor.CGColor;
         */
        
        [viewScrollIndicator setBackgroundColor:[indicatorColor colorWithAlphaComponent:0.75]];
        [self setViewHForVerticalScrollIndicator:viewScrollIndicator];
        [self addSubview:viewScrollIndicator];
    }
    else if (style == JMOScrollIndicatorTypePageControl) {
        UIPageControl *pageCOntrol = [[UIPageControl alloc] initWithFrame:frame];
        [pageCOntrol setNumberOfPages:JMOScrollIndicatorPageControlNumberOfPages];
        [pageCOntrol setCurrentPage:0];
        pageCOntrol.backgroundColor = [UIColor clearColor];
        pageCOntrol.alpha = 0.0f;
        pageCOntrol.transform = CGAffineTransformMakeRotation(M_PI/2);
        if ([pageCOntrol respondsToSelector:@selector(pageIndicatorTintColor)]) {
            pageCOntrol.pageIndicatorTintColor = [indicatorColor colorWithAlphaComponent:0.15];
            pageCOntrol.currentPageIndicatorTintColor = indicatorColor;
        }
        
        [self setViewHForVerticalScrollIndicator:pageCOntrol];
        [self addSubview:pageCOntrol];
    }
}

-(void) enableCustomHorizontalScrollIndicator:(JMOScrollIndicatorPosition)hPos withColor:(UIColor *)indicatorColor withIndicatorStyle:(JMOScrollIndicatorType)style
{
    self.showsHorizontalScrollIndicator = NO;
    [self setHorizontalIndicatorPosition:hPos];
    [self setScrollIndicatorType:style];

    CGRect frame = CGRectZero;
    CGFloat height = 0.0f;
    if (style == JMOScrollIndicatorTypeClassic) {
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
    
    if (style == JMOScrollIndicatorTypeClassic) {
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

-(void) enableCustomScrollIndicatorsWithScrollIndicatorType:(JMOScrollIndicatorType)type positions:(JMOScrollIndicatorPosition)positions color:(UIColor *)color
{
    if (positions & JMOVerticalScrollIndicatorPositionRight) {
        [self enableCustomVerticalScrollIndicator:JMOVerticalScrollIndicatorPositionRight withColor:color withIndicatorStyle:type];
    }
    else if (positions & JMOVerticalScrollIndicatorPositionLeft) {
        [self enableCustomVerticalScrollIndicator:JMOVerticalScrollIndicatorPositionLeft withColor:color withIndicatorStyle:type];
    }
    
    if (positions & JMOHorizontalScrollIndicatorPositionBottom) {
        [self enableCustomHorizontalScrollIndicator:JMOHorizontalScrollIndicatorPositionBottom withColor:color withIndicatorStyle:type];
    }
    else if (positions & JMOHorizontalScrollIndicatorPositionTop) {
        [self enableCustomHorizontalScrollIndicator:JMOHorizontalScrollIndicatorPositionTop withColor:color withIndicatorStyle:type];
    }
    
    [self addKVOObservers];
}

- (void)refreshCustomScrollIndicatorsWithAlpha:(CGFloat)alpha
{
    [self refreshHorizontalScrollIndicatorWithAlpha:alpha];
    [self refreshVerticalScrollIndicatorWithAlpha:alpha];
}

- (void)refreshHorizontalScrollIndicatorWithAlpha:(CGFloat)alpha
{
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

- (void)refreshVerticalScrollIndicatorWithAlpha:(CGFloat)alpha
{
    UIView *viewScrollIndicator = [self getViewForVerticalScrollIndicator];
    JMOScrollIndicatorType style = [self getScrollIndicatorType];
    
    viewScrollIndicator.alpha = alpha;
    CGFloat pourcent = self.contentOffset.y / (self.contentSize.height - self.frame.size.height);
    CGRect rect =  viewScrollIndicator.frame;
    
    if (style == JMOScrollIndicatorTypePageControl) {
        if ([viewScrollIndicator isKindOfClass:[UIPageControl class]]) {
            UIPageControl *pageControl = (UIPageControl *)viewScrollIndicator;
            [pageControl setCurrentPage:pageControl.numberOfPages*pourcent];
        }
        
        rect.origin.y =  self.contentOffset.y + MAX(0.0f,(0.5 * self.frame.size.height) - viewScrollIndicator.frame.size.height/2);
    }
    else {
        rect.origin.y =  self.contentOffset.y + MAX(0.0f,(pourcent * self.frame.size.height) - viewScrollIndicator.frame.size.height);
    }
    
    viewScrollIndicator.frame = rect;
}

- (void)refreshCustomScrollIndicators
{
    [self refreshCustomScrollIndicatorsWithAlpha:1.0f];
}


-(void)disableCustomScrollIndicator
{
    @try {
        [self removeKVOObservers];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

#pragma mark - KVO

- (void)addKVOObservers
{
    [self addObserver:self forKeyPath:@"contentSize" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:NULL];
    [self addObserver:self forKeyPath:@"contentOffset" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:NULL];
}

- (void)removeKVOObservers
{
    [self removeObserver:self forKeyPath:@"contentSize"];
    [self removeObserver:self forKeyPath:@"contentOffset"];
}

- (void) observeValueForKeyPath: (NSString *) keyPath ofObject: (id) object change: (NSDictionary *) change context: (void *) context
{
    if (self.contentSize.width > 0.0f) {
        [self refreshCustomScrollIndicatorsWithAlpha:1.0f];
        
        /*
        UIView *viewScrollIndicator = [self getViewForHorizontalScrollIndicator];
        CGRect rect =  self.frame;
        CGFloat pourcent = self.contentOffset.x / self.contentSize.width;
        viewScrollIndicator.hidden = self.contentSize.width < self.frame.size.width;
        rect.size.width = self.frame.size.width * (self.frame.size.width / self.contentSize.width);
        rect.origin.x = pourcent * self.frame.size.width;
        viewScrollIndicator.frame = rect;
         */
    }
}


@end

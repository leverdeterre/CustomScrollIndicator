//
//  UIScrollView+ScrollIndicator.h
//  CustomScrollViewIndicator
//
//  Created by Jerome Morissard on 10/25/13.
//  Copyright (c) 2013 Jerome Morissard. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
  JMOVerticalScrollIndicatorPositionRight = 0, //Default
  JMOVerticalScrollIndicatorPositionLeft
} JMOVerticalScrollIndicatorPosition;

typedef enum {
    JMOHorizontalScrollIndicatorPositionBottom = 0, //Default
    JMOHorizontalScrollIndicatorPositionTop
} JMOHorizontalScrollIndicatorPosition;

@interface UIScrollView (ScrollIndicator)

-(void) enableCustomHorizontalScroll;
-(void) enableCustomHorizontalWithScrollVerticalIndicator:(JMOVerticalScrollIndicatorPosition)vPos withHorizontalIndicator:(JMOHorizontalScrollIndicatorPosition)hPos withColor:(UIColor *)indicatorColor;

-(void) refreshCustomScrollIndicator;
-(void) refreshCustomScrollIndicatorWithAlpha:(CGFloat)alpha;

@end

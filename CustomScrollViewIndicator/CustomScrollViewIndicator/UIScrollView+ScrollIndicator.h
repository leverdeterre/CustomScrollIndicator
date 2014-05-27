//
//  UIScrollView+ScrollIndicator.h
//  CustomScrollViewIndicator
//
//  Created by Jerome Morissard on 10/25/13.
//  Copyright (c) 2013 Jerome Morissard. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, JMOScrollIndicatorPosition) {
    JMOVerticalScrollIndicatorPositionRight = 1 << 0, //Default for vertical
    JMOVerticalScrollIndicatorPositionLeft = 1 << 1,
    JMOHorizontalScrollIndicatorPositionBottom = 1 << 2, //Default for horizontal
    JMOHorizontalScrollIndicatorPositionTop = 1 << 3
};

typedef NS_ENUM(NSUInteger, JMOScrollIndicatorType) {
    JMOScrollIndicatorTypeClassic = 0, //Default
    JMOScrollIndicatorTypePageControl
};

@interface UIScrollView (ScrollIndicator)

-(void)enableCustomScrollIndicatorsWithScrollIndicatorType:(JMOScrollIndicatorType)type positions:(JMOScrollIndicatorPosition)positions color:(UIColor *)color;
-(void)disableCustomScrollIndicator;

-(void)refreshCustomScrollIndicators;
-(void)refreshCustomScrollIndicatorsWithAlpha:(CGFloat)alpha;

@end

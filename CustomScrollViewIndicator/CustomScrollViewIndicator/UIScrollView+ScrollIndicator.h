//
//  UIScrollView+ScrollIndicator.h
//  CustomScrollViewIndicator
//
//  Created by Jerome Morissard on 10/25/13.
//  Copyright (c) 2013 Jerome Morissard. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
  JMOVerticalScrollIndicatorPositionRight = 1 << 0, //Default for vertical
  JMOVerticalScrollIndicatorPositionLeft = 1 << 1,
  JMOHorizontalScrollIndicatorPositionBottom = 1 << 2, //Default for horizontal
  JMOHorizontalScrollIndicatorPositionTop = 1 << 3,
} JMOScrollIndicatorPosition;


typedef enum {
    JMOScrollIndicatorTypeClassic = 0, //Default
    JMOScrollIndicatorTypePageControl
} JMOScrollIndicatorType;

@interface UIScrollView (ScrollIndicator)

-(void)enableCustomScrollIndicatorsWithScrollIndicatorType:(JMOScrollIndicatorType)type positions:(JMOScrollIndicatorPosition)positions color:(UIColor *)color;
-(void)disableCustomScrollIndicator;

-(void)refreshCustomScrollIndicators;
-(void)refreshCustomScrollIndicatorsWithAlpha:(CGFloat)alpha;

@end

//
//  JMOViewController.m
//  CustomScrollViewIndicator
//
//  Created by Jerome Morissard on 10/25/13.
//  Copyright (c) 2013 Jerome Morissard. All rights reserved.
//

#import "JMOViewController.h"
#import "UIScrollView+ScrollIndicator.h"

@interface JMOViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView1;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView2;

@end

@implementation JMOViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.scrollView1.delegate = self;
    [self.scrollView1 setContentSize:CGSizeMake(self.scrollView1.frame.size.width*3, self.scrollView1.frame.size.height)];
    [self.scrollView1 setScrollEnabled:YES];
    [self.scrollView1 enableCustomScrollIndicatorsWithScrollIndicatorType:JMOScrollIndicatorTypePageControl positions:JMOHorizontalScrollIndicatorPositionBottom color:[UIColor redColor]];
    
    self.scrollView2.delegate = self;
    [self.scrollView2 setContentSize:CGSizeMake(self.scrollView2.frame.size.width, self.scrollView2.frame.size.height*3)];
    [self.scrollView2 setScrollEnabled:YES];
    [self.scrollView2 enableCustomScrollIndicatorsWithScrollIndicatorType:JMOScrollIndicatorTypeClassic positions:JMOVerticalScrollIndicatorPositionLeft color:[UIColor blueColor]];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:0.25 animations:^{
        [scrollView refreshCustomScrollIndicatorsWithAlpha:0.0];
    }];
}

- (void)dealloc
{
    [self.scrollView1 disableCustomScrollIndicator];
    [self.scrollView2 disableCustomScrollIndicator];
}

@end

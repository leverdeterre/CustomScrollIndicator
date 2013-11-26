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
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView3;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView4;

@end

@implementation JMOViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)viewWillAppear:(BOOL)animated
{
    self.scrollView1.delegate = self;
    [self.scrollView1 setContentSize:CGSizeMake(self.scrollView1.frame.size.width*3, self.scrollView1.frame.size.height)];
    [self.scrollView1 setScrollEnabled:YES];
    [self.scrollView1 enableCustomScrollIndicatorsWithScrollIndicatorType:JMOScrollIndicatorTypePageControl positions:JMOHorizontalScrollIndicatorPositionBottom color:[UIColor redColor]];
    
    self.scrollView2.delegate = self;
    [self.scrollView2 setContentSize:CGSizeMake(self.scrollView2.frame.size.width, self.scrollView2.frame.size.height*3)];
    [self.scrollView2 setScrollEnabled:YES];
    [self.scrollView2 enableCustomScrollIndicatorsWithScrollIndicatorType:JMOScrollIndicatorTypePageControl positions:JMOVerticalScrollIndicatorPositionLeft color:[UIColor blueColor]];
    
    self.scrollView3.delegate = self;
    [self.scrollView3 setContentSize:CGSizeMake(self.scrollView3.frame.size.width, self.scrollView3.frame.size.height*3)];
    [self.scrollView3 setScrollEnabled:YES];
    [self.scrollView3 enableCustomScrollIndicatorsWithScrollIndicatorType:JMOScrollIndicatorTypeClassic positions:JMOVerticalScrollIndicatorPositionRight color:[UIColor purpleColor]];
    
    self.scrollView4.delegate = self;
    [self.scrollView4 setContentSize:CGSizeMake(self.scrollView4.frame.size.width*3, self.scrollView4.frame.size.height)];
    [self.scrollView4 setScrollEnabled:YES];
    [self.scrollView4 enableCustomScrollIndicatorsWithScrollIndicatorType:JMOScrollIndicatorTypeClassic positions:JMOHorizontalScrollIndicatorPositionTop color:[UIColor orangeColor]];
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
    [self.scrollView3 disableCustomScrollIndicator];
    [self.scrollView4 disableCustomScrollIndicator];
}

@end

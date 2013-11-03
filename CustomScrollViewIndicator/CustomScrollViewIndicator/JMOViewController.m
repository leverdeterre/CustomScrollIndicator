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
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation JMOViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)viewWillAppear:(BOOL)animated
{
    self.scrollView.delegate = self;
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width*3, self.view.frame.size.height)];
    [self.scrollView setScrollEnabled:YES];
    [self.scrollView enableCustomHorizontalWithScrollVerticalIndicator:JMOVerticalScrollIndicatorPositionRight withHorizontalIndicator:JMOHorizontalScrollIndicatorPositionBottom withColor:[[UIColor blackColor] colorWithAlphaComponent:0.8] withIndicatorStyle:JMOScrollIndicatorTypePageControl];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width*3, self.view.frame.size.height)];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:0.25 animations:^{
        [self.scrollView refreshCustomScrollIndicatorWithAlpha:0.0];
    }];
}

@end

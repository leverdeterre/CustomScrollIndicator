An iOS customizable ScrollIndicator

- allows to customize UIScrollView scroll indicators, 
- Only one category

![Image](demo.png)


### Enum to configure indicator positions

```objective-c
typedef enum {
    JMOHorizontalScrollIndicatorPositionBottom = 0, //Default
    JMOHorizontalScrollIndicatorPositionTop
} JMOHorizontalScrollIndicatorPosition;

```


### Enum to configure indicator type

```objective-c
typedef enum {
    JMOScrollIndicatorTypeDefault = 0, //Default
    JMOScrollIndicatorTypePageControl
} JMOScrollIndicatorType;

```

### Usage ... very simple, just enable the customization (with default parameters)
```objective-c
[scrollView enableCustomHorizontalScroll];
```

###  With options 
```objective-c
[scrollView 
        enableCustomHorizontalWithScrollVerticalIndicator:JMOVerticalScrollIndicatorPositionRight 
                              withHorizontalIndicator:JMOHorizontalScrollIndicatorPositionBottom 
                              withColor:[UIColor grayColor]
                              withIndicatorStyle:JMOScrollIndicatorTypePageControl];
    
```

###  Refresh ... call methods in your scrollViewDelegate 

```objective-c
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [scrollView refreshCustomScrollIndicator];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:0.25 animations:^{
        [scrollView refreshCustomScrollIndicatorWithAlpha:0.0];
    }];
}
    
```



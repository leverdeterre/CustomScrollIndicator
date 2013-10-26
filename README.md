An iOS customizable ScrollIndicator

- allows to customize UIScrollView scroll indicators, 
- Only one category

### Enum to configure indicator positions

```objective-c
typedef enum {
    JMOHorizontalScrollIndicatorPositionBottom = 0, //Default
    JMOHorizontalScrollIndicatorPositionTop
} JMOHorizontalScrollIndicatorPosition;

```
### Usage ... very simple, just enable the customization (with default parameters)
```objective-c
[self.scrollView enableCustomHorizontalScroll];
```

###  With options 
```objective-c
[self.scrollView enableCustomHorizontalWithScrollVerticalIndicator:JMOVerticalScrollIndicatorPositionRight 
                                           withHorizontalIndicator:JMOHorizontalScrollIndicatorPositionBottom 
                                           withColor:[UIColor grayColor]];
    
```

###  Refresh ... call methods in your scrollViewDelegate 

```objective-c
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.scrollView refreshCustomScrollIndicator];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:0.25 animations:^{
        [self.scrollView refreshCustomScrollIndicatorWithAlpha:0.0];
    }];
}
    
```



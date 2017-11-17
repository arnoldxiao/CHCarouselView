//
//  CHCarouselView.m
//  CHCarouselView
//
//  Created by arnoldxiao on 2017/11/17.
//  Copyright © 2017年 arnoldxiao. All rights reserved.
//

#import "CHCarouselView.h"

@interface CHCarouselView () <UIScrollViewDelegate> {
    NSInteger _currentPage;
    CGFloat _beginOffsetX;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation CHCarouselView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    [self addSubview:self.scrollView];
    NSLog(@"%@", NSStringFromCGSize(self.scrollView.bounds.size));
}

- (void)setImages:(NSArray<UIImage *> *)images {
    _images = [images copy];
    
    self.scrollView.contentSize = CGSizeMake(self.images.count * CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
    
    __weak typeof(self) ws = self;
    [self.images enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        __strong typeof(self) self = ws;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:obj];
        imageView.frame = CGRectMake(idx * CGRectGetWidth(self.scrollView.frame), 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        [self.scrollView addSubview:imageView];
    }];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%@-%f", NSStringFromSelector(_cmd), scrollView.contentOffset.x);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"%@-%f", NSStringFromSelector(_cmd), scrollView.contentOffset.x);
    _beginOffsetX = scrollView.contentOffset.x;
    _currentPage = _beginOffsetX / CGRectGetWidth(self.scrollView.frame);
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    NSLog(@"%@-%f", NSStringFromSelector(_cmd), scrollView.contentOffset.x);
    NSLog(@"%@", NSStringFromCGPoint((*targetContentOffset)));
    
    CGFloat currentOffsetX = scrollView.contentOffset.x;
    
//    if (currentOffsetX - _beginOffsetX > kFlexibleWidth(50)) {
//        //  往右
//        if (_currentPage != self.images.count - 1) {
//            _currentPage++;
//        }
//    } else if (currentOffsetX - _beginOffsetX < -kFlexibleWidth(50)) {
//        //  往左
//        if (_currentPage != 0) {
//            _currentPage--;
//        }
//    }
    
//    CGPoint point = CGPointMake(_currentPage * CGRectGetWidth(self.scrollView.frame), 0);
    
    CGFloat centerX = fabs(currentOffsetX) + CGRectGetWidth(self.scrollView.frame) / 2;
    NSInteger page = centerX / CGRectGetWidth(self.scrollView.frame);
    CGFloat offsetX = page * -CGRectGetWidth(self.scrollView.frame);
    
//    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    *targetContentOffset = CGPointMake(offsetX, 0);
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.bounces = YES;
//        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.backgroundColor = UIColor.blueColor;
    }
    return _scrollView;
}

@end

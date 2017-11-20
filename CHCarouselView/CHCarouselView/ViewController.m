//
//  ViewController.m
//  CHCarouselView
//
//  Created by arnoldxiao on 2017/11/17.
//  Copyright © 2017年 arnoldxiao. All rights reserved.
//

#import "ViewController.h"
#import "CHCarouselView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = UIColor.lightTextColor;
    
    NSMutableArray<UIImage *> *images = [NSMutableArray array];
    
    for (int i = 0; i < 7; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"image%02d.jpg", i+1]];
        [images addObject:image];
    }
    
    CGFloat width = kFullScreenWidth - 2 * kFlexibleWidth(20);
    CGFloat height = (800.0f * width) / 1280.0f;
    
    CHCarouselView *carouselView = [[CHCarouselView alloc] initWithFrame:CGRectMake(kFlexibleWidth(20), 100, width, height)];
    carouselView.images = images;
    [self.view addSubview:carouselView];
}


@end

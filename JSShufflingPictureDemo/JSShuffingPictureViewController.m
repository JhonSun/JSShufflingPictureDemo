//
//  JSShuffingPictureViewController.m
//  JSShufflingPictureDemo
//
//  Created by jhon.sun on 15/11/17.
//  Copyright © 2015年 jhon.sun. All rights reserved.
//

#import "JSShuffingPictureViewController.h"
#import "JSShuffingPictureView.h"

@interface JSShuffingPictureViewController ()

@property (nonatomic, strong) JSShuffingPictureView *shuffingPictureView;

@end

@implementation JSShuffingPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.shuffingPictureView];
}

- (void)viewWillLayoutSubviews {
    self.shuffingPictureView.frame = self.view.bounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - get
- (JSShuffingPictureView *)shuffingPictureView {
    if (!_shuffingPictureView) {
        _shuffingPictureView = [[[NSBundle mainBundle] loadNibNamed:@"JSShuffingPictureView" owner:self options:nil] firstObject];
        _shuffingPictureView.isZoom = YES;
        _shuffingPictureView.isLoop = NO;
//        _shuffingPictureView.autoScrollTime = 3;
        _shuffingPictureView.pageControlCurrentColor = [UIColor redColor];
        _shuffingPictureView.pageControlThumColor = [UIColor grayColor];
        _shuffingPictureView.imageArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"banner1"], [UIImage imageNamed:@"banner2"], [UIImage imageNamed:@"banner3"], nil];
    }
    return _shuffingPictureView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

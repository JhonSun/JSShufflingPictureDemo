//
//  ViewController.m
//  JSShufflingPictureDemo
//
//  Created by jhon.sun on 15/11/12.
//  Copyright © 2015年 jhon.sun. All rights reserved.
//

#import "ViewController.h"
#import "JSImageViewCollectionViewCell.h"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSUInteger index;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageControl.numberOfPages = self.imageArray.count;
    [self.timer fire];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - get
- (NSArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"banner1"], [UIImage imageNamed:@"banner2"], [UIImage imageNamed:@"banner3"], nil];
    }
    return _imageArray;
}

- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(jumpNext) userInfo:nil repeats:YES];
    }
    return _timer;
}

#pragma mark - private
- (void)jumpNext {
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.index++ inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    if (self.index == [self.collectionView numberOfItemsInSection:0]) {
        self.index = 0;
    }
}

- (void)chagePageControlCurrentWithScrollView:(UIScrollView *)scrollView {
    CGFloat collectionViewWidth = self.collectionView.bounds.size.width;
    NSUInteger page = (scrollView.contentOffset.x - collectionViewWidth / 2) / collectionViewWidth + 1;
    page %= self.imageArray.count;
    self.pageControl.currentPage = page;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageArray.count * 10000;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JSImageViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:imageViewCollectionViewCellIdentifier forIndexPath:indexPath];
    NSUInteger page = indexPath.item % self.imageArray.count;
    cell.image = [self.imageArray objectAtIndex:page];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
}

#pragma mark - UIScrollViewDelegate
//开始拖动时，停止定时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer invalidate];
    self.timer = nil;
}

//停止拖动时判断页数
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self chagePageControlCurrentWithScrollView:scrollView];
}


//自动滚动判断页数
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self chagePageControlCurrentWithScrollView:scrollView];
}

//结束拖动时，启动定时器
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self timer];
}

@end

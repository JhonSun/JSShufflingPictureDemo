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

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) BOOL isFirst;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageControl.numberOfPages = self.imageArray.count - 2;
    self.isFirst = YES;
    [self addTimer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - get
- (NSArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"banner3"], [UIImage imageNamed:@"banner1"], [UIImage imageNamed:@"banner2"], [UIImage imageNamed:@"banner3"], [UIImage imageNamed:@"banner1"], nil];
    }
    return _imageArray;
}

#pragma mark - private
- (void)addTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(jumpNext) userInfo:nil repeats:YES];
}

- (void)removeTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)jumpNext {
    self.index++;
    if (self.index == [self.collectionView numberOfItemsInSection:0]) {
        self.index = 0;
    }
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.index inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
}

- (void)chagePageControlCurrentWithScrollView:(UIScrollView *)scrollView {
    CGFloat collectionViewWidth = self.collectionView.bounds.size.width;
    self.index = (scrollView.contentOffset.x - collectionViewWidth / 2) / collectionViewWidth + 1;
    
    if (self.index == self.imageArray.count - 1) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        self.index = 0;
    } else if (self.index == 0) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.imageArray.count - 2 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        self.index = self.imageArray.count - 2;
    } else {
        self.index -= 1;
    }
    self.pageControl.currentPage = self.index;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JSImageViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:imageViewCollectionViewCellIdentifier forIndexPath:indexPath];
    cell.image = [self.imageArray objectAtIndex:indexPath.item];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_isFirst) {
        [collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        _isFirst = NO;
    }
}

//开始拖动时，停止定时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self removeTimer];
}

//停止拖动时，启动定时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self addTimer];
}

//结束减速时，计算位置
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self chagePageControlCurrentWithScrollView:scrollView];
}

//自动滚动判断页数
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self chagePageControlCurrentWithScrollView:scrollView];
}
@end

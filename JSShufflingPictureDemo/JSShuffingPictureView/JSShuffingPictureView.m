//
//  JSShuffingPictureCollectionView.m
//  JSShufflingPictureDemo
//
//  Created by jhon.sun on 15/11/17.
//  Copyright © 2015年 jhon.sun. All rights reserved.
//

#import "JSShuffingPictureView.h"
#import "JSShuffingPictureCollectionViewCell.h"

@interface JSShuffingPictureView ()<UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation JSShuffingPictureView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.collectionView registerNib:[UINib nibWithNibName:@"JSShuffingPictureCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:shuffingPictureCollectionViewCellIdentifier];
}

- (void)layoutSubviews {
    [self.collectionView reloadData];
    if (self.imageArray.count > 1) {
        [self.collectionView setContentOffset:CGPointMake(self.bounds.size.width, 0) animated:NO];
    }
}

#pragma mark - set
- (void)setImageArray:(NSArray *)imageArray {
    _imageArray = imageArray;
    self.pageControl.numberOfPages = _imageArray.count;
    if (imageArray.count > 1) {
        NSMutableArray *tempImageArray = [NSMutableArray arrayWithArray:imageArray];
        [tempImageArray insertObject:[imageArray lastObject] atIndex:0];
        [tempImageArray addObject:[imageArray firstObject]];
        _imageArray = tempImageArray;
    }
}

- (void)setAutoScrollTime:(NSInteger)autoScrollTime {
    _autoScrollTime = autoScrollTime;
    [self addTimer];
}

- (void)setPageControlCurrentColor:(UIColor *)pageControlCurrentColor {
    _pageControlCurrentColor = pageControlCurrentColor;
    self.pageControl.currentPageIndicatorTintColor = _pageControlCurrentColor;
}

- (void)setPageControlThumColor:(UIColor *)pageControlThumColor {
    _pageControlThumColor = pageControlThumColor;
    self.pageControl.pageIndicatorTintColor = _pageControlThumColor;
}

#pragma mark - private
- (void)addTimer {
    if (self.autoScrollTime != 0) {
      self.timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTime target:self selector:@selector(jumpNext) userInfo:nil repeats:YES];
    }
}

- (void)removeTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)jumpNext {
    if (self.imageArray.count > 1) {
        NSUInteger page = self.pageControl.currentPage + 2;
        if (page >= [self.collectionView numberOfItemsInSection:0]) {
            page = 1;
        }
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:page inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    }
}

- (void)changePageControlCurrentPageWithScrollView:(UIScrollView *)scrollView {
    CGFloat collectionViewWidth = self.collectionView.bounds.size.width;
    NSUInteger page = (scrollView.contentOffset.x - collectionViewWidth / 2) / collectionViewWidth + 1;
    
    if (page == self.imageArray.count - 1) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        page = 0;
    } else if (page == 0) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.imageArray.count - 2 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        page = self.imageArray.count - 2;
    } else {
        page -= 1;
    }
    self.pageControl.currentPage = page;
}

#pragma mark - UICollectionViewDataSource 
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JSShuffingPictureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:shuffingPictureCollectionViewCellIdentifier forIndexPath:indexPath];
    cell.image = [self.imageArray objectAtIndex:indexPath.item];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.bounds.size;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger selectIndex;
    if (self.imageArray.count > 1) {
        selectIndex = indexPath.item - 1;
    } else {
        selectIndex = indexPath.item;
    }
    if (self.selectItemEvent) self.selectItemEvent(selectIndex);
}

#pragma mark - UIScrollViewDelegate
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
    [self changePageControlCurrentPageWithScrollView:scrollView];
}

//自动滚动判断页数
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self changePageControlCurrentPageWithScrollView:scrollView];
}

@end

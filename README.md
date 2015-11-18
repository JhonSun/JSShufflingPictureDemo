# JSShufflingPictureDemo
使用系统自带的collectionView实现图片轮播，使用起来很简单，只要在文件中
#import "JSShuffingPictureView.h"就可以了。
使用示例：
#pragma mark - get
- (JSShuffingPictureView *)shuffingPictureView {
    if (!_shuffingPictureView) {
        _shuffingPictureView = [[[NSBundle mainBundle] loadNibNamed:@"JSShuffingPictureView" owner:self options:nil] firstObject];
        _shuffingPictureView.imageArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"banner1"], [UIImage imageNamed:@"banner2"], [UIImage imageNamed:@"banner3"], nil];
        //设置自动轮播的时间，如果不设置，则不自动轮播
        _shuffingPictureView.autoScrollTime = 3;
        _shuffingPictureView.pageControlCurrentColor = [UIColor redColor];
        _shuffingPictureView.pageControlThumColor = [UIColor grayColor];
    }
    return _shuffingPictureView;
}

- (void)viewWillLayoutSubviews {
    self.shuffingPictureView.frame = self.view.bounds;
}

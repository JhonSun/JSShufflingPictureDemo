# JSShufflingPictureDemo
Demo简介：
使用collectionView实现了图片轮播（无限循环滚动）

使用示例：
<pre>
<code>
- (JSShuffingPictureView *)shuffingPictureView {
	if (!_shuffingPictureView) {
        _shuffingPictureView = [[[NSBundle mainBundle] loadNibNamed:@"JSShuffingPictureView" owner:self options:nil] firstObject];
        _shuffingPictureView.imageArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"banner1"], [UIImage imageNamed:@"banner2"], [UIImage imageNamed:@"banner3"], nil];
        //设置自动轮播的时间间隔，如不设置，则不会自动轮播
        _shuffingPictureView.autoScrollTime = 3;
        _shuffingPictureView.pageControlCurrentColor = [UIColor redColor];
        _shuffingPictureView.pageControlThumColor = [UIColor grayColor];
    }
    return _shuffingPictureView;
  }

- (void)viewWillLayoutSubviews {
    self.shuffingPictureView.frame = self.view.bounds;
}
</code>
</pre>

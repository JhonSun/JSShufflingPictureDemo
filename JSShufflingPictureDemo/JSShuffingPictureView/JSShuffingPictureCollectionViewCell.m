//
//  JSShuffingPictureCollectionViewCell.m
//  JSShufflingPictureDemo
//
//  Created by jhon.sun on 15/11/17.
//  Copyright © 2015年 jhon.sun. All rights reserved.
//

#import "JSShuffingPictureCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface JSShuffingPictureCollectionViewCell ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation JSShuffingPictureCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.scrollView.minimumZoomScale = 1.0;
    self.scrollView.maximumZoomScale = 3.0;
}

#pragma mark - set
- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageView.image = image;
}

- (void)setImageUrlString:(NSString *)imageUrlString {
    _imageUrlString = imageUrlString;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_imageUrlString] placeholderImage:self.defaultImage];
}

- (void)setImageObject:(id)imageObject {
    _imageObject = imageObject;
    if ([_imageObject isKindOfClass:[UIImage class]]) {
        UIImage *image = (UIImage *)_imageObject;
        self.imageView.image = image;
    } else if ([_imageObject isKindOfClass:[NSString class]]) {
        NSString *imageUrlString = (NSString *)_imageObject;
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrlString] placeholderImage:self.defaultImage];
    }
}

- (void)setIsZoom:(BOOL)isZoom {
    _isZoom = isZoom;
    if (_isZoom) {
        self.scrollView.delegate = self;
    } else {
        self.scrollView.delegate = nil;
    }
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

@end

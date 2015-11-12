//
//  JSImageViewCollectionViewCell.m
//  JSShufflingPictureDemo
//
//  Created by jhon.sun on 15/11/12.
//  Copyright © 2015年 jhon.sun. All rights reserved.
//

#import "JSImageViewCollectionViewCell.h"

@interface JSImageViewCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation JSImageViewCollectionViewCell

- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageView.image = _image;
}

@end

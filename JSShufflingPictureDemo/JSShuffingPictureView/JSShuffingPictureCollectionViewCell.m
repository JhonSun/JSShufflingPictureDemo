//
//  JSShuffingPictureCollectionViewCell.m
//  JSShufflingPictureDemo
//
//  Created by jhon.sun on 15/11/17.
//  Copyright © 2015年 jhon.sun. All rights reserved.
//

#import "JSShuffingPictureCollectionViewCell.h"

@interface JSShuffingPictureCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation JSShuffingPictureCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

#pragma mark - set
- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageView.image = image;
}

@end

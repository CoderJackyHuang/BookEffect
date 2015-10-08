//
//  HYBBookCell.m
//  CollectionViewBookEffect
//
//  Created by huangyibiao on 15/10/8.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

#import "HYBBookCell.h"

@interface HYBBookCell () {
  BOOL _isRightPage;
}

@end

@implementation HYBBookCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.bgView = [[UIView alloc] initWithFrame:self.contentView.bounds];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.bgView];
    
    self.imageView = [[UIImageView alloc] initWithFrame:self.bgView.bounds];
    [self.bgView addSubview:self.imageView];
    
    self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    self.textLabel.center = CGPointMake(self.bgView.bounds.size.width / 2 + 20, self.bgView.bounds.size.height - 20);
    [self.bgView addSubview:self.textLabel];
    
    // open antialiasing
    self.layer.allowsEdgeAntialiasing = YES;
  }
  
  return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
  [super applyLayoutAttributes:layoutAttributes];
  
  // Judge odd or even of cell.
  if (layoutAttributes.indexPath.item % 2 == 0) {
    // 如果偶数,则中心线在左边,页面右边有圆角,左边没有圆角
    // if it's even, the center line will be on the left, right page has corner and
    // left page has no corner.
    _isRightPage = YES;
    self.layer.anchorPoint = CGPointMake(0, 0.5);
  } else {
    _isRightPage = NO;
    self.layer.anchorPoint = CGPointMake(1, 0.5);
  }
  
  // corner
  UIRectCorner corner = _isRightPage ? UIRectCornerTopRight | UIRectCornerBottomRight
  : UIRectCornerTopLeft | UIRectCornerBottomLeft;
  UIBezierPath *bezier = [UIBezierPath bezierPathWithRoundedRect:self.bgView.bounds
                                               byRoundingCorners:corner
                                                     cornerRadii:CGSizeMake(16, 16)];
  CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
  maskLayer.frame = self.bgView.bounds;
  maskLayer.path = bezier.CGPath;
  self.bgView.layer.mask = maskLayer;
  self.bgView.clipsToBounds = YES;
}

@end

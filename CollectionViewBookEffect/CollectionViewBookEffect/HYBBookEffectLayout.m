//
//  HYBBookEffectLayout.m
//  CollectionViewBookEffect
//
//  Created by huangyibiao on 15/10/8.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

#import "HYBBookEffectLayout.h"

static CGFloat s_numberOfPages = 0; //定义总的cell个数

@interface HYBBookEffectLayout ()

@property (nonatomic, assign) CGFloat pageWidth;
@property (nonatomic, assign) CGFloat pageHeight;

@end

@implementation HYBBookEffectLayout

#pragma mark - Life cycle
- (void)prepareLayout {
  [super prepareLayout];
  
  // Make scroll faster when scroll finished.
  self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
  
  // Record how many pages
  s_numberOfPages = [self.collectionView numberOfItemsInSection:0];
  
  // We must make it enable.
  self.collectionView.pagingEnabled = YES;
}

// We should make it update in real time.
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
  return YES;
}

// We must override it method, so that we could specify how many pages in scrollable content.
// Here, we only show two pages in scrollable content.
- (CGSize)collectionViewContentSize {
  CGFloat width = s_numberOfPages / 2 - 1;
  return CGSizeMake(width * self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
}

// Important!
// If we want to make cell have special effect, we should take a lot of time to add animation here for each
// cell.
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
  // First, we should get attributes
  UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
  
  if (self.pageWidthBlock) {
    self.pageWidth = self.pageWidthBlock();
  } else {
    self.pageWidth = [UIScreen mainScreen].bounds.size.width;
  }
  
  if (self.pageHeightBlock) {
    self.pageHeight = self.pageHeightBlock();
  } else {
    self.pageHeight = [UIScreen mainScreen].bounds.size.height;
  }
  
  // Set frame for cell
  CGFloat x = self.collectionView.bounds.size.width / 2 - self.pageWidth / 2
  + self.collectionView.contentOffset.x;
  CGFloat y = (self.collectionViewContentSize.height - self.pageHeight) / 2;
  CGRect frame = CGRectMake(x, y, self.pageWidth, self.pageHeight);
  attr.frame = frame;
  
  // Set page ratio
  // It will be 0, 0, 1, 1, 2, 2, ...
  CGFloat page = (indexPath.item - indexPath.item % 2) * 0.5;
  CGFloat ratio = page - (self.collectionView.contentOffset.x / self.collectionView.bounds.size.width) - 0.5;
  if (ratio > 0.5) {
    ratio = 0.5 + 0.1 * (ratio - 0.5);// [0.5, 1.0)
  } else if (ratio < -0.5) {
    ratio = -0.5 + 0.1 * (ratio + 0.5);// (-1.0, -0.5]
  }
  
  if ((ratio > 0 && indexPath.item % 2 == 1) || (ratio < 0 && indexPath.item % 2 == 0)) {
    if (indexPath.row != 1) {
      return nil;
    }
  }
  
  // 计算旋转角度angle,设定3D旋转
  CGFloat newRatio = MIN(MAX(ratio, -1), 1);
  
  // 计算m34
  CATransform3D transform = CATransform3DIdentity;
  transform.m34 = 1.0 / (-2000);
  
  CGFloat angle = 0.0f;
  if (indexPath.item % 2 == 0) {
    // 中心线在左边
    angle = (1 - newRatio) * (-M_PI_2);
  } else if (indexPath.item % 2 == 1) {
    angle = (1 + newRatio) * (M_PI_2);
  }
  
  angle += (indexPath.row % 2) / 1000;
  transform = CATransform3DRotate(transform, angle, 0, 1, 0);
  
  attr.transform3D = transform;
  
  return attr;
}

// We should implement this method to return a valid cell array to take effect.
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
  NSMutableArray *array = [NSMutableArray new];
  
  for (NSUInteger i = 0; i < s_numberOfPages; ++i) {
    NSIndexPath *index = [NSIndexPath indexPathForItem:i inSection:0];
    
    UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:index];
    
    if (attr) {
      [array addObject:attr];
    }
  }
  
  return array;
}

@end

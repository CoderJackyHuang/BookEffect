//
//  HYBBookCollectionView.m
//  CollectionViewBookEffect
//
//  Created by huangyibiao on 15/10/8.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

#import "HYBBookCollectionView.h"
#import "HYBBookCell.h"

@interface HYBBookCollectionView () {
  NSArray *_array;
  NSArray *_arrayStr;
}

@end

@implementation HYBBookCollectionView

static NSString *const reuseIdentifier = @"cell";

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
  self = [super initWithFrame:frame collectionViewLayout:layout];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    self.dataSource = self;
    self.delegate =self;
    [self registerClass:[HYBBookCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.showsHorizontalScrollIndicator = NO;
    
    _array = @[@"",@"封面.jpg",@"白羊座1.jpg",@"金牛座2.jpg",@"双子座3.jpg",@"巨蟹座4.jpg",@"狮子座5.jpg",@"处女座6.jpg",@"天平座7.jpg",@"天蝎座8.jpg",@"射手座9.jpg",@"魔蝎座10.jpg",@"水瓶座11.jpg",@"双鱼座12.jpg",@"封底.jpg", @""];
    _arrayStr = @[@"",@"", @"白羊座",@"金牛座",@"双子座",@"巨蟹座",@"狮子座",@"处女座",@"天平座",@"天蝎座",@"射手座",@"魔蝎座",@"水瓶座",@"双鱼座", @"", @""];
  }
  
  return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return _array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  HYBBookCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                forIndexPath:indexPath];
  cell.imageView.image = [UIImage imageNamed:_array[indexPath.row]];
  cell.textLabel.text = [NSString stringWithFormat:@"%@", _arrayStr[indexPath.row]];
  cell.textLabel.font = [UIFont systemFontOfSize:12];
  cell.textLabel.textColor = [UIColor colorWithRed:148 / 255.0f green:0.0f blue:211 / 255.0f alpha:1.0f];
  
  return cell;
}

@end

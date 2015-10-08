//
//  ViewController.m
//  CollectionViewBookEffect
//
//  Created by huangyibiao on 15/10/8.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

#import "ViewController.h"
#import "HYBBookEffectLayout.h"
#import "HYBBookCollectionView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  HYBBookEffectLayout *layout = [[HYBBookEffectLayout alloc] init];
  HYBBookEffectPageWidth pageWidth = ^() {
    return 200.0;
  };
  layout.pageWidthBlock = pageWidth;
  layout.pageHeightBlock = ^() {
    return 300.0;
  };
  
  HYBBookCollectionView *bookView = [[HYBBookCollectionView alloc] initWithFrame:CGRectMake(5, 100, [UIScreen mainScreen].bounds.size.width - 10, 500) collectionViewLayout:layout];
  [self.view addSubview:bookView];
  bookView.backgroundColor = [UIColor greenColor];
}

@end

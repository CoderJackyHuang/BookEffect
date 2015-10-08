//
//  HYBBookEffectLayout.h
//  CollectionViewBookEffect
//
//  Created by huangyibiao on 15/10/8.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef CGFloat (^HYBBookEffectPageWidth)();
typedef CGFloat (^HYBBookEffectPageHeight)();

@interface HYBBookEffectLayout : UICollectionViewLayout

// If not set, it's default value is [UIScreen main].bounds.size.width / 2
@property (nonatomic, assign) HYBBookEffectPageWidth pageWidthBlock;

// If not set, it's default value is [UIScreen main].bounds.size.height / 2 
@property (nonatomic, assign) HYBBookEffectPageHeight pageHeightBlock;

@end


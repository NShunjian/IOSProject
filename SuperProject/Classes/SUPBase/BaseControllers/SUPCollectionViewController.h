//
//  SUPCollectionViewController.h
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "SUPBaseViewController.h"
#import "SUPElementsFlowLayout.h"
#import "SUPVerticalFlowLayout.h"
#import "SUPHorizontalFlowLayout.h"


@class SUPCollectionViewController;
@protocol SUPCollectionViewControllerDataSource <NSObject>

@required
// 需要返回对应的布局
- (UICollectionViewLayout *)collectionViewController:(SUPCollectionViewController *)collectionViewController layoutForCollectionView:(UICollectionView *)collectionView;

@end

@interface SUPCollectionViewController : SUPBaseViewController <UICollectionViewDelegate, UICollectionViewDataSource, SUPCollectionViewControllerDataSource>

/** <#digest#> */
@property (weak, nonatomic) UICollectionView *collectionView;

@end

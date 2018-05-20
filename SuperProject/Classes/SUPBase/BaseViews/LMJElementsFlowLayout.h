//
//  LMJElementsFlowLayout.h
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import <UIKit/UIKit.h>


@class LMJElementsFlowLayout;


@protocol LMJElementsFlowLayoutDelegate <NSObject>

@required
/**
 *  要求实现
 *
 *  @param waterflowLayout 哪个布局需要代理返回大小
 *  @param  indexPath          对应的cell, 的indexPath, 但是indexPath.section == 0
 *
 *  @return 需要代理高度对应的cell的高度
 */
- (CGSize)waterflowLayout:(LMJElementsFlowLayout *)waterflowLayout collectionView:(UICollectionView *)collectionView sizeForItemAtIndexPath:(NSIndexPath *)indexPath;



@optional

/**
 *  列间距, 默认10
 */
- (CGFloat)waterflowLayout:(LMJElementsFlowLayout *)waterflowLayout collectionView:(UICollectionView *)collectionView columnsMarginForItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  行间距, 默认10
 */
- (CGFloat)waterflowLayout:(LMJElementsFlowLayout *)waterflowLayout collectionView:(UICollectionView *)collectionView linesMarginForItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  距离collectionView四周的间距, 默认{20, 10, 10, 10}
 */
- (UIEdgeInsets)waterflowLayout:(LMJElementsFlowLayout *)waterflowLayout edgeInsetsInCollectionView:(UICollectionView *)collectionView;


@end


@interface LMJElementsFlowLayout : UICollectionViewLayout

/** layout的代理 */
- (instancetype)initWithDelegate:(id<LMJElementsFlowLayoutDelegate>)delegate;

+ (instancetype)flowLayoutWithDelegate:(id<LMJElementsFlowLayoutDelegate>)delegate;


@end

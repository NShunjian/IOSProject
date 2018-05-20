//
//  LMJIntroductoryPagesView.m
//  SuperProject
//
//  Created by NShunJian on 2018/1/20.
//  Copyright © 2018年 superMan. All rights reserved.
//

#import "LMJIntroductoryPagesView.h"

@interface LMJIntroductoryPagesView ()<UIScrollViewDelegate>
/** <#digest#> */
@property (nonatomic, strong) NSArray<NSString *> *imagesArray;

@property(nonatomic,strong)UIPageControl *pageControl;

/** <#digest#> */
@property (weak, nonatomic) UIScrollView *scrollView;

@property (nonatomic, strong) UIButton *countBtn;
@end

@implementation LMJIntroductoryPagesView

+ (instancetype)pagesViewWithFrame:(CGRect)frame images:(NSArray<NSString *> *)images
{
    LMJIntroductoryPagesView *pagesView = [[self alloc] initWithFrame:frame];
    pagesView.imagesArray = images;
    return pagesView;
}



- (void)setupUIOnce
{
    self.backgroundColor = [UIColor clearColor];
    
    //添加手势
    UITapGestureRecognizer *singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTapFrom)];
    singleRecognizer.numberOfTapsRequired = 1;
    [self.scrollView addGestureRecognizer:singleRecognizer];
}

- (void)setImagesArray:(NSArray<NSString *> *)imagesArray {
    _imagesArray = imagesArray;
    [self loadPageView];
}

- (void)loadPageView
{
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.scrollView.contentSize = CGSizeMake((self.imagesArray.count + 1) * kScreenWidth, kScreenHeight);
    self.pageControl.numberOfPages = self.imagesArray.count;
    
    [self.imagesArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc]init];
        
        imageView.frame = CGRectMake(idx * kScreenWidth, 0, kScreenWidth, kScreenHeight);
        
        YYImage *image = [YYImage imageNamed:obj];
//        if (idx==self.imagesArray.count) {
//            指定添加元素 到最后一页 
//        }
//        [imageView setImage:image];
        [imageView setImage:image];
        
        [self.scrollView addSubview:imageView];
    }];
    // 2.跳过按钮
    CGFloat btnW = 60;
    CGFloat btnH = 30;
    _countBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - btnW - 24, btnH, btnW, btnH)];
    [_countBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [_countBtn setTitle:@"跳过" forState:UIControlStateNormal];
    _countBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_countBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _countBtn.backgroundColor = [UIColor colorWithRed:38 /255.0 green:38 /255.0 blue:38 /255.0 alpha:0.6];
    _countBtn.layer.cornerRadius = 4;
    
    [self addSubview:_countBtn];
    
}
// 移除引导页面
- (void)dismiss
{
    [UIView animateWithDuration:0.3f animations:^{
        
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
}

-(void)handleSingleTapFrom
{
    if (_pageControl.currentPage == self.imagesArray.count-1) {
        [self removeFromSuperview];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offSet = scrollView.contentOffset;
    NSInteger page = (offSet.x / (self.bounds.size.width) + 0.5);
    self.pageControl.currentPage = page;//计算当前的页码
    self.pageControl.hidden = (page > self.imagesArray.count - 1);
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x >= (_imagesArray.count) * kScreenWidth) {
        [self removeFromSuperview];
    }
}


- (UIScrollView *)scrollView
{
    if(!_scrollView)
    {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        [self addSubview:scrollView];
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.pagingEnabled = YES;//设置分页
        scrollView.bounces = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.delegate = self;
        _scrollView = scrollView;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl
{
    if(!_pageControl)
    {
        UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(kScreenWidth/2, kScreenHeight - 60, 0, 40)];
        pageControl.backgroundColor = [UIColor RandomColor];
        pageControl.pageIndicatorTintColor = [UIColor RandomColor];
        pageControl.currentPageIndicatorTintColor = [UIColor RandomColor];
        [self addSubview:pageControl];
        _pageControl = pageControl;
    }
    return _pageControl;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUIOnce];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUIOnce];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}


@end

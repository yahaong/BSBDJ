//
//  EssenceViewController.m
//  BSBDJ
//
//  Created by yahaong on 16/5/29.
//  Copyright © 2016年 yahaong. All rights reserved.
//

#import "EssenceViewController.h"
#import "EssenceTableViewController.h"
#import "TitleLabel.h"
#import "ContentScrollViewLayout.h"
#import "AllViewController.h"
// 默认标题间距
static CGFloat const margin = 20;
static CGFloat const kTitleHeight = 44;

// 标题缩放比例
static CGFloat const TitleTransformScale = 1.3;
@interface EssenceViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property(nonatomic, assign, getter=isInitial) BOOL isInitial;

@property(nonatomic, strong)UIScrollView *titleScrollView;
@property(nonatomic, strong)UICollectionView *contentScrollView;
@property(nonatomic, strong)NSArray *titles;
@property(nonatomic, strong)NSMutableArray *titleWidths;
@property(nonatomic, strong)NSMutableArray *titleLabels;
@property(nonatomic, assign)CGFloat titleMargin;
@property(nonatomic, strong)UIFont *titleFont;
@property(nonatomic, assign)NSInteger selectIndex;

@end

@implementation EssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationView];
    [self setupTitleScrollView];
    [self setupAllViewController];
    [self setupContentScrollView];

}
- (void)setupScrollView
{
    UIScrollView *scrollView =[[UIScrollView alloc]init];
    scrollView.backgroundColor = kCommonBgColor;
    scrollView.frame = self.view.frame;
    [self.view addSubview:scrollView];
}
- (void)setupContentScrollView
{
    ContentScrollViewLayout *layout = [[ContentScrollViewLayout alloc]init];
    
    UICollectionView *contentScrollView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    contentScrollView.showsVerticalScrollIndicator = NO;
    contentScrollView.showsHorizontalScrollIndicator = NO;
    contentScrollView.pagingEnabled = YES;
    contentScrollView.dataSource = self;
    contentScrollView.delegate = self;
    [contentScrollView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([EssenceViewController class])];
    contentScrollView.frame = CGRectMake(0, CGRectGetMaxY(self.titleScrollView.frame), SCREEN_WIDTH, self.view.height - CGRectGetMaxY(self.titleScrollView.frame)  );
    contentScrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:contentScrollView];
    self.contentScrollView = contentScrollView;
}
- (void)setupTitleScrollView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *titleScrollView = [[UIScrollView alloc]init];
    titleScrollView.backgroundColor = [UIColor cyanColor];
    titleScrollView.frame = CGRectMake(0, kNavigationBarH, SCREEN_WIDTH, kTitleHeight);
    [self.view addSubview:titleScrollView];
    self.titleScrollView = titleScrollView;
}
- (void)setupAllViewController
{
    NSArray *titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    [titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0) {
            AllViewController *vc = [[AllViewController alloc]init];
            vc.title = obj;
            [self addChildViewController:vc];
            
        } else {
            EssenceTableViewController *vc = [[EssenceTableViewController alloc]init];
            vc.title = obj;
            [self addChildViewController:vc];
        }

    }];
  
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (NO == self.isInitial ) {
        self.isInitial = YES;
        [self setupTitlesWidth];
        [self setUpAllTitle];
    }
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}
- (void)setUpAllTitle
{
    // 添加所有的标题
    CGFloat labelW = 0;
    CGFloat labelH = self.titleScrollView.height;
    CGFloat labelX = 0;
    CGFloat labelY = 0;
    CGFloat count = self.childViewControllers.count;
    for (NSInteger i = 0; i < count; i++) {
        TitleLabel * lable = [[TitleLabel alloc]init];
        lable.text = [self.childViewControllers[i] title];
        lable.tag = i;
        labelW = [self.titleWidths[i] floatValue];
        TitleLabel *label = self.titleLabels.lastObject;
        labelX = CGRectGetMaxX(label.frame) + self.titleMargin;
        lable.frame = CGRectMake(labelX, labelY, labelW, labelH);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleClick:)];
        [lable addGestureRecognizer:tap];
        [self.titleScrollView addSubview:lable];
        [self.titleLabels addObject:lable];
    }
    UILabel *lastLabel = self.titleLabels.lastObject;
    self.titleScrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastLabel.frame), 0);
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
}
- (void)titleClick:(UITapGestureRecognizer *)tapGres {
    UILabel *label = (UILabel *)tapGres.view;
     NSInteger i = label.tag;
     [self selectLabel:label];
    // 内容滚动视图滚动到对应位置
    CGFloat offsetX = i * SCREEN_WIDTH;
    
    self.contentScrollView.contentOffset = CGPointMake(offsetX, 0);

}

- (void)selectLabel:(UILabel *)label
{
    for (TitleLabel *labelView in self.titleLabels) {
           if (label == labelView) continue;
        labelView.transform = CGAffineTransformIdentity;
        labelView.textColor = [UIColor blackColor];
    }
    CGFloat scaleTransform = TitleTransformScale;
    label.transform = CGAffineTransformMakeScale(scaleTransform, scaleTransform);
    // 修改标题选中颜色
    label.textColor = [UIColor redColor];
    // 设置标题居中
    [self setLabelTitleCenter:label];

}
// 让选中的按钮居中显示
- (void)setLabelTitleCenter:(UILabel *)label
{
    // 设置标题滚动区域的偏移量
    CGFloat offsetX = label.center.x - SCREEN_WIDTH * 0.5;
    
    if (offsetX < 0) {
        offsetX = 0;
    }
    // 计算下最大的标题视图滚动区域
    CGFloat maxOffsetX = self.titleScrollView.contentSize.width - SCREEN_WIDTH + _titleMargin;
    
    if (maxOffsetX < 0) {
        maxOffsetX = 0;
    }
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    // 滚动区域
    [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}
- (void)setupTitlesWidth
{
    NSArray *titles = [self.childViewControllers valueForKey:@"title"];
    CGFloat totalWidth = 0;
    for (NSString *titleStr  in titles) {
        CGRect titleFrame = [titleStr boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.titleFont} context:nil];
        CGFloat width = titleFrame.size.width;
        [self.titleWidths addObject:@(width)];
        totalWidth += width;
    }
    if (totalWidth > self.titleScrollView.width) {
        self.titleMargin = margin;
        self.titleScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, self.titleMargin);
        return;
    }
    CGFloat titleMargin = (self.titleScrollView.width - totalWidth) / (self.childViewControllers.count + 1);
    self.titleMargin = titleMargin < margin ? margin : titleMargin;
    self.titleScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, self.titleMargin);
}

- (void)setupNavigationView
{
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem createBarButtonItem:@"MainTagSubIcon" highlightedImage:@"MainTagSubIconClick" target:self action:@selector(navigationLeftItemClick)];
}
- (void)navigationLeftItemClick
{
    DLog();
}

#pragma mark - <UICollectionViewDatasource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.childViewControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([EssenceViewController class]) forIndexPath:indexPath];
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIViewController *vc = self.childViewControllers[indexPath.item];
    vc.view.frame = CGRectMake(0, 0, self.contentScrollView.width, self.contentScrollView.height);
    [cell.contentView addSubview:vc.view];
    return cell;
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    // 获取角标
    NSInteger i = offsetX / SCREEN_WIDTH;
    // 选中标题
    [self selectLabel:self.titleLabels[i]];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获取偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    // 获取左边角标
    NSInteger leftIndex = offsetX / SCREEN_WIDTH;
    
    // 左边按钮
    TitleLabel *leftLabel = self.titleLabels[leftIndex];
    
    // 右边角标
    NSInteger rightIndex = leftIndex + 1;
    
    // 右边按钮
    TitleLabel *rightLabel = nil;
    if (rightIndex < self.titleLabels.count) {
        rightLabel = self.titleLabels[rightIndex];
    }
    // 字体放大
    [self setUpTitleScaleWithOffset:offsetX rightLabel:rightLabel leftLabel:leftLabel];
    
}
// 标题缩放
- (void)setUpTitleScaleWithOffset:(CGFloat)offsetX rightLabel:(UILabel *)rightLabel leftLabel:(UILabel *)leftLabel
{
    // 获取右边缩放
    CGFloat rightSacle = offsetX / SCREEN_WIDTH - leftLabel.tag;

    CGFloat leftScale = 1 - rightSacle;
    CGFloat scaleTransform = TitleTransformScale;
    scaleTransform -= 1;
    // 缩放按钮
    leftLabel.transform = CGAffineTransformMakeScale(leftScale * scaleTransform + 1, leftScale * scaleTransform + 1);
    rightLabel.transform = CGAffineTransformMakeScale(rightSacle * scaleTransform + 1, rightSacle * scaleTransform + 1);
}


#pragma mark - 懒加载
- (NSMutableArray *)titleWidths
{
    if (!_titleWidths){
        _titleWidths = [NSMutableArray array];
    }
    return _titleWidths;
}
- (UIFont *)titleFont
{
    if (!_titleFont){
        _titleFont = [UIFont systemFontOfSize:15];
    }
    return _titleFont;
}
- (NSMutableArray *)titleLabels
{
    if (!_titleLabels){
        _titleLabels = [NSMutableArray array];;
    }
    return _titleLabels;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

}

@end







#import "SDCategoryScrollView.h"
#import "SDCollectionViewCell.h"


#define KWidth (self.bounds.size.width)
#define KHeight (self.bounds.size.height)
#define KMargin 10.0f

@interface  SDCategoryScrollView()<UICollectionViewDelegate,
                                    UICollectionViewDataSource>

/** collectionView */
@property (nonatomic, strong) UICollectionView *collectionView;
/** 线条背景 */
@property (nonatomic, strong) UIView *lineBackgroundView;
/** 线条 */
@property (nonatomic, strong) UIView *lineView;

@end

@implementation SDCategoryScrollView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.collectionView];
        [self addSubview:self.lineBackgroundView];
        [self.lineBackgroundView addSubview:self.lineView];
        
    }
    return self;
}


#pragma mark - UICollectionView DataSource Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return _dataSource.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
 
    SDCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SDCollectionViewCell class]) forIndexPath:indexPath];
    return cell;
    
}


#pragma mark - cell点击
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%zd",indexPath.item);
}

#pragma mark - 懒加载
-(UICollectionView *)collectionView{
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        // 设置cell大小
        CGFloat itemWidth = (KWidth - KMargin * 6) / 5;
        CGFloat itemHeight = (KHeight - KMargin * 5) * 0.5;
        flowLayout.itemSize = CGSizeMake(itemWidth, itemHeight);
        // 设置行列间距
        flowLayout.minimumLineSpacing = KMargin;
        flowLayout.minimumInteritemSpacing = KMargin;
        // 设置滚动方法
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.sectionInset = UIEdgeInsetsMake(KMargin, KMargin, KMargin, KMargin);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KWidth, KHeight - KMargin*2) collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        //注册cell
        [_collectionView registerClass:[SDCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([SDCollectionViewCell class])];
    }
    return _collectionView;
}


-(UIView *)lineBackgroundView{
    if (_lineBackgroundView == nil) {
        _lineBackgroundView = [[UIView alloc] init];
        CGFloat w = 100;
        CGFloat h = 4;
        CGFloat x = (KWidth - w) * 0.5;
        CGFloat y = CGRectGetMaxY(self.collectionView.frame) + 8;
        _lineBackgroundView.frame = CGRectMake(x, y, w, h);
        _lineBackgroundView.backgroundColor = [UIColor lightGrayColor];
        _lineBackgroundView.layer.cornerRadius = h * 0.5;
        _lineBackgroundView.layer.masksToBounds = YES;
    }
    return _lineBackgroundView;
}

-(UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor orangeColor];
        CGFloat w = 30;
        CGFloat h = self.lineBackgroundView.bounds.size.height;
        CGFloat x = 0;
        CGFloat y = 0;
        self.lineView.frame = CGRectMake(x, y, w, h);
        _lineView.layer.cornerRadius = h * 0.5;
        _lineView.layer.masksToBounds = YES;
    }
    return _lineView;
}

#pragma mark - 监听滚动 代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    
    //线条宽度
    CGFloat lineWidth = self.lineView.bounds.size.width;
    //线条背景宽度
    CGFloat lineBgWidth = self.lineBackgroundView.bounds.size.width;
    //collectionView宽度
    CGFloat scrollWidth = self.collectionView.bounds.size.width;
    //contentSize的宽度
    CGFloat contentWidth = scrollView.contentSize.width;
    
    //比例
    CGFloat scale = (lineBgWidth - lineWidth) / (contentWidth - scrollWidth);
    
    
    //如果到最左边,让滚动条不可继续滚动
    if (offsetX < 0) {
        
         _lineView.transform = CGAffineTransformIdentity;
        
    //如果到最右边,让滚动条不可继续滚动
    }else if(offsetX > (scrollView.contentSize.width - KWidth)){
        
        _lineView.transform = CGAffineTransformMakeTranslation(scale*(scrollView.contentSize.width - KWidth), 0);
        
    //滚动条可以滚动
    }else{
        _lineView.transform = CGAffineTransformMakeTranslation(scale*offsetX, 0);
    }
}


-(void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
    
    [self.collectionView reloadData];
}

@end

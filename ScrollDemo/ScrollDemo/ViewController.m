//
//  ViewController.m
//  ScrollDemo
//
//  Created by xialan on 2019/6/28.
//  Copyright © 2019 xialan. All rights reserved.
//

#import "ViewController.h"
#import "SDCategoryScrollView.h"

@interface ViewController ()

/** <#  #> */
@property (nonatomic, strong) SDCategoryScrollView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
    
    NSMutableArray *arrm= [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 16; i++) {
        [arrm addObject:@(i)];
    }
    self.collectionView.dataSource = arrm.copy;

}

-(SDCategoryScrollView *)collectionView{
    if (_collectionView == nil) {
        _collectionView = [[SDCategoryScrollView alloc] initWithFrame:CGRectMake(0, 100, 375, 200)];
        _collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _collectionView;
}


@end

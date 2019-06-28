//
//  SDCollectionViewCell.m
//  ScrollDemo
//
//  Created by xialan on 2019/6/28.
//  Copyright © 2019 xialan. All rights reserved.
//

#import "SDCollectionViewCell.h"

@interface SDCollectionViewCell()

/** img */
@property (nonatomic, strong) UIImageView *imgView;
/** name */
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation SDCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame ]) {
        
        _imgView = [[UIImageView alloc] init];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        _imgView.image = [UIImage imageNamed:@"home_button_shop"];
        [self.contentView addSubview:_imgView];
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.text = @"商城";
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_nameLabel];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat w = self.contentView.bounds.size.width;
    CGFloat h = self.contentView.bounds.size.height - 30;
    CGFloat x = 0;
    CGFloat y = 0;
    
    _imgView.frame = CGRectMake(x, y, w, h);
    
    
    w = self.contentView.bounds.size.width;
    h = 30;
    x = 0;
    y = CGRectGetMaxY(_imgView.frame);
    
    _nameLabel.frame = CGRectMake(x, y, w, h);
}

@end

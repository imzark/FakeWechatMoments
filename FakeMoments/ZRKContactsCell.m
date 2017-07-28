//
//  ZRKContactsCell.m
//  FakeMoments
//
//  Created by Zark on 2017/7/19.
//  Copyright © 2017年 Zarky. All rights reserved.
//

#import "ZRKContactsCell.h"
#import <Masonry.h>

static const CGFloat kAvaterPadding = 10;

@implementation ZRKContactsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    _avatarImageView = [[UIImageView alloc] init];
    _nameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_avatarImageView];
    [self.contentView addSubview:_nameLabel];
    
    [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(kAvaterPadding);
        make.left.mas_equalTo(self.contentView.mas_left).offset(kAvaterPadding);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-kAvaterPadding);
        make.width.mas_equalTo(_avatarImageView.mas_height);
    }];
    
    _nameLabel.font = [UIFont fontWithName:@"Heiti SC" size:15];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(_avatarImageView.mas_right).offset(kAvaterPadding);
    }];
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

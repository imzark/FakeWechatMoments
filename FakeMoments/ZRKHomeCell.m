//
//  ZRKHomeCell.m
//  FakeMoments
//
//  Created by Zark on 2017/7/18.
//  Copyright © 2017年 Zarky. All rights reserved.
//

#import "ZRKHomeCell.h"
#import <Masonry.h>

//@interface ZRKHomeCell ()
//
//@property (nonatomic, strong) UIImageView *avatarImageView;
//@property (nonatomic, strong) UILabel *nameLabel;
//@property (nonatomic, strong) UILabel *summaryLabel;
//@property (nonatomic, strong) UILabel *TimeLabel;
//
//@end

static CGFloat const kLabelGap = 10;
static CGFloat const kAvaterGap = 7;
static CGFloat const kLittleGap = 3;

@implementation ZRKHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    
    _avatarImageView = [[UIImageView alloc] init];
    _nameLabel = [[UILabel alloc] init];
    _summaryLabel = [[UILabel alloc] init];
    _TimeLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_avatarImageView];
    [self.contentView addSubview:_nameLabel];
    [self.contentView addSubview:_summaryLabel];
    [self.contentView addSubview:_TimeLabel];
    
    _avatarImageView.layer.cornerRadius = 5;
    _avatarImageView.layer.masksToBounds = true;
    
    [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(kAvaterGap);
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(kAvaterGap);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-kAvaterGap);
        make.width.mas_equalTo(_avatarImageView.mas_height);
    }];
    
//    _nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.font = [UIFont fontWithName:@"Heiti SC" size:20];
                       
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.greaterThanOrEqualTo(self.contentView.mas_top).mas_offset(kLabelGap);
        make.left.mas_equalTo(_avatarImageView.mas_right).mas_offset(kAvaterGap);
        make.bottom.mas_equalTo(self.contentView.mas_centerY).mas_offset(-kLittleGap);
    }];
    
//    _summaryLabel.textAlignment = NSTextAlignmentLeft;
    _summaryLabel.font = [UIFont fontWithName:@"Heiti SC" size:15];
    _summaryLabel.textColor = [UIColor darkGrayColor];
    
    [_summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_centerY).mas_offset(kLittleGap);
        make.left.mas_equalTo(_avatarImageView.mas_right).mas_offset(kAvaterGap);
//        make.bottom.greaterThanOrEqualTo(self.contentView).mas_offset(kLabelGap);
        make.right.mas_equalTo(self.contentView).mas_offset(kLabelGap);
    }];
    
    _TimeLabel.font = [UIFont fontWithName:@"Heiti SC" size:13];
    _TimeLabel.textColor = [UIColor grayColor];
    
    [_TimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(kLabelGap);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-kAvaterGap);
    }];
    
}

- (void)setFrame:(CGRect)frame {
    
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

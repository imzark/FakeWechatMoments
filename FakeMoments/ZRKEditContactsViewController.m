//
//  ZRKEditContactsViewController.m
//  FakeMoments
//
//  Created by Zark on 2017/7/20.
//  Copyright © 2017年 Zarky. All rights reserved.
//

#import "ZRKEditContactsViewController.h"
#import <Masonry.h>
#import "ZRKDBManager.h"
#import "ZRKContactsModel.h"

typedef enum : NSUInteger {
    insertStyle,
    editStyle,
} initializationStyle;

@interface ZRKEditContactsViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *briefTextField;
@property (nonatomic, strong) UITextField *picUrlTextField;
@property (nonatomic, strong) ZRKDBManager *dbManager;

@end

static NSString *const dbFileName = @"zarkyContactsInfo.sql";



@implementation ZRKEditContactsViewController

#pragma mark - LifeCircle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    [self initTextField];
    [self initNaviBtn];
    
    _dbManager = [[ZRKDBManager alloc] initWithDataBaseFileName:dbFileName];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Pravite

- (void)initTextField {

    self.nameTextField.delegate = self;
    self.briefTextField.delegate = self;
    self.picUrlTextField.delegate = self;

    self.nameTextField.placeholder = @"Name";
    self.briefTextField.placeholder = @"Brief";
    self.picUrlTextField.placeholder = @"PicUrl";
    
    self.nameTextField.backgroundColor = [UIColor grayColor];
    self.briefTextField.backgroundColor = [UIColor greenColor];
    self.picUrlTextField.backgroundColor = [UIColor redColor];
    
    self.picUrlTextField.enabled = false;
    
    [self.view addSubview:_nameTextField];
    [self.view addSubview:_briefTextField];
    [self.view addSubview:_picUrlTextField];
    
    [_nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).mas_offset(90);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(10);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-10);
        make.height.mas_equalTo(_briefTextField.mas_height);
//        make.bottom.mas_equalTo(_briefTextField.mas_top).mas_offset(-10);
    }];
    [_briefTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameTextField.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(10);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-10);
        make.height.mas_equalTo(_picUrlTextField.mas_height);
        
    }];
    [_picUrlTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_briefTextField.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(10);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-10);
        make.bottom.mas_equalTo(self.view.mas_centerY).mas_offset(10);
    }];
}

- (void)initNaviBtn {
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveInfo)];
    self.navigationItem.rightBarButtonItem = saveButton;
}

- (void)saveInfo {
    
    if (_nameTextField.text.length == 0) {
        _nameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"不能为空" attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
        return;
    } else {
        _nameTextField.placeholder = @"Name";
    }
    self.model.name = self.nameTextField.text;
    self.model.brief = self.briefTextField.text;
    self.model.picUrl = self.picUrlTextField.text;

    if (!self.model.userId) {
        // add
        BOOL succ = [_dbManager insertContactsModel:self.model];
        
        if (succ && [_delegate respondsToSelector:@selector(editContactControllerDidAddContactData:)]) {
            [_delegate editContactControllerDidAddContactData:self.model];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            NSLog(@"Insert Data Failed");
        }
    } else {
        // update
        BOOL succ = [_dbManager updateContactsModel:self.model];
    
        if (succ && [_delegate respondsToSelector:@selector(editContactControllerDidEditContactData:)]) {
            [_delegate editContactControllerDidEditContactData:self.model];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            NSLog(@"Update Data Failed");
        }
    }
}

#pragma mark - TextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Setters & Getters


@synthesize model = _model;
- (void)setModel:(ZRKContactsModel *)model {
    if (!_model) {
        _model = [[ZRKContactsModel alloc] init];
    }
    _model = model;
    self.nameTextField.text = self.model.name ? : @"";
    self.briefTextField.text = self.model.brief? : @"";
    self.picUrlTextField.text = self.model.picUrl? : @"";
}

- (ZRKContactsModel *)model {
    if (!_model) {
        _model = [[ZRKContactsModel alloc] init];
    }
    return _model;
}

- (UITextField *)nameTextField {
    if (!_nameTextField) {
        _nameTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    }
    return _nameTextField;
}

- (UITextField *)briefTextField {
    if (!_briefTextField) {
        _briefTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    }
    return _briefTextField;
}

- (UITextField *)picUrlTextField {
    if (!_picUrlTextField) {
        _picUrlTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    }
    return _picUrlTextField;
}


@end

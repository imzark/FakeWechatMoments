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

@property (nonatomic, assign) NSInteger dataId;
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *briefTextField;
@property (nonatomic, strong) UITextField *picUrlTextField;
@property (nonatomic, strong) ZRKDBManager *dbManager;

@end

static NSString *const dbFileName = @"zarkyContactsInfo.sql";

@implementation ZRKEditContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    [self initTextField];
    [self initNaviBtn];
    
    _dbManager = [[ZRKDBManager alloc] initWithDataBaseFileName:dbFileName];
    
}

- (void)initTextField {
    _nameTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    _briefTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    _picUrlTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    
    _nameTextField.delegate = self;
    _briefTextField.delegate = self;
    _picUrlTextField.delegate = self;

    _nameTextField.placeholder = @"Name";
    _briefTextField.placeholder = @"Brief";
    _picUrlTextField.placeholder = @"PicUrl";
    
    _nameTextField.backgroundColor = [UIColor grayColor];
    _briefTextField.backgroundColor = [UIColor greenColor];
    _picUrlTextField.backgroundColor = [UIColor redColor];
    
    _picUrlTextField.enabled = false;
    
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

        if (!_dataId) {
            [_dbManager insertDataWithArray:[NSArray arrayWithObjects:_nameTextField.text,_briefTextField.text,_picUrlTextField.text, nil]];
            
            //add
            
            if ([_delegate respondsToSelector:@selector(editContactControllerDidEditContactData:)]) {

            
            [self.navigationController popViewControllerAnimated:YES];

        } else {
            NSArray *dataArray = [NSArray arrayWithObjects:_nameTextField.text,_briefTextField.text,_picUrlTextField.text, _dataId, nil];
            [_dbManager updateDataWithArray:dataArray];
        
            if ([_delegate respondsToSelector:@selector(editContactControllerDidEditContactData:)]) {
                
                ZRKContactsModel *model = [[ZRKContactsModel alloc] init];
                model.name = dataArray[0];
                model.brief = dataArray[1];
                model.picUrl = dataArray[2];
                model.userId = (int)dataArray[3];
                [_delegate editContactControllerDidEditContactData:model];
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)updateData:(NSArray *)textArray {
    _dataId = (NSInteger)[textArray objectAtIndex:0];
    _nameTextField.text = [textArray objectAtIndex:1];
    _briefTextField.text = [textArray objectAtIndex:2];
    _picUrlTextField.text = [textArray objectAtIndex:3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

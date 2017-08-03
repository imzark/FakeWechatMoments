//
//  ZRKContactsViewController.m
//  FakeMoments
//
//  Created by Zark on 2017/7/17.
//  Copyright © 2017年 Zarky. All rights reserved.
//

#import "ZRKContactsViewController.h"
#import "ZRKContactsCell.h"
#import "ZRKEditContactsViewController.h"
#import "ZRKDBManager.h"
#import "ZRKContactsModel.h"

@interface ZRKContactsViewController () <ZRKEditContactsDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) ZRKDBManager *dbManager;
@property (nonatomic, strong) NSMutableArray<ZRKContactsModel *> *resArray;

@end

static NSString *const dbFileName = @"zarkyContactsInfo.sql";
static const CGFloat kTableViewCellHeight = 55;

@implementation ZRKContactsViewController

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    _dbManager = [[ZRKDBManager alloc] initWithDataBaseFileName:dbFileName];
    [self loadDataFromDB];
    [self setupTableView];
    [self setupNaviBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Pravite

- (void)setupTableView {
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 0);
    self.tableView.rowHeight = kTableViewCellHeight;
    
    [self registerCellWithClass:@"ZRKContactsCell" tableView:self.tableView];
}

- (void)setupNaviBar {
    UIBarButtonItem *addContact = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"contacts_add_friend"] style:UIBarButtonItemStylePlain target:self action:@selector(addNewContact)];
    self.navigationItem.rightBarButtonItem = addContact;
}

- (void)addNewContact {
    ZRKEditContactsViewController *newVC = [[ZRKEditContactsViewController alloc] init];
    newVC.delegate = self;
    [self.navigationController pushViewController:newVC  animated:YES];
}

- (void)loadDataFromDB {
    
    _resArray = [[_dbManager queryContactsModelsArray] mutableCopy];
    self.dataSource = _resArray;
    [self.tableView reloadData];
}

#pragma mark - ZRKEditContactsDelegate

- (void)editContactControllerDidAddContactData:(ZRKContactsModel *)model {
    [self.dataSource addObject:model];
    [self.tableView reloadData];
}

- (void)editContactControllerDidEditContactData:(ZRKContactsModel *)model {

    NSIndexPath *indexPath = [[NSIndexPath alloc] init];

    for (NSUInteger i = 0; i<self.dataSource.count; i++) {
        ZRKContactsModel *m = self.dataSource[i];
        if (m.userId == model.userId) {
            NSIndexPath *indexP = [NSIndexPath indexPathForRow:i inSection:0];
            indexPath = indexP;
            self.dataSource[i] = model;
        }
    }
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
}

#pragma mark - TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZRKContactsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZRKContactsCell" forIndexPath:indexPath];
    
    //    cell.textLabel.text = self.dataSource[indexPath.row];
    ZRKContactsModel *model = self.dataSource[indexPath.row];
    cell.nameLabel.text = model.name;
    cell.avatarImageView.image = [UIImage imageNamed:@"Avater"];
    
    return cell;
}

#pragma mark - TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"用户" message:@"这是一段Alert提醒" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
//    [alertVC addAction:okAction];
//    [self presentViewController:alertVC animated:YES completion:nil];
    
    ZRKEditContactsViewController *vc = [[ZRKEditContactsViewController alloc] init];
    vc.delegate = self;
    vc.model = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

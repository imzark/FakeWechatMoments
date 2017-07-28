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
#import "ZRKContactsDBManager.h"
#import "ZRKContactsModel.h"

@interface ZRKContactsViewController () <ZRKEditContactsDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) ZRKContactsDBManager *dbManager;
@property (nonatomic, strong) NSMutableArray<ZRKContactsModel *> *resArray;

@end

static NSString *const dbFileName = @"zarkyContactsInfo.sql";
static const CGFloat kTableViewCellHeight = 55;

@implementation ZRKContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dbManager = [[ZRKContactsDBManager alloc] initWithDataBaseFileName:dbFileName];
    [self loadDataFromDB];
    [self setupTableView];
    [self setupNaviBar];
}

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - ZRKEditContactsDelegate

- (void)editContactControllerDidAddContactData:(ZRKContactsModel *)model {
    
    [self.dataSource addObject:model];
    [self.tableView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
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
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"用户" message:@"这是一段Alert提醒" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:okAction];
    [self presentViewController:alertVC animated:YES completion:nil];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    ZRKEditContactsViewController *vc = [[ZRKEditContactsViewController alloc] init];
//    // NEED A MODEL............
//    // dataSource = modelArray
//}



@end

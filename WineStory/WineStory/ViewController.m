//
//  ViewController.m
//  WineStory
//
//  Created by 游峰 on 16/4/23.
//  Copyright © 2016年 yf. All rights reserved.
//

#import "ViewController.h"
#import "CircleButton.h"
#import "Wine.h"
#import "WineCell.h"

#import <MJExtension.h>


@interface ViewController () <UITabBarDelegate,UITableViewDataSource>//<UITabBarDelegate,UITableViewDataSource,WineCellDelegate>

@property (weak, nonatomic) IBOutlet UILabel *total;
@property (weak, nonatomic) IBOutlet UIButton *cleanBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray * wineArr;
@property (strong, nonatomic) NSMutableArray * wineCar;
@property (weak, nonatomic) IBOutlet UIButton * getWineBtn;

@end

static NSString * wineCellId = @"WineCell";
@implementation ViewController

#pragma mark -- lazy
- (NSMutableArray *)wineCar
{
    if (!_wineCar)
    {
        NSMutableArray *arrM = [NSMutableArray array];
        
        _wineCar = arrM;
    }
    return _wineCar;
}

- (NSArray *)wineArr
{
    if (!_wineArr)
    {
        NSArray * arr = [Wine mj_objectArrayWithFilename:@"wine.plist"];
        
//        for (Wine * wine in arr) {
//            //用KVO实现
//            [wine addObserver:self forKeyPath:@"count" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
//        }
        _wineArr = arr;
    }
    return _wineArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //通过代理实现
    //1.展示的东西不多， wine类《plist文件解析》
    //2.主页面要显示总结价格、购买和清空选项
    //3.cell可以选择添加选择类型的数量
    //4.监听cell控件操作的功能
    //5.实现代码
    
    
    //通过KVO来实现：
    
    //通知：
    NSNotificationCenter * notCenter = [NSNotificationCenter defaultCenter];
    [notCenter addObserver:self selector:@selector(plusClick:) name:@"plusClickNotification"  object:nil];
    [notCenter addObserver:self selector:@selector(minusClick:) name:@"minusClickNotification" object:nil];
    
}

#pragma mark -- 通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)plusClick:(NSNotification *)note
{
    self.getWineBtn.enabled = YES;
    WineCell * cell = note.object;
    int  total = self.total.text.intValue + cell.wine.money.intValue;
    self.total.text = [NSString stringWithFormat:@"%d",total];
}

- (void)minusClick:(NSNotification *)note
{
    WineCell * cell = note.object;
    int  total = self.total.text.intValue - cell.wine.money.intValue;
    self.total.text = [NSString stringWithFormat:@"%d",total];
    self.getWineBtn.enabled = (total > 0);
}

#pragma mark -- 观察者模式的方法
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(Wine *)Wine change:(NSDictionary<NSString *,id> *)change context:(void *)context
//{
//    int  new = [change[NSKeyValueChangeNewKey] intValue];
//    int  old = [change[NSKeyValueChangeOldKey] intValue];
//    
//    int total = 0;
//    if (new > old) {
//        
//        total = self.total.text.intValue + Wine.money.intValue;
//        self.total.text = [NSString stringWithFormat:@"%d",total];
//        self.getWineBtn.enabled = YES;
//    }else
//    {
//        total = self.total.text.intValue - Wine.money.intValue;
//        self.total.text = [NSString stringWithFormat:@"%d",total];
//        self.getWineBtn.enabled = (total >0);
//    }
//}
//
//- (void)dealloc
//{
//    for (Wine * wine in self.wineCar) {
//        [wine removeObserver:self forKeyPath:@"count"];
//    }
//}

#pragma mark -- tableView Delete 、 DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.wineArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    WineCell * cell = [tableView dequeueReusableCellWithIdentifier:wineCellId];
    cell.wine = self.wineArr[indexPath.row];
//    cell.delegate = self;
    return cell;
}

#pragma mark -- WineCellDelegate
- (void)wineCellDidClickPlusButton:(WineCell *)wineCell
{
    int total = self.total.text.intValue + wineCell.wine.money.intValue;
    self.total.text = [NSString stringWithFormat:@"%d",total];
    self.getWineBtn.enabled = YES;
    if ([self.wineCar containsObject:wineCell.wine])return;
    [self.wineCar addObject:wineCell.wine];
}

- (void)wineCellDidClickMinusButton:(WineCell *)wineCell
{
    int total = self.total.text.intValue - wineCell.wine.money.intValue;
    self.total.text = [NSString stringWithFormat:@"%d",total];
    self.getWineBtn.enabled = total > 0;

    if (wineCell.wine.count == 0)
    {
        [self.wineCar removeObject:wineCell.wine];
    }

}

- (IBAction)clean:(UIButton *)sender {
    
    for (Wine * wine in self.wineCar) {
        wine.count = 0;
    }
    [self.tableView reloadData];
    [self.wineCar removeAllObjects];
    self.getWineBtn.enabled = NO;
    self.total.text = @"0";
}

- (IBAction)buy:(UIButton *)sender {

    for (Wine * wine in self.wineCar) {
        NSLog(@"%d [%@]",wine.count, wine.name);
    }
   
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  BSettingController.m
//  Bus
//
//  Created by 朱辉 on 16/4/14.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import "BSettingController.h"
#import "BIntervalTimeToolBar.h"
#import "MobClick.h"
#import "BPreference.h"

#import <objc/runtime.h>

@interface BSettingController () <UIGestureRecognizerDelegate, UIPickerViewDataSource, UIPickerViewDelegate, BIntervalTimeToolBarDelegate,UIAlertViewDelegate>

/**
 *  检测更新label
 */
@property (weak, nonatomic) IBOutlet UILabel *checkVersionLabel;

/**
 *  显示刷新间隔类型的label
 */
@property (weak, nonatomic) IBOutlet UILabel *intervalTimeLabel;

/**
 *  弹出键盘用的
 */
@property (nonatomic,strong) UITextView* textView;

/**
 *  pickerview数据
 */
@property (nonatomic,strong) NSArray<NSString*>* pickerData;

@property (nonatomic,weak) UIPickerView* pickerView;


@end

@implementation BSettingController

+ (NSString*)description {
    return [NSString stringWithFormat:@"设置(%@)",NSStringFromClass([self class])];
}

#pragma mark - 友盟页面统计

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:[[self class]description]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MobClick endLogPageView:[[self class]description]];
}


+ (instancetype)settingVC {
    
    UIStoryboard* story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    return [story instantiateViewControllerWithIdentifier:@"settingvc"];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"设置";
    
    /**
     *  设置 检测更新版本
     */
    self.checkVersionLabel.text = [self.checkVersionLabel.text stringByAppendingString: [NSString stringWithFormat:@" (%@)", BVersion]];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tableViewTouch:)];
    tap.delegate = self;
    [self.tableView addGestureRecognizer:tap];
    
    UITextView* textView = [[UITextView alloc]init];
    self.textView = textView;
    [self.view addSubview:textView];
    
    
    // 设置pickerView 数据
    self.pickerData = @[@"1秒", @"5秒", @"20秒", @"30秒", @"1分钟", @"2分钟", @"5分钟", @"手动刷新", @"自定义"];
    
    [self fillWithPreference];
}

- (void)fillWithPreference {
    
    NSString* typeStr = [BPreference intervalTimeType];
    if([typeStr isEqualToString:@"自定义"]) {
        typeStr = [NSString stringWithFormat:@"自定义(%ld秒)", (long)[BPreference secondForCustom]];
    }
    self.intervalTimeLabel.text = typeStr;
    
}

- (void)tableViewTouch:(UITapGestureRecognizer*)tap {
    [self.tableView endEditing:YES];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.textView.isFirstResponder;
}

#pragma mark - TableView代理

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if(section == 1) {
        return 40;
    }
    
    return 0.5;
}

- (NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if(section == 1) {
        return @"如果你不在意分秒级别的误差，建议将间隔设大或者手动刷新。这样更省流量哦^_^";
    }
    return @"";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 4) {
        if(indexPath.row == 0) {
            [self dashangDidClick:tableView indexPath:indexPath];
        }
    }else if(indexPath.section == 1) {
        if(indexPath.row ==0) {
            [self intervalTimeDidClick:tableView indexPath:indexPath];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIPickerView 数据源

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.pickerData.count;
}

#pragma mark - UIPickerView 代理
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    
    return self.pickerData[row];
}


#pragma mark - BIntervalTimeToolBarDelegate 代理
- (void)intervalTimeToolBarDone:(BIntervalTimeToolBar*)toolBar {
    NSInteger selectedRow = [self.pickerView selectedRowInComponent:0];
    NSString* typeStr = [self pickerView:self.pickerView titleForRow:selectedRow forComponent:0];
    
    // 如果是用户自定义时间间隔
    if ([typeStr isEqualToString:@"自定义"]) {
        
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"请输入间隔时间(秒)" message:@"" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.delegate = self;
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        
        objc_setAssociatedObject(alert, @"typeStr", typeStr, OBJC_ASSOCIATION_COPY);
        
        // 设置为数字输入
        UITextField* textField = [alert textFieldAtIndex:0];
        textField.keyboardType = UIKeyboardTypeNumberPad;
        
        // 获取当前保存的时间
        textField.text = [NSString stringWithFormat:@"%ld", (long)[BPreference secondForCustom]];
        
        [alert show];
        
    } else {
        
        // 按下时，选中的跟原来选中的一样，则返回
        if([self.pickerData[selectedRow] isEqualToString:[BPreference intervalTimeType]]){
            [self.view endEditing:YES];
            return;
        }
        
        // 保存到本地
        [self didSelectIntervalType:typeStr];
        // 更新 间隔时间文字
        self.intervalTimeLabel.text = typeStr;
        [self.tableView endEditing:YES];
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 1) {
        
        UITextField* textField = [alertView textFieldAtIndex:0];
        // 保存用户输入的时间
        [BPreference setSecondForCustom:textField.text.integerValue];
        
        // 更新 间隔时间文字
        self.intervalTimeLabel.text = [NSString stringWithFormat:@"自定义(%@秒)", textField.text];
        
        NSString* typeStr = objc_getAssociatedObject(alertView, @"typeStr");
        // 保存到本地
        [self didSelectIntervalType:typeStr];
        
        [textField endEditing:YES];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 1) {
        [self.textView endEditing:YES];
    }
}


/**
 *  打赏被点击
 */
- (void)dashangDidClick:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"^_^" message:@"谢谢土豪" delegate:nil cancelButtonTitle:@"不谢" otherButtonTitles:nil];
    [alertView show];
}

/**
 *  实时公交间隔被点击
 */
- (void)intervalTimeDidClick:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
    
    // 自定义键盘
    UIPickerView* pickView = [[UIPickerView alloc]init];
    self.pickerView = pickView;
    self.textView.inputView = pickView;
    
    pickView.dataSource = self;
    pickView.delegate = self;
    
    BIntervalTimeToolBar* toolBar = [BIntervalTimeToolBar toolBar];
    self.textView.inputAccessoryView = toolBar;
    
    toolBar.tbDelegate = self;
    
    // 默认选中 偏好设置的数据
    
    NSString* preStr = [BPreference intervalTimeType];
    int i = 0;
    for (i = 0; preStr && i < self.pickerData.count;) {
        if([preStr isEqualToString:self.pickerData[i]]) {
            break;
        }
        i++;
    }
    [pickView selectRow:i inComponent:0 animated:YES];
    
    // 弹出键盘
    [self.textView becomeFirstResponder];
}

- (void)didSelectIntervalType:(NSString*)typeStr {
    [BPreference setIntervalTimeType:typeStr];

    [[NSNotificationCenter defaultCenter]postNotificationName:BGPSIntervalTimeSelectedNotifcation object:nil];
}




@end

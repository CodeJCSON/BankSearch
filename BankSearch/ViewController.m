//
//  ViewController.m
//  BankSearch
//
//  Created by Guangdong Qi on 16/9/26.
//  Copyright © 2016年 Guangdong Qi. All rights reserved.
//

#import "ViewController.h"
#import "BankCardDataManager.h"

@interface ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    self.title = @"银行卡查询";
    [super viewDidLoad];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField.text.length > 0) {
        //遍历字典查找
        for (NSString * key in [BankCardDataManager shareManager].cardDataDict) {
            if ([textField.text hasPrefix:key]) {
                self.resultLabel.text = [BankCardDataManager shareManager].cardDataDict[key];
                break;
            }else{
                self.resultLabel.text = @"无结果";
            }
        }
    }
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

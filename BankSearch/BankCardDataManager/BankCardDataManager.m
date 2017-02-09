//
//  BankCardDataManager.m
//  BankSearch
//
//  Created by Guangdong Qi on 16/9/26.
//  Copyright © 2016年 Guangdong Qi. All rights reserved.
//

#import "BankCardDataManager.h"

@implementation BankCardDataManager

+ (BankCardDataManager *)shareManager{
    static BankCardDataManager* manager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        manager = [[[self class] alloc] init];
    });
    return manager;
}

-(instancetype)init
{
    if (self = [super init]) {
        
        _cardDataDict = [self cardDataDict];
    }
    
    return self;
}

- (NSDictionary *)cardDataDict
{
    if (!_cardDataDict) {
        
        NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                  NSUserDomainMask, YES) objectAtIndex:0];
        NSString *dataDictPath = [rootPath stringByAppendingPathComponent:@"GDCard_data_dict.plist"];
        
        //尝试使用card_data_dict.plist初始化字典，如果字典没有生成，直接遍历bank.text 并将结果保存为plist
        _cardDataDict = [NSDictionary dictionaryWithContentsOfFile:dataDictPath];
        if (!_cardDataDict) {
            _cardDataDict = [BankCardDataManager parseData];
            [self saveDataDict];
        }
    }
    
    return _cardDataDict;
}

- (void)saveDataDict
{
    if (!_cardDataDict) {
        NSLog(@"字典为空");
        return;
    }
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                              NSUserDomainMask, YES) objectAtIndex:0];
    
    
    NSString *dataDictPath = [rootPath stringByAppendingPathComponent:@"card_data_dict.plist"];
    [_cardDataDict writeToFile:dataDictPath atomically:NO];
    
    //生成.plist文件所在的地址
    [_cardDataDict writeToFile:@"/Users/daiyufasheng/Desktop/card_data_dict.plist" atomically:NO];
}

+ (NSDictionary *)parseData
{
    NSError * error;
    NSString * dataPath = [[NSBundle mainBundle] pathForResource:@"bank" ofType:@"txt"];
    NSString * dataString = [[NSString alloc] initWithContentsOfFile:dataPath encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"读取数据文件出错，错误代码：%@", error.domain);
        return nil;
    }
    
    if (!dataString.length) {
        NSLog(@"文件为空，查看是否有文件");
        return nil;
    }
    //使用换行分割字符串，将数据分割成行
    NSArray * lineArray = [dataString componentsSeparatedByString:@"\n"];
    
    //用字典保存
    NSMutableDictionary * dataDict = [NSMutableDictionary dictionary];
    
    for (NSString * lineString in lineArray) {
        
        NSArray * componentArray = [lineString componentsSeparatedByString:@"\""];
        
        if (componentArray.count == 5) {
            
            NSString * key = componentArray[1] ;
            NSString * value = componentArray[3];
            
            [dataDict setObject:value forKey:key];
        }else {
            NSLog(@"%@", lineString);
        }
    }
    
    return dataDict;
}
@end

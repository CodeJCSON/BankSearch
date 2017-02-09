//
//  BankCardDataManager.h
//  BankSearch
//
//  Created by Guangdong Qi on 16/9/26.
//  Copyright © 2016年 Guangdong Qi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BankCardDataManager : NSObject

+(BankCardDataManager *) shareManager;

@property (strong, nonatomic) NSDictionary * cardDataDict;

@end

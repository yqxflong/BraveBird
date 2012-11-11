//
//  BBPerference.h
//  BraveBird
//
//  Created by 尹 强 on 10/30/12.
//
//

#import <Foundation/Foundation.h>

@interface BBPerference : NSObject
@property (nonatomic,copy)NSString * name;
@property float score;
@property BOOL isGameOver;
+(BBPerference*)instance;
-(void)recordScore;
-(NSDictionary*)scoreList;
@end

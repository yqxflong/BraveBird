//
//  BBPerference.m
//  BraveBird
//
//  Created by 尹 强 on 10/30/12.
//
//

#import "BBPerference.h"

#define SCORELIST       [NSString stringWithFormat:@"%@/Documents/scorelist.plist",NSHomeDirectory()]

@implementation BBPerference
@synthesize name;
@synthesize score;
@synthesize isGameOver;
static BBPerference *instance=nil;
+(BBPerference*)instance{
    if (instance==nil) {
        instance=[[BBPerference alloc]init];
    }
    return instance;
}
//
-(void)dealloc{
    self.name=nil;
    [super dealloc];
}
//
-(void)recordScore{
    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithContentsOfFile:SCORELIST];
    if ([dic count]==0){
        dic=[NSMutableDictionary dictionary];
    }
    NSString *s=[NSString stringWithFormat:@"%.1f",score];
    [dic setValue:s forKey:name];
    [dic writeToFile:SCORELIST atomically:YES];
}
//
-(NSDictionary*)scoreList{
    NSDictionary *dic=[NSDictionary dictionaryWithContentsOfFile:SCORELIST];
    return dic;
}
@end

//
//  BBPerference.m
//  BraveBird
//
//  Created by 尹 强 on 10/30/12.
//
//

#import "BBPerference.h"

@implementation BBPerference
@synthesize score;
static BBPerference *instance=nil;
+(BBPerference*)instance{
    if (instance==nil) {
        instance=[[BBPerference alloc]init];
    }
    return instance;
}
//

@end

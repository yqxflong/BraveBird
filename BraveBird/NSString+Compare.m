//
//  NSString+Compare.m
//  BraveBird
//
//  Created by 尹 强 on 11/11/12.
//
//

#import "NSString+Compare.h"

@implementation NSString(CompareExtend)
-(NSComparisonResult)floatCompare:(NSString*)other
{
    float myValue = [self floatValue];
    float otherValue= [other floatValue];
    if(myValue == otherValue) return NSOrderedSame;
    return (myValue < otherValue ? NSOrderedDescending:NSOrderedAscending);
}
@end

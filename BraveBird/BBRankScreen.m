//
//  BBRankScreen.m
//  BraveBird
//
//  Created by 尹 强 on 11/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "BBRankScreen.h"
#import "NSString+Compare.h"
#import "BBFirstScene.h"

@implementation BBRankScreen
+(id)scene{
    CCScene *scene=[CCScene node];
    id node=[BBRankScreen node];
    [scene addChild:node];
    return scene;
}
//
-(id)init{
    if((self=[super init])){
        [self initRankList];
        [self initMenu];
    }
    return self;
}
//
-(void)initRankList{
    NSDictionary* list=[[BBPerference instance]scoreList];
    NSArray *arr=[list keysSortedByValueUsingSelector:@selector(floatCompare:)];
    float dis_rank=30.0f;
    int count=[arr count];
    //show name and score
    for (int i=0; i<5; i++) {
        if (count-1<i)break;
        NSString *name=[arr objectAtIndex:i];
        NSString *score=[list objectForKey:name];
        name=[self filtName:name];
        NSString *str=[NSString stringWithFormat:@"No.%-8d  %@   %8.1f",i+1,name,[score floatValue]];
        CCLabelTTF *tf=[CCLabelTTF labelWithString:str dimensions:DI_LB_RANK hAlignment:kCCTextAlignmentCenter fontName:FN_LB_RANK fontSize:FS_LB_RANK];
        tf.position=ccp(WINSIZE.width/2, WINSIZE.height-(dis_rank*i+100));
        [self addChild:tf z:1 tag:i];
    }
}
//
-(NSString*)filtName:(NSString*)name{
    int length=[name length];
    int num=8;
    if (length==num)
        return name;
    else if (length>num){
        name=[name substringToIndex:7];
        return name;
    }
    else{
        int rest=num-length;
        for (int i=0; i<rest; i++) {
            name=[name stringByAppendingString:@" "];
        }
        return name;
    }
}
//
-(void)initMenu{
    CGPoint po_item=CGPointMake(WINSIZE.width/2,50);
    CGSize  item_dimensions=CGSizeMake(100,50);
    //menu
    CCLabelTTF *lb_item=[CCLabelTTF labelWithString:MS_ITEM_AGAIN dimensions:item_dimensions hAlignment:kCCTextAlignmentCenter fontName:@"Marker Felt" fontSize:FS_ITEM_START];
    CCMenuItem *item=[CCMenuItemLabel itemWithLabel:lb_item block:^(id sender){
        [BBPerference instance].isGameOver=NO;
        CCTransitionSplitCols *tr=[CCTransitionSplitCols transitionWithDuration:3 scene:[BBFirstScene scene]];
        [[CCDirector sharedDirector]replaceScene:tr];
    }];
    CCMenu *menu=[CCMenu menuWithItems:item,nil];
    [menu alignItemsVertically];
    menu.position=po_item;
    [self addChild:menu];
}
@end

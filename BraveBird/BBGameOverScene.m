//
//  BBGameOverScene.m
//  BraveBird
//
//  Created by 尹 强 on 10/30/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "BBGameOverScene.h"
#import "BBFirstScene.h"
//
#define TAG_SCORE       10

@implementation BBGameOverScene
+(id)scene{
    CCScene *scene=[CCScene node];
    id node=[BBGameOverScene node];
    [scene addChild:node];
    return scene;
}
//
#pragma mark---------Initialize
-(id)init{
    if((self=[super init])){
        [self initScore];
        [self initItem];
    }
    return self;
}
//
-(void)initScore{
    NSString *score=[NSString stringWithFormat:@"TotalScore: %.1f",[BBPerference instance].score];
    CCLabelTTF *sb=[CCLabelTTF labelWithString:score dimensions:CGSizeMake(200, 100) hAlignment:kCCTextAlignmentCenter fontName:@"Marker Felt" fontSize:30];
    sb.position=CGPointMake(WINSIZE.width/2, WINSIZE.height/2);
    sb.color=ccWHITE;
    [self addChild:sb z:10 tag:TAG_SCORE];
}
//
-(void)initItem{
    CGPoint po_item_start=CGPointMake(WINSIZE.width/2,WINSIZE.height/2-90);
    CGSize  item_dimensions=CGSizeMake(100,50);
    //menu
    CCLabelTTF *lb_item_start=[CCLabelTTF labelWithString:MS_ITEM_AGAIN dimensions:item_dimensions hAlignment:kCCTextAlignmentCenter fontName:@"Marker Felt" fontSize:FS_ITEM_START];
    CCMenuItem *item_start=[CCMenuItemLabel itemWithLabel:lb_item_start block:^(id sender){
        CCTransitionSplitCols *tr=[CCTransitionSplitCols transitionWithDuration:3 scene:[BBFirstScene scene]];
        [[CCDirector sharedDirector]replaceScene:tr];
    }];
    CCMenu *menu=[CCMenu menuWithItems:item_start, nil];
    menu.position=po_item_start;
    [self addChild:menu];
}
@end

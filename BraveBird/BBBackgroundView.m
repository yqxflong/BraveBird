//
//  BBBackgroundView.m
//  BraveBird
//
//  Created by 尹 强 on 10/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "BBBackgroundView.h"
#import "Monster.h"
//
#define PIC_MONSTER     @"monster.png"
#define COUNT_MONSTER       2
//
@implementation BBBackgroundView
//
-(void)initMonsters{
    for (int i=0; i<COUNT_MONSTER;i++) {
        Monster *m=[Monster spriteWithFile:PIC_MONSTER];
        [self addChild:m z:1 tag:i];
    }
    [self refreshMonsters];
}
//
-(void)refreshMonsters{
    for (int i=0; i<COUNT_MONSTER;i++) {
        CCNode *node=[self getChildByTag:i];
        NSAssert([node isKindOfClass:[Monster class]],@"not a monster!!");
        Monster *m=(Monster*)node;
        [m setPosition:[self getMonsterPoint:m.contentSize]];
    }
}
//
-(CGPoint)getMonsterPoint:(CGSize)sz_m{
    CGSize bgSize=self.contentSize;
    float rangeX1=sz_m.width/2;
    float rangeX2=bgSize.width-sz_m.width/2;
    float rangeX=rangeX2-rangeX1;
    //
    float rangeY1=sz_m.width/2;
    float rangeY2=bgSize.height-sz_m.height/2;
    float rangeY=rangeY2-rangeY1;
    //
    float m_x=CCRANDOM_0_1()*rangeX;
    float m_y=CCRANDOM_0_1()*rangeY;
    return CGPointMake(m_x, m_y);
}
//
-(void)checkColision:(float)pl_r point:(CGPoint)pl_p autodis:(float)ad{
    for (int i=0; i<COUNT_MONSTER;i++){
        CCNode *node=[self getChildByTag:i];
        NSAssert([node isKindOfClass:[Monster class]],@"not a monster!!");
        Monster *m=(Monster*)node;
        if(self.position.x>WINSIZE.width/2) {
            [m checkColision:pl_r point:pl_p autodis:ad rest:self.position.x-WINSIZE.width/2];
        }else{
            [m checkColision:pl_r point:pl_p autodis:ad rest:0];
        }
        
    }
}
@end

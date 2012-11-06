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
@interface BBBackgroundView()
-(CGPoint)getMonsterPoint:(CGSize)sz_m;
@end
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
    float m_y=CCRANDOM_0_1()*(WINSIZE.height-sz_m.height)+sz_m.height*0.5;
    float m_x=CCRANDOM_0_1()*(WINSIZE.width-sz_m.width)+sz_m.width*0.5;
    return CGPointMake(m_x, m_y);
}
//
-(void)checkColision:(CCSprite*)player{
    for (int i=0; i<COUNT_MONSTER;i++){
        CCNode *node=[self getChildByTag:i];
        NSAssert([node isKindOfClass:[Monster class]],@"not a monster!!");
        Monster *m=(Monster*)node;
        float dis=self.position.x-WINSIZE.width/2;
        [m checkColision:player dis:dis];
    }
}
@end

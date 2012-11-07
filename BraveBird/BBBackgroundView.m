//
//  BBBackgroundView.m
//  BraveBird
//
//  Created by 尹 强 on 10/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "BBBackgroundView.h"
#import "Monster.h"
#import "BBHunter.h"
#import "Bullet.h"
//
#define PIC_MONSTER     @"monster.png"
#define PIC_HUNTER      @"hunter.png"
#define PIC_BULLET      @"bullet.png"
#define COUNT_MONSTER       1
//
#define TAG_HUNTER      200
#define TAG_BULLET      201
//
@interface BBBackgroundView()
-(CGPoint)getMonsterPoint:(CGSize)sz_m;
@end
//
@implementation BBBackgroundView
//
static const float bullet_race=20;
static CGRect hr;
-(void)initMonsters{
    //fly monster
    for (int i=0; i<COUNT_MONSTER;i++) {
        Monster *m=[Monster spriteWithFile:PIC_MONSTER];
        [self addChild:m z:1 tag:i];
    }
    [self refreshMonsters];
    //hunter
    BBHunter *h=[BBHunter spriteWithFile:PIC_HUNTER];
    [h setPosition:CGPointMake(380,h.contentSize.height/2)];
    [self addChild:h z:1 tag:TAG_HUNTER];
    hr=h.boundingBox;
    //
    [self initBullet];
}
//
-(void)refreshMonsters{
    for (int i=0; i<COUNT_MONSTER;i++) {
        CCNode *node=[self getChildByTag:i];
        NSAssert([node isKindOfClass:[Monster class]],@"not a monster!!");
        Monster *m=(Monster*)node;
        CGPoint p=[self getMonsterPoint:m.contentSize];
        p.x=p.x<WINSIZE.width/2?WINSIZE.width/2:p.x;
        p.y=p.y<WINSIZE.height/2?WINSIZE.height/2:p.y;
        [m setPosition:p];
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
    //check fly monster colision
    for (int i=0; i<COUNT_MONSTER;i++){
        CCNode *node=[self getChildByTag:i];
        NSAssert([node isKindOfClass:[Monster class]],@"not a monster!!");
        Monster *m=(Monster*)node;
        float dis=self.position.x-WINSIZE.width/2;
        [m checkColision:player dis:dis];
    }
    //check hunter colision
    CCNode *node=[self getChildByTag:TAG_HUNTER];
    NSAssert([node isKindOfClass:[BBHunter class]],@"not a hunter!!");
    BBHunter *m=(BBHunter*)node;
    float dis=self.position.x-WINSIZE.width/2;
    [m checkColision:player dis:dis];
    //
    [self updateBullet:player dis:dis];
}
//
-(void)initBullet{
    CCNode *node=[self getChildByTag:TAG_HUNTER];
    NSAssert([node isKindOfClass:[BBHunter class]],@"not a hunter!!");
    BBHunter *m=(BBHunter*)node;
    //hunter emit bullet
    Bullet *bullet=[Bullet spriteWithFile:PIC_BULLET];
    bullet.position=m.position;
    [self addChild:bullet z:0 tag:TAG_BULLET];
}
//
-(void)resetBullet{
    CCNode *node=[self getChildByTag:TAG_HUNTER];
    NSAssert([node isKindOfClass:[BBHunter class]],@"not a hunter!!");
    BBHunter *m=(BBHunter*)node;
    //
    CCNode *n=[self getChildByTag:TAG_BULLET];
    NSAssert([n isKindOfClass:[Bullet class]],@"not a bullet!!");
    Bullet *b=(Bullet*)n;
    b.position=m.position;
}
//
-(void)updateBullet:(CCSprite*)pl dis:(float)dis{
    if (self.position.x<=WINSIZE.width/2&&self.position.x>=-WINSIZE.width/2) {
        CCNode *n=[self getChildByTag:TAG_BULLET];
        NSAssert([n isKindOfClass:[Bullet class]],@"not a bullet!!");
        Bullet *b=(Bullet*)n;
        CGPoint p=b.position;
        b.position=ccp(p.x-=bullet_race,p.y+=bullet_race);
        //
        [b checkColision:pl dis:dis];
    }
}
@end

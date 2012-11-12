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
#define COUNT_MONSTER       5
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
static int monsterArr[16][2]={{530,590},{655,590},{780,590},{905,590},
    {530,445},{655,445},{780,445},{905,445},
    {530,310},{655,310},{780,310},{905,310},
    {530,175},{655,175},{780,175},{905,175}};
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
        [m setPosition:p];
    }
}
//
-(CGPoint)getMonsterPoint:(CGSize)sz_m{
    int rand=(int)(CCRANDOM_0_1()*16)%16;
    return CGPointMake(monsterArr[rand][0]/2,monsterArr[rand][1]/2);
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

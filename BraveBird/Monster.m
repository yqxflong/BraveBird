//
//  Monster.m
//  BraveBird
//
//  Created by 尹 强 on 10/28/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Monster.h"
#import "BBGameOverScene.h"
#import "AppDelegate.h"

@implementation Monster
//
-(void)checkColision:(CCSprite*)player dis:(float)dis{
    float pl_r=player.contentSize.height/2;
    CGPoint pl_p=player.position;
    CGSize m_sz=self.contentSize;
    float m_r=m_sz.height/2;
    float dis_limit=pl_r+m_r;
    //
    CGPoint m_p=self.position;
    m_p.x+=dis;//real position
    float dis_real=ccpDistance(m_p,pl_p);
    //
    if (dis_real<=dis_limit) {
        ((AppController*)[UIApplication sharedApplication].delegate).isGameOver=YES;
        //
        CCRotateBy *cr=[CCRotateBy actionWithDuration:0.5 angle:990.0];
        CCMoveTo *cm=[CCMoveTo actionWithDuration:0.5 position:CGPointMake(pl_p.x+50,pl_r)];
        CCSpawn *cp=[CCSpawn actions:cr,cm, nil];
        CCCallBlock *ca=[CCCallBlock actionWithBlock:^(){
            CCScene* go=[BBGameOverScene scene];
            [[CCDirector sharedDirector]replaceScene:go];
        }];
        [player runAction:cp];
        [player performSelector:@selector(runAction:) withObject:ca afterDelay:1];
    }
}
//
@end

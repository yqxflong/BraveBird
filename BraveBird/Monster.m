//
//  Monster.m
//  BraveBird
//
//  Created by 尹 强 on 10/28/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Monster.h"


@implementation Monster
//
-(void)checkColision:(float)pl_r point:(CGPoint)pl_p autodis:(float)ad rest:(float)rt{
    CGSize m_sz=self.contentSize;
    float m_r=sqrtf(m_sz.width*m_sz.width+m_sz.height*m_sz.height);
    float dis_limit=pl_r+m_r;
    //
    CGPoint m_p=self.position;
    m_p.x-=ad;//real position
    m_p.x+=rt;
    float dis_real=ccpDistance(m_p,pl_p);
    //
    if (dis_real<=dis_limit) {
//        [[CCDirector sharedDirector]pause];
        CCLOG(@"DIE!!!!!!!!!!!");
    }
}
@end

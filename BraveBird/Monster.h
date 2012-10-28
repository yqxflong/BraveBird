//
//  Monster.h
//  BraveBird
//
//  Created by 尹 强 on 10/28/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Monster : CCSprite {
    
}
-(void)checkColision:(float)pl_r point:(CGPoint)pl_p autodis:(float)ad rest:(float)rt;
@end

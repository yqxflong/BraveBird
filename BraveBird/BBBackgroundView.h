//
//  BBBackgroundView.h
//  BraveBird
//
//  Created by 尹 强 on 10/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface BBBackgroundView : CCSprite {
    
}
-(void)initMonsters;
-(void)refreshMonsters;
-(void)checkColision:(CCSprite*)player;
-(void)shotByHunter;
@end

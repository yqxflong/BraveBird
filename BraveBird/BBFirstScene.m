//
//  BBFirstScene.m
//  BraveBird
//

#import "BBFirstScene.h"
//
//
#define KEYROLE_BIRD            @"role-bird.png"
#define TAG_KEYROLE             1
#define RATE_UPDATE             0.1f
#define PLAYER_START_X          100
//
//
//
static const float race_player=30;
static BOOL keepDown=YES;

@implementation BBFirstScene
+(id)scene{
    CCScene *scene=[CCScene node];
    id node=[BBFirstScene node];
    [scene addChild:node];
    return scene;
}
//
-(id)init{
    if ((self=[super init])) {
        [self initPlayer];
        self.isTouchEnabled=YES;
    }
    return self;
}
//
-(void)initPlayer{
    CGPoint po_player=CGPointMake(PLAYER_START_X,WINSIZE.height/2);
    CCSprite *player=[CCSprite spriteWithFile:KEYROLE_BIRD];
    [player setPosition:po_player];
    [self addChild:player z:0 tag:TAG_KEYROLE];
}
//
#pragma mark-------Enter or leave
-(void)onEnterTransitionDidFinish{
    [super onEnterTransitionDidFinish];
    //
    //set timer
    [self schedule:@selector(updateAllTheTime:) interval:RATE_UPDATE];
}
//
#pragma mark--------Timer event
-(void)keepPlayerFly:(ccTime)delta{
    CCSprite *player=(CCSprite*)[self getChildByTag:TAG_KEYROLE];
    CGPoint po_player=player.position;
    CGSize sz_player=player.texture.contentSize;
    //
    if (po_player.y<WINSIZE.height-sz_player.height/2-race_player) {
        po_player.y+=race_player;
    }else{
        po_player.y=WINSIZE.height-sz_player.height/2;
    }
    //
    [player stopAllActions];
    CCMoveTo *cm=[CCMoveTo actionWithDuration:RATE_UPDATE position:po_player];
    [player runAction:cm];
    
}
//
-(void)keepPlayerDown:(ccTime)delta{
    if (!keepDown)return;
    CCSprite* player=(CCSprite*)[self getChildByTag:TAG_KEYROLE];
    CGPoint po_player=player.position;
    CGSize sz_player=player.texture.contentSize;
    //
    if (po_player.y>sz_player.height/2+race_player) {
        po_player.y-=race_player;
    }else{
        po_player.y=sz_player.height/2;
    }
    [player stopAllActions];
    CCMoveTo *cm=[CCMoveTo actionWithDuration:delta position:po_player];
    [player runAction:cm];
}
//
-(void)updateAllTheTime:(ccTime)delta{
    [self keepPlayerDown:delta];
}
//
//
#pragma mark---------Touch event
-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    CCLOG(@"touch begin");
    keepDown=NO;
    [self schedule:@selector(keepPlayerFly:) interval:RATE_UPDATE];
}
//
-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    CCLOG(@"touch move");
    keepDown=NO;
}
//
-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    CCLOG(@"touch end");
    keepDown=YES;
    [self unschedule:@selector(keepPlayerFly:)];
}
//
-(void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    CCLOG(@"touch cancel");
    keepDown=YES;
    [self unschedule:@selector(keepPlayerFly:)];
}

@end

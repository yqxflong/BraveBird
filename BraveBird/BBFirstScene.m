//
//  BBFirstScene.m
//  BraveBird
//

#import "BBFirstScene.h"
#import "BBBackgroundView.h"

//
//
#define PIC_NEARBG              @"bg-near.png"
#define PIC_FARBG               @"bg-far.png"
#define PIC_PLAYER              @"role-bird.png"

#define TAG_NEARBG              100
#define TAG_FARBG               101
#define TAG_KEYROLE             1
#define TAG_SCOREBOARD          50
//
#define RATE_UPDATE             0.1f
#define PLAYER_START_X          100
//
//
//
static const float a_f=500.0f;//a for up
static const float g=300.0f;//a for down
//
static float dis_forward=20;
static float race_down=40;
static float race_up=60;
static BOOL keepDown=YES;

@implementation BBFirstScene
+(id)scene{
    CCScene *scene=[CCScene node];
    id node=[BBFirstScene node];
    [scene addChild:node];
    return scene;
}
//
#pragma mark---------Initialize
-(id)init{
    if ((self=[super init])) {
        [self initBackgroundView];
        [self initPlayer];
        [self initScoreBoard];
        self.isTouchEnabled=YES;
    }
    return self;
}
//
-(void)initBackgroundView{
    BBBackgroundView *near=[BBBackgroundView spriteWithFile:PIC_NEARBG];
    [near setColor:ccBLACK];
    [self addChild:near z:-1 tag:TAG_NEARBG];
    //
    BBBackgroundView *far=[BBBackgroundView spriteWithFile:PIC_FARBG];
    [far setColor:ccBLACK];
    [self addChild:far z:-1 tag:TAG_FARBG];
    //
    CGPoint po_near=CGPointMake(WINSIZE.width/2,WINSIZE.height/2);
    near.position=po_near;
    CGPoint po_far=CGPointMake(WINSIZE.width+WINSIZE.width/2,WINSIZE.height/2);
    far.position=po_far;
    //
    [near initMonsters];
    [far initMonsters];
}
//
-(void)initPlayer{
    CGPoint po_player=CGPointMake(PLAYER_START_X,WINSIZE.height/2);
    CCSprite *player=[CCSprite spriteWithFile:PIC_PLAYER];
    [player setPosition:po_player];
    [self addChild:player z:0 tag:TAG_KEYROLE];
}
//
-(void)initScoreBoard{
    CCLabelTTF *sb=[CCLabelTTF labelWithString:@"0.0" dimensions:CGSizeMake(50, 50) hAlignment:kCCTextAlignmentCenter fontName:@"Marker Felt" fontSize:20];
    sb.color=ccYELLOW;
    sb.position=CGPointMake(WINSIZE.width-sb.contentSize.width/2,WINSIZE.height-sb.contentSize.height/2);
    [self addChild:sb z:50 tag:TAG_SCOREBOARD];
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
//keep plaer fly if press
-(void)keepPlayerFly:(ccTime)delta{
    CCSprite *player=(CCSprite*)[self getChildByTag:TAG_KEYROLE];
    CGPoint po_player=player.position;
    CGSize sz_player=player.texture.contentSize;
    //
    if (po_player.y<WINSIZE.height-sz_player.height/2-race_up*delta) {
        race_up+=a_f*delta;
        po_player.y+=race_up*delta;
    }else{
        race_up=0;
        po_player.y=WINSIZE.height-sz_player.height/2;
    }
    //
    [player stopAllActions];
    CCMoveTo *cm=[CCMoveTo actionWithDuration:RATE_UPDATE position:po_player];
    [player runAction:cm];
    
}
//keep player down if not press
-(void)keepPlayerDown:(ccTime)delta{
    if (!keepDown)return;
    CCSprite* player=(CCSprite*)[self getChildByTag:TAG_KEYROLE];
    CGPoint po_player=player.position;
    CGSize sz_player=player.texture.contentSize;
    //
    if (po_player.y>sz_player.height/2+race_down*delta) {
        race_down+=g*delta;
        po_player.y-=race_down*delta;
    }else{
        race_down=0;
        po_player.y=sz_player.height/2;
    }
    [player stopAllActions];
    CCMoveTo *cm=[CCMoveTo actionWithDuration:delta position:po_player];
    [player runAction:cm];
}
//keep bg view scroll all the time
-(void)scrollBackgroundView:(ccTime)delta{
    BBBackgroundView *near=(BBBackgroundView*)[self getChildByTag:TAG_NEARBG];
    BBBackgroundView *far=(BBBackgroundView*)[self getChildByTag:TAG_FARBG];
    //
    CGPoint po_near=near.position;
    CGPoint po_far=far.position;
    //check near bg
    po_near.x-=dis_forward;
    if (po_near.x<=-WINSIZE.width/2) {
        [near refreshMonsters];
        po_near.x=WINSIZE.width*3/2;
    }
    //check far bg
    po_far.x-=dis_forward;
    if (po_far.x<=-WINSIZE.width/2) {
        [far refreshMonsters];
        po_far.x=WINSIZE.width*3/2;
    }
    far.position=po_far;
    near.position=po_near;
}
//
-(void)checkColision{
    BBBackgroundView *near=(BBBackgroundView*)[self getChildByTag:TAG_NEARBG];
    BBBackgroundView *far=(BBBackgroundView*)[self getChildByTag:TAG_FARBG];
    //
    CCSprite* player=(CCSprite*)[self getChildByTag:TAG_KEYROLE];
    float rest_near=0;
    float rest_far=0;
    if (near.position.x==WINSIZE.width*3/2) {
        rest_near=WINSIZE.width;
    }
    if (far.position.x==WINSIZE.width*3/2) {
        rest_far=WINSIZE.width;
    }
    [near checkColision:player];
    [far checkColision:player];
}
//check any update all the time
-(void)updateAllTheTime:(ccTime)delta{
    [self scrollBackgroundView:delta];
    [self keepPlayerDown:delta];
    [self checkColision];
    [self updateScore];
}
//
-(void)updateScore{
    CCNode *node=(CCNode*)[self getChildByTag:TAG_SCOREBOARD];
    NSAssert([node isKindOfClass:[CCLabelTTF class]],@"not a label!!");
    CCLabelTTF *sb=(CCLabelTTF*)node;
    float curs=[sb.string floatValue];
    curs+=0.1;
    [BBPerference instance].score=curs;
    sb.string=[NSString stringWithFormat:@"%.1f",curs];
}
//
#pragma mark---------Touch event
-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    CCLOG(@"touch begin");
    keepDown=NO;
    race_up=0;
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
    race_down=0;
    [self unschedule:@selector(keepPlayerFly:)];
}
//
-(void)ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    CCLOG(@"touch cancel");
    keepDown=YES;
    race_down=0;
    [self unschedule:@selector(keepPlayerFly:)];
}

@end

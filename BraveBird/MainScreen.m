//
//  MainScreen.m
//  BraveBird
//

#import "MainScreen.h"
#import "BBFirstScene.h"
//
//
@implementation MainScreen
+(id)scene{
    CCScene *scene=[CCScene node];
    id node=[MainScreen node];
    [scene addChild:node];
    return scene;
}
//
-(id)init{
    if ((self=[super init])) {
        [self initTitle];
        [self initMenu];
    }
    return self;
}
//
-(void)initTitle{
    CGPoint po_lb_title=CGPointMake(WINSIZE.width/2,WINSIZE.height/2+50);
    CGSize lb_title_dimensions=CGSizeMake(200,50);
    //
    CCLabelTTF *lb_title=[CCLabelTTF labelWithString:MS_LB_TITLE dimensions:lb_title_dimensions hAlignment:kCCTextAlignmentCenter fontName:@"Marker Felt" fontSize:FS_LB_TITLE];
    lb_title.position=po_lb_title;
    [self addChild:lb_title];
}
//
-(void)initMenu{
    CGPoint po_item_start=CGPointMake(WINSIZE.width/2,WINSIZE.height/2-90);
    CGSize  item_dimensions=CGSizeMake(100,50);
    //menu
    CCLabelTTF *lb_item_start=[CCLabelTTF labelWithString:MS_ITEM_START dimensions:item_dimensions hAlignment:kCCTextAlignmentCenter fontName:@"Marker Felt" fontSize:FS_ITEM_START];
    CCMenuItem *item_start=[CCMenuItemLabel itemWithLabel:lb_item_start block:^(id sender){
        CCTransitionSplitCols *tr=[CCTransitionSplitCols transitionWithDuration:3 scene:[BBFirstScene scene]];
        [[CCDirector sharedDirector]replaceScene:tr];
    }];
    CCMenu *menu=[CCMenu menuWithItems:item_start, nil];
    menu.position=po_item_start;
    [self addChild:menu];
}
@end

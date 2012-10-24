//
//  MainScreen.m
//  BraveBird
//

#import "MainScreen.h"
#import "BBFirstScene.h"
//
//
#define FS_LB_TITLE         40



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
        CGSize size=[[CCDirector sharedDirector]winSize];
        //
        CGPoint po_lb_title=CGPointMake(size.height/2,size.width/2+50);
        CGSize lb_title_dimensions=CGSizeMake(200,50);
        //
        CGPoint po_item_start=CGPointMake(size.height/2,size.width/2-90);
        
        //title
        CCLabelTTF *lb_title=[CCLabelTTF labelWithString:MS_LB_TITLE dimensions:lb_title_dimensions hAlignment:kCCTextAlignmentCenter fontName:@"Marker Felt" fontSize:FS_LB_TITLE];
        lb_title.position=po_lb_title;
        [self addChild:lb_title];
        
        //menu btns
        CCLabelTTF *lb_item_start=[CCLabelTTF labelWithString:MS_ITEM_START dimensions:lb_title_dimensions hAlignment:kCCTextAlignmentCenter fontName:@"Marker Felt" fontSize:20];
        CCMenuItem *item_start=[CCMenuItemLabel itemWithLabel:lb_item_start block:^(id sender){
            CCTransitionRotoZoom *tr=[CCTransitionRotoZoom transitionWithDuration:5.0 scene:[BBFirstScene scene]];
            [[CCDirector sharedDirector]replaceScene:tr];
        }];
        CCMenu *menu=[CCMenu menuWithItems:item_start, nil];
        menu.position=po_item_start;
        [self addChild:menu];
    }
    return self;
}
@end

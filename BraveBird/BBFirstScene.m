//
//  BBFirstScene.m
//  BraveBird
//

#import "BBFirstScene.h"

@implementation BBFirstScene
+(id)scene{
    CCScene *scene=[CCScene node];
    id node=[BBFirstScene node];
    [scene addChild:node];
    return scene;
}

@end

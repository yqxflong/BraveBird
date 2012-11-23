//
//  NameScene.m
//  BraveBird
//
//  Created by 尹 强 on 11/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "NameScene.h"
#import "MainScreen.h"

@implementation NameScene
+(id)scene{
    CCScene *scene=[CCScene node];
    id node=[NameScene node];
    [scene addChild:node];
    return scene;
}
//
-(id)init{
    if ((self=[super init])) {
        [self initNameField];
    }
    return self;
}
//
-(void)initNameField{
    UITextField *tf=[[UITextField alloc]init];
    tf.delegate=self;
    tf.frame=CGRectMake(0, 0, 200, 50);
    tf.center=ccp(WINSIZE.height/2, WINSIZE.width/2-50);
    tf.textColor=[UIColor whiteColor];
    tf.textAlignment=UITextAlignmentCenter;
    tf.returnKeyType=UIReturnKeyDone;
    tf.borderStyle=UITextBorderStyleBezel;
    tf.text=[BBPerference instance].name?[BBPerference instance].name:@"Jack";
    [[[CCDirector sharedDirector]view]addSubview:tf];
    [tf release];
}
//
#pragma mark--
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [textField removeFromSuperview];
    [BBPerference instance].name=textField.text;
    [[CCDirector sharedDirector]replaceScene:[MainScreen scene]];
    return YES;
}
@end

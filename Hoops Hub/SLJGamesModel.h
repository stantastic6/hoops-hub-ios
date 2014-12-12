//
//  GameModel.h
//  Hoops Hub
//
//  Created by Stanley Jackson on 12/10/14.
//  Copyright (c) 2014 Stanley Jackson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLJGamesModel : NSObject

-(NSString *) getToday:(NSDate *)date;
- (void) dataHandler:(NSData *) responseData;
-(NSUInteger) numberOfGames;
-(NSDictionary *) gameAtIndex:(NSUInteger)index;
-(void) boxScoreForGame:(NSString *)game;
- (NSDictionary *) selectedBoxScore;
+ (instancetype) sharedModel;


@end

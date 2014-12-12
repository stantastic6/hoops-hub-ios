//
//  GameModel.m
//  Hoops Hub
//
//  Created by Stanley Jackson on 12/10/14.
//  Copyright (c) 2014 Stanley Jackson. All rights reserved.
//

#import "SLJGamesModel.h"

#define API_KEY @"cn82hghaq6yn3nuwy26r8ywx"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

//Filename for plist
NSString *const GamesPlist = @"games.plist";

@interface SLJGamesModel()
@property (nonatomic, strong) NSMutableData *responseData;
@property (strong, nonatomic) NSString *filepath;
@property (strong, nonatomic) NSMutableDictionary *plist;
@property (strong, nonatomic) NSMutableArray *todaysGames;
@property (strong, nonatomic) NSMutableDictionary *currentBoxScore;
@end


@implementation SLJGamesModel

- (id) init {
    self = [super init];
    if (self) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        _filepath = [documentsDirectory stringByAppendingPathComponent:GamesPlist];
        _plist = [NSMutableDictionary dictionaryWithContentsOfFile:_filepath];
    
    
    //Plist will be delete after runtime
    if(!_plist){
        _plist = [NSMutableDictionary dictionaryWithCapacity:16];
        //Set up the first API call
        NSString *today = [self getToday:[NSDate date]];
        NSString *requestString = [NSString stringWithFormat:@"http://api.sportsdatallc.org/nba-t3/games/%@/schedule.json?&api_key=%@", today, API_KEY];
        
        NSURL *request = [NSURL URLWithString:requestString];
        
        
        dispatch_async(kBgQueue, ^{
            NSData *data = [NSData dataWithContentsOfURL:request];
            [self performSelectorOnMainThread:@selector(dataHandler:) withObject:data waitUntilDone:YES];
        });
    
    }else{
        _todaysGames = [_plist objectForKey:@"Games"];
    }
    }
    return self;
}

+ (instancetype) sharedModel {
    static SLJGamesModel *_sharedModel = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        //thread safe execution
        _sharedModel = [[self alloc] init];
    });
    
    return _sharedModel;
}

- (NSString *) getToday:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
#warning "Date set to yesterday for demo purposes"
    NSString *today = [formatter stringFromDate:date];
    NSString *yesterday = @"2014/12/11";
    return yesterday;
}

- (void) dataHandler:(NSData *) responseData {
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    
    
    //Setup Array of dictonaries in plist
    [self.plist setObject:[json objectForKey:@"games"] forKey:@"Games"];
    [self.plist writeToFile:self.filepath atomically:YES];

}

-(NSUInteger) numberOfGames{
    return [_todaysGames count];
}

-(NSDictionary *) gameAtIndex:(NSUInteger)index{
    return self.todaysGames[index];
}


-(void) boxScoreForGame:(NSString *)gameID{
    NSString *requestString = [NSString stringWithFormat:@"http://api.sportsdatallc.org/nba-t3/games/%@/summary.json?api_key=%@", gameID, API_KEY];

    NSURL *request = [NSURL URLWithString:requestString];
    
    dispatch_async(kBgQueue, ^{
        NSData *data = [NSData dataWithContentsOfURL:request];
        [self performSelectorOnMainThread:@selector(boxHandler:) withObject:data waitUntilDone:YES];
    });
}

- (void) boxHandler:(NSData *) responseData {
    NSError *error;
    NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    _currentBoxScore = json;
}

- (NSDictionary *) selectedBoxScore{
    return self.currentBoxScore;
}



@end

//
//  SLJBoxScoreViewController.h
//  Hoops Hub
//
//  Created by Stanley Jackson on 12/11/14.
//  Copyright (c) 2014 Stanley Jackson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLJGamesModel.h"



@interface SLJBoxScoreViewController : UIViewController
@property (nonatomic, assign)NSInteger *gameIndex;



- (void) setupHomeStats:(NSDictionary *)team;
- (void) setupAwayStats:(NSDictionary *)team;
-(void) gameTime;
-(void) zeroBox;
@property (strong, nonatomic) IBOutlet UILabel *awayTeamLabel;
@property (strong, nonatomic) IBOutlet UIButton *awayButton;
@property (strong, nonatomic) IBOutlet UIButton *homeButton;
@property (strong, nonatomic) IBOutlet UILabel *awayQ1;
@property (strong, nonatomic) IBOutlet UILabel *awayQ2;
@property (strong, nonatomic) IBOutlet UILabel *awayQ3;
@property (strong, nonatomic) IBOutlet UILabel *awayQ4;
@property (strong, nonatomic) IBOutlet UILabel *awayF;
@property (strong, nonatomic) IBOutlet UILabel *homeTeamLabel;
@property (strong, nonatomic) IBOutlet UILabel *homeQ1;
@property (strong, nonatomic) IBOutlet UILabel *homeQ2;
@property (strong, nonatomic) IBOutlet UILabel *homeQ3;
@property (strong, nonatomic) IBOutlet UILabel *homeQ4;
@property (strong, nonatomic) IBOutlet UILabel *homeF;
@property (strong, nonatomic) IBOutlet UILabel *clockLabel;

@property (strong, nonatomic) IBOutlet UILabel *away;
@property (strong, nonatomic) IBOutlet UILabel *home;


@property (strong, nonatomic) IBOutlet UILabel *awayFG;
@property (strong, nonatomic) IBOutlet UILabel *away3P;
@property (strong, nonatomic) IBOutlet UILabel *awayFT;
@property (strong, nonatomic) IBOutlet UILabel *awayAST;
@property (strong, nonatomic) IBOutlet UILabel *awaySTL;
@property (strong, nonatomic) IBOutlet UILabel *awayBLK;
@property (strong, nonatomic) IBOutlet UILabel *awayREB;
@property (strong, nonatomic) IBOutlet UILabel *awayTO;

@property (strong, nonatomic) IBOutlet UILabel *homeFG;
@property (strong, nonatomic) IBOutlet UILabel *home3P;
@property (strong, nonatomic) IBOutlet UILabel *homeFT;
@property (strong, nonatomic) IBOutlet UILabel *homeAST;
@property (strong, nonatomic) IBOutlet UILabel *homeSTL;
@property (strong, nonatomic) IBOutlet UILabel *homeBLK;
@property (strong, nonatomic) IBOutlet UILabel *homeREB;
@property (strong, nonatomic) IBOutlet UILabel *homeTO;
@property (strong, nonatomic) IBOutlet UILabel *noticeLabel;

@end

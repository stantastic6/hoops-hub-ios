//
//  SLJBoxScoreViewController.m
//  Hoops Hub
//
//  Created by Stanley Jackson on 12/11/14.
//  Copyright (c) 2014 Stanley Jackson. All rights reserved.
//

#import "SLJBoxScoreViewController.h"


@interface SLJBoxScoreViewController ()
@property (strong, nonatomic) SLJGamesModel *model;
@property (strong, nonatomic) NSDictionary *homeTeam;
@property (strong, nonatomic) NSDictionary *awayTeam;
@property (strong, nonatomic) NSString *gameStatus;
@property (strong, nonatomic) IBOutlet UINavigationItem *boxTitle;

@end

int currentQuarter;

@implementation SLJBoxScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.model = [SLJGamesModel sharedModel];
    
    [self.model boxScoreForGame:[[self.model gameAtIndex:(NSInteger)self.gameIndex] objectForKey:@"id"]];
    
    self.gameStatus = [[self.model selectedBoxScore]objectForKey:@"status"];
    
    
    NSString *homeTeamName = [[[self.model selectedBoxScore]objectForKey:@"home"]objectForKey:@"name"];
    NSString *awayTeamName = [[[self.model selectedBoxScore]objectForKey:@"away"]objectForKey:@"name"];
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@ At %@", awayTeamName, homeTeamName];
    
    //Game is complete of in Progess
    if (![self.gameStatus isEqualToString:@"scheduled"]) {

        [self gameTime];
        [self setupHomeStats:[[self.model selectedBoxScore]objectForKey:@"home"]];
        [self setupAwayStats:[[self.model selectedBoxScore]objectForKey:@"away"]];
    
    }else if ([self.gameStatus isEqualToString:@"scheduled"]){
    //If the game hasn't started yet:
    //Zero out box Score
        [self zeroBox];
        self.navigationItem.title = [NSString stringWithFormat:@""];
    }
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self becomeFirstResponder];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) gameTime{
    
    currentQuarter = [[[self.model selectedBoxScore]objectForKey:@"quarter"]integerValue];
    
    if ([self.gameStatus isEqual: @"closed"] || [self.gameStatus isEqual: @"complete"]) {
        NSString *progress = @"Final";
        if (currentQuarter > 4) {
            self.clockLabel.text = [NSString stringWithFormat:@"%@ OT", progress];
        }else if (currentQuarter == 4){
            self.clockLabel.text = progress;
        }
    }else if ([self.gameStatus isEqual:@"inprogress"]){
        switch (currentQuarter) {
            case 1:
                self.clockLabel.text = @"1st Quarter";
                break;
            case 2:
                self.clockLabel.text = @"2nd Quarter";
                break;
            case 3:
                self.clockLabel.text = @"3rd Quarter";
                break;
            case 4:
                self.clockLabel.text = @"4th Quarter";
                break;
            default:
                break;
        }
    }
}

-(void) setupHomeStats:(NSDictionary *)team{
    NSArray *boxScores = [team objectForKey:@"scoring"];

    NSDictionary *teamStats = [team objectForKey:@"statistics"];

    self.home.text = [team objectForKey:@"name"];
    self.homeTeamLabel.text = [NSString stringWithFormat:@"%@ %@",[team objectForKey:@"market"],[team objectForKey:@"name"]];
    self.homeQ1.text = [[[boxScores objectAtIndex:0]objectForKey:@"points"]stringValue];
    self.homeQ2.text = [[[boxScores objectAtIndex:1]objectForKey:@"points"]stringValue];
    self.homeQ3.text = [[[boxScores objectAtIndex:2]objectForKey:@"points"]stringValue];
    self.homeQ4.text = [[[boxScores objectAtIndex:3]objectForKey:@"points"]stringValue];
    self.homeF.text = [[team objectForKey:@"points"]stringValue];
    
    self.homeFG.text = [NSString stringWithFormat:@"%@-%@ (%@)",[teamStats objectForKey:@"field_goals_made"], [teamStats objectForKey:@"field_goals_att"],[teamStats objectForKey:@"field_goals_pct"]];
    self.home3P.text = [NSString stringWithFormat:@"%@-%@ (%@)",[teamStats objectForKey:@"three_points_made"], [teamStats objectForKey:@"three_points_att"],[teamStats objectForKey:@"three_points_pct"]];
    self.homeFT.text = [NSString stringWithFormat:@"%@-%@ (%@)",[teamStats objectForKey:@"free_throws_made"], [teamStats objectForKey:@"free_throws_att"],[teamStats objectForKey:@"free_throws_pct"]];
    self.homeAST.text = [NSString stringWithFormat:@"%@", [teamStats objectForKey:@"assists"]];
    self.homeSTL.text = [NSString stringWithFormat:@"%@", [teamStats objectForKey:@"steals"]];
    self.homeBLK.text = [NSString stringWithFormat:@"%@", [teamStats objectForKey:@"blocks"]];
    self.homeREB.text = [NSString stringWithFormat:@"%@", [teamStats objectForKey:@"rebounds"]];
    self.homeTO.text = [NSString stringWithFormat:@"%@", [teamStats objectForKey:@"turnovers"]];
}

-(void) setupAwayStats:(NSDictionary *)team{

    NSArray *boxScores = [team objectForKey:@"scoring"];
    NSDictionary *teamStats = [team objectForKey:@"statistics"];
    
    self.away.text = [team objectForKey:@"name"];
    self.awayTeamLabel.text = [NSString stringWithFormat:@"%@ %@",[team objectForKey:@"market"],[team objectForKey:@"name"]];
    self.awayQ1.text = [[[boxScores objectAtIndex:0]objectForKey:@"points"]stringValue];
    self.awayQ2.text = [[[boxScores objectAtIndex:1]objectForKey:@"points"]stringValue];
    self.awayQ3.text = [[[boxScores objectAtIndex:2]objectForKey:@"points"]stringValue];
    self.awayQ4.text = [[[boxScores objectAtIndex:3]objectForKey:@"points"]stringValue];
    self.awayF.text = [[team objectForKey:@"points"]stringValue];
    
    self.awayFG.text = [NSString stringWithFormat:@"%@-%@ (%@)",[teamStats objectForKey:@"field_goals_made"], [teamStats objectForKey:@"field_goals_att"],[teamStats objectForKey:@"field_goals_pct"]];
    self.away3P.text = [NSString stringWithFormat:@"%@-%@ (%@)",[teamStats objectForKey:@"three_points_made"], [teamStats objectForKey:@"three_points_att"],[teamStats objectForKey:@"three_points_pct"]];
    self.awayFT.text = [NSString stringWithFormat:@"%@-%@ (%@)",[teamStats objectForKey:@"free_throws_made"], [teamStats objectForKey:@"free_throws_att"],[teamStats objectForKey:@"free_throws_pct"]];
    self.awayAST.text = [NSString stringWithFormat:@"%@", [teamStats objectForKey:@"assists"]];
    self.awaySTL.text = [NSString stringWithFormat:@"%@", [teamStats objectForKey:@"steals"]];
    self.awayBLK.text = [NSString stringWithFormat:@"%@", [teamStats objectForKey:@"blocks"]];
    self.awayREB.text = [NSString stringWithFormat:@"%@", [teamStats objectForKey:@"rebounds"]];
    self.awayTO.text = [NSString stringWithFormat:@"%@", [teamStats objectForKey:@"turnovers"]];
}


-(void) zeroBox{
    self.homeQ1.text = [NSString stringWithFormat:@"0"];
    self.homeQ2.text = [NSString stringWithFormat:@"0"];
    self.homeQ3.text = [NSString stringWithFormat:@"0"];
    self.homeQ4.text = [NSString stringWithFormat:@"0"];
    self.awayQ1.text = [NSString stringWithFormat:@"0"];
    self.awayQ2.text = [NSString stringWithFormat:@"0"];
    self.awayQ3.text = [NSString stringWithFormat:@"0"];
    self.awayQ4.text = [NSString stringWithFormat:@"0"];
    
    self.noticeLabel.text = [NSString stringWithFormat:@"This game has yet to tip-off"];
    
}
@end

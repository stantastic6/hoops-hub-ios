//
//  SLJScheduleTableViewCell.h
//  Hoops Hub
//
//  Created by Stanley Jackson on 12/11/14.
//  Copyright (c) 2014 Stanley Jackson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLJScheduleTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *awayLabel;
@property (strong, nonatomic) IBOutlet UIImageView *awayImage;
@property (strong, nonatomic) IBOutlet UILabel *homeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *homeImage;
-(void) setupCell:(NSDictionary *) game;
@end

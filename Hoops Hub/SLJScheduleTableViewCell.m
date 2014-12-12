//
//  SLJScheduleTableViewCell.m
//  Hoops Hub
//
//  Created by Stanley Jackson on 12/11/14.
//  Copyright (c) 2014 Stanley Jackson. All rights reserved.
//

#import "SLJScheduleTableViewCell.h"

@implementation SLJScheduleTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setupCell:(NSDictionary *) game{
    
    NSString *awayLogoName = [[game objectForKey:@"away"]objectForKey:@"alias"];
    self.awayLabel.text = [[game objectForKey:@"away"]objectForKey:@"name"];
    self.awayImage.image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:awayLogoName ofType:@"gif"]];
    
    NSString *homeLogoName = [[game objectForKey:@"home"]objectForKey:@"alias"];
    self.homeLabel.text = [[game objectForKey:@"home"]objectForKey:@"name"];
    self.homeImage.image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:homeLogoName ofType:@"gif"]];
}

@end

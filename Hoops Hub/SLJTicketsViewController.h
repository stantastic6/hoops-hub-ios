//
//  SLJTicketsViewController.h
//  Hoops Hub
//
//  Created by Stanley Jackson on 12/11/14.
//  Copyright (c) 2014 Stanley Jackson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>



@interface SLJTicketsViewController : UIViewController <UITextFieldDelegate, MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *ticketInputField;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

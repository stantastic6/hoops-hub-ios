//
//  SLJTicketsViewController.m
//  Hoops Hub
//
//  Created by Stanley Jackson on 12/11/14.
//  Copyright (c) 2014 Stanley Jackson. All rights reserved.
//

#import "SLJTicketsViewController.h"


#define METERS_PER_MILE 1609.344

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface SLJTicketsViewController ()
@property (strong, nonatomic) NSMutableArray *events;
@property (strong, nonatomic) NSString *ticketLink;
@property double lat;
@property double lon;
@end

@implementation SLJTicketsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.ticketInputField.delegate = self;
    self.mapView.delegate = self;
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 34.0029139;
    zoomLocation.longitude = -118.4204;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    
    [_mapView setRegion:viewRegion animated:YES];

}



//Search when search button is pressed
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    NSString *requestString = [NSString stringWithFormat:@"http://api.seatgeek.com/2/events?taxonomies.name=basketball&sort=datetime_local.asc&q=%@", self.ticketInputField.text];
    requestString = [requestString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *request = [NSURL URLWithString:requestString];
    
    dispatch_async(kBgQueue, ^{
        NSData *data = [NSData dataWithContentsOfURL:request];
        [self performSelectorOnMainThread:@selector(dataHandler:) withObject:data waitUntilDone:YES];
    });
    
    return YES;
}


- (void) dataHandler:(NSData *) responseData {
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
   
    
    _events = [json objectForKey:@"events"];

    if ([_events count] == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Event Not Found"
                                                       message:@"I could not find the team or city you are looking for."
                                                      delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alert show];
    }else{
    
    CLLocationCoordinate2D zoomLocation;
    self.lat = [[[[[_events objectAtIndex:0] objectForKey:@"venue"] objectForKey:@"location"] objectForKey:@"lat"]doubleValue];
    self.lon = [[[[[_events objectAtIndex:0] objectForKey:@"venue"] objectForKey:@"location"] objectForKey:@"lon"]doubleValue];
    
    zoomLocation.latitude = self.lat;
    zoomLocation.longitude = self.lon;
    
    self.ticketLink = [[_events objectAtIndex:0] objectForKey:@"url"];
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    [_mapView setRegion:viewRegion animated:YES];
 
    
    
    // PLOT MARKER HERE
    NSDictionary *upcomingGame = [_events objectAtIndex:0];
    NSString *eventName = [upcomingGame objectForKey:@"title"];
    NSString *arena =[[upcomingGame objectForKey:@"venue"]objectForKey:@"name"];
 
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:zoomLocation.latitude longitude:zoomLocation.longitude];
    point.coordinate = location.coordinate;

    point.title = eventName;
    point.subtitle = [NSString stringWithFormat:@"%@", arena];

    [self.mapView addAnnotation:point];

    }
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

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    // if its the user location, just return nil
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // Try to dequeue an existing pin view first
    static NSString *AnnotationIdentifier =@"AnnotationIdentifier";
    MKPinAnnotationView *pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
    pinView.pinColor = MKPinAnnotationColorGreen;
    pinView.animatesDrop = YES;
    pinView.canShowCallout = YES;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeInfoLight];

    pinView.rightCalloutAccessoryView = rightButton;
    
    
    
    return pinView;
}


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.ticketLink]];
}
@end

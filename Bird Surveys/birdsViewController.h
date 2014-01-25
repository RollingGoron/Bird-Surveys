//
//  birdsViewController.h
//  Bird Surveys
//
//  Created by Peter Gosling on 1/6/14.
//  Copyright (c) 2014 Peter Gosling. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>



@interface birdsViewController : UIViewController

{
    //Variables and Pointers for Use
    AVAudioPlayer *audioPlayer;
    IBOutlet UIProgressView *progressBar;
    NSTimer *songTimer;
    IBOutlet UISegmentedControl *segmentedControl;
    NSURL *songFile;
    float songLength;
    IBOutlet UILabel *birdLabel;
    NSMutableArray *birdLocation;
    CLLocationManager *locationManager;
    IBOutlet UILabel *locationsCoordinates;
    NSArray *arrayOfLocations;
    BOOL locationActive;
    

    
}

//Actions and Methods
-(IBAction)startAudio;
-(IBAction)stopAudio;
-(void)audioLengthTimer;
-(IBAction)segmentedControlChange;
-(IBAction)getLocation:(UIButton*)sender;
-(IBAction)dumpArray;






//Instance Variables
@property NSNumber *latitude;
@property NSNumber *longitude;


@end

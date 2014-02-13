//
//  birdsViewController.m
//  Bird Surveys
//
//  Created by Peter Gosling on 1/6/14.
//  Copyright (c) 2014 Peter Gosling. All rights reserved.
//

#import "birdsViewController.h"

@interface birdsViewController ()

@end

@implementation birdsViewController

@synthesize latitude;
@synthesize longitude;
@synthesize getLocationButton;
@synthesize managedObjectContext;



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Clear progressBar
    [progressBar setProgress:0];
    

    //Get audio file length for progressBar
    AVURLAsset  *audioAsset = [AVURLAsset URLAssetWithURL:songFile options:nil];
    CMTime audioDuration = audioAsset.duration;
    
    //Create song file path
    songFile = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/SWFL.mp3", [[NSBundle mainBundle] resourcePath]]];
    
    songLength = CMTimeGetSeconds(audioDuration);
        
    NSLog(@"%f", songLength);
    locationManager = [[CLLocationManager alloc] init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//Method for NSTimer/Fills Progress Bar
-(void)audioLengthTimer {
    
    float time = 1/songLength;
    
    if (progressBar.progress == songLength) {
        NSLog(@"Finished");
    }
    else {
        [progressBar setProgress:progressBar.progress + time];
    }
}

-(IBAction)startAudio {
    
    NSError *error;
    
    //Connect AVAudioPlayer to song path
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:songFile error:&error];
    audioPlayer.numberOfLoops = 0;
    

    
    
    //Get audio file length for progressBar
    AVURLAsset  *audioAsset = [AVURLAsset URLAssetWithURL:songFile options:nil];
    CMTime audioDuration = audioAsset.duration;
    songLength = CMTimeGetSeconds(audioDuration);
    NSLog(@"%f", songLength);

    songTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(audioLengthTimer) userInfo:nil repeats:YES];
    

    //Play Audio
    [audioPlayer play];
    NSLog(@"Playing Audio");

}
-(IBAction)stopAudio {
    //Stop Audio
    [progressBar setProgress:0.0];
    [audioPlayer stop];
    [songTimer invalidate];
}

-(IBAction)segmentedControlChange {
    
    if (segmentedControl.selectedSegmentIndex == 0) {
        birdLabel.text = @"Southwestern Willow Flycatcher";
        //Create song file path
        songFile = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/SWFL.mp3", [[NSBundle mainBundle] resourcePath]]];
    }
    else
    {
        birdLabel.text = @"Yellow Billed Cuckoo";
        //Create Song File
        songFile = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/ybcu.mp3", [[NSBundle mainBundle] resourcePath]]];
    }
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    //Assigns a global pointer for the "Locations" obtained from locationManager
    
    arrayOfLocations = locations;
    
    //Set the BOOL test to true
    locationActive = TRUE;
    
    
    //This continuously updates the locationManager collecting multiple data points
    
    
    CLLocation *location = [arrayOfLocations lastObject];
    NSLog(@"Latitude: %f - Longitude: %f", location.coordinate.latitude, location.coordinate.longitude);
    NSString *coordinateLocations = [arrayOfLocations componentsJoinedByString:@"\n"];
    locationsCoordinates.text = coordinateLocations;

}

-(IBAction)getLocation:(UIBarButtonItem*)sender {
    locationManager.delegate = self;
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locationManager startUpdatingLocation];
    getLocationButton.title = [NSString stringWithFormat:@"Stop"];

    if (locationActive == TRUE) {
        [locationManager stopUpdatingLocation];
        getLocationButton.title = [NSString stringWithFormat:@"Get Location"];
        locationActive = FALSE;
        
    }
    
   
                                   
    //This code will allow the location to be updated once
    /*
    CLLocation *location = [arrayOfLocations lastObject];
    NSString *coordinateLocations = [arrayOfLocations componentsJoinedByString:@"\n"];
    NSLog(@"lat %f - lon %f", location.coordinate.latitude, location.coordinate.longitude);
    locationsCoordinates.text = coordinateLocations;
    [sender setTitle:@"Stop" forState:UIControlStateNormal]; 
    */
    
}

-(IBAction)dumpArray{
    NSLog(@"%@", arrayOfLocations);
}



@end

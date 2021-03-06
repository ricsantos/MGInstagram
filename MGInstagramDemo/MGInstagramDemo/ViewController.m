//
//  ViewController.m
//  MGInstagramDemo
//
//  Created by Mark Glagola on 10/20/12.
//  Copyright (c) 2012 Mark Glagola. All rights reserved.
//

#import "ViewController.h"
#import "MGInstagram.h"

@interface ViewController ()

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) MGInstagram *instagram;

- (IBAction)post612InstagramPressed:(id)sender;
- (IBAction)post1024InstagramPressed:(id)sender;

- (IBAction)incorrectlyPost302InstagramPressed:(id)sender;
- (IBAction)correctlyPost302InstagramPressed:(id)sender;

- (IBAction)postWithCaptionPressed:(id)sender;
@end

@implementation ViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.instagram = [MGInstagram new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.contentSize = self.scrollView.frame.size;
}

- (UIAlertView*) notInstalledAlert {
    return [[UIAlertView alloc] initWithTitle:@"Instagram Not Installed!" message:@"Instagram must be installed on the device in order to post images" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
}

- (void) postInstagramImage:(UIImage*) image {
    if ([MGInstagram isAppInstalled]) {
        [self.instagram postImage:image inView:self.view];
    } else {
        [self.notInstalledAlert show];
    }
}

- (IBAction)post612InstagramPressed:(id)sender {
    UIImage *image = [UIImage imageNamed:@"MGInstagramPhoto"];
    [self postInstagramImage:image];
}
- (IBAction)post1024InstagramPressed:(id)sender {
    UIImage *image = [UIImage imageNamed:@"MGInstagramPhotoLarge"];
    [self postInstagramImage:image];
}

- (IBAction)postToAllServicesPressed:(id)sender {
    UIImage *image = [UIImage imageNamed:@"MGInstagramPhotoLarge"];
    [self.instagram setPhotoFileName:@"tempphoto.png"];
    [self postInstagramImage:image];
    [self.instagram setPhotoFileName:kInstagramOnlyPhotoFileName];
}

- (IBAction)incorrectlyPost302InstagramPressed:(id)sender {
    //BAD PRACTICE (No size detection)
    UIImage *image = [UIImage imageNamed:@"MGInstagramPhotoSmall"];
    [self postInstagramImage:image];
}
- (IBAction)correctlyPost302InstagramPressed:(id)sender {
    UIImage *image = [UIImage imageNamed:@"MGInstagramPhotoSmall"];
    if ([MGInstagram isImageCorrectSize:image]) //GOOD PRACTICE (Size detection)
        [self postInstagramImage:image];
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Image TOO SMALL" message:@"Images must be 612x612 or larger to be posted on instagram" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)postWithCaptionPressed:(id)sender {
    UIImage *image = [UIImage imageNamed:@"MGInstagramPhoto"];
    if ([MGInstagram isAppInstalled]) {
        [self.instagram postImage:image withCaption:@"This is an #MGInstagram Test" inView:self.view];
    } else {
        [self.notInstalledAlert show];
    }
}

@end

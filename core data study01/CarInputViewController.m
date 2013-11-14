//
//  CarInputViewController.m
//  core data study01
//
//  Created by sungwook on 09/09/2013.
//  Copyright (c) 2013 sungwook. All rights reserved.
//

#import "CarInputViewController.h"
#import "Car.h"
#import "NBAppDelegate.h"
@import MobileCoreServices;

@interface CarInputViewController ()

@end

@implementation CarInputViewController
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NBAppDelegate * appDelegate=[[UIApplication sharedApplication] delegate];
    
    _managedObjectContext=[appDelegate managedObjectContext];
    //self.imagePreview_imageView=nil;
    self.storedImage=nil;
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)AddACar:(id)sender {
    
    // When no picture was taken there,
    if(self.storedImage==nil) {
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"You didn't choose any picture so I'm looking into your Photo Library" delegate:self cancelButtonTitle:@"Done"otherButtonTitles:nil];
        [alertView show];
        
        [self choosePicture:sender];
        
    } else {
        
        Car * aCar=[NSEntityDescription insertNewObjectForEntityForName:@"Car" inManagedObjectContext:self.managedObjectContext];
        
        aCar.maker=self.makerTextField.text;
        aCar.model_name=self.model_nameTextfield.text;
        aCar.mpg=[NSNumber numberWithFloat:[self.mpgTextField.text floatValue]];
        aCar.picture=UIImagePNGRepresentation(self.storedImage);
        
        NSError *err=nil;
        
        
        
        if(![self.managedObjectContext save:&err]) {
            
            /// error handling here...
            
        }
    }
    
    
}


- (IBAction)shotPicture:(id)sender {
    
    UIImagePickerController * shootPicture=[[UIImagePickerController alloc] init];
    shootPicture.delegate=self;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]==NO || [UIImagePickerController isCameraDeviceAvailable:(UIImagePickerControllerCameraDeviceRear)]==NO) {
        
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"This device have no camera!" delegate:self cancelButtonTitle:@"Done"otherButtonTitles:nil];
        [alertView show];
    }
    
//    id someClass=objc_getClass("dfd");
    
    shootPicture.sourceType=UIImagePickerControllerSourceTypeCamera;
    shootPicture.mediaTypes=[NSArray arrayWithObject:(NSString *)kUTTypeImage];
    shootPicture.cameraDevice=UIImagePickerControllerCameraDeviceRear;
    shootPicture.cameraCaptureMode=UIImagePickerControllerCameraCaptureModePhoto;
    shootPicture.cameraFlashMode=UIImagePickerControllerCameraFlashModeAuto;
    
    self.modeOfGettingPicture=TAKE_PICTURE;
    
    [self presentViewController:shootPicture animated:YES completion:^{}];
    
}


- (IBAction)choosePicture:(id)sender {
    UIImagePickerController * imagePickerController=[[UIImagePickerController alloc] init];
    imagePickerController.delegate=self; // conforming to UIImagePickerControllerDelegate,UINavigationControllerDelegate
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        imagePickerController.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    else {
        imagePickerController.sourceType=UIImagePickerControllerSourceTypeCamera;
    }
    
    NSArray * sourcetypes=[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    NSSet * soucetypes_inset=[NSSet setWithArray:sourcetypes];
    
    if(![soucetypes_inset containsObject:(NSString*)kUTTypeImage]) {
        imagePickerController.sourceType=UIImagePickerControllerSourceTypeCamera;
    }
    
    self.modeOfGettingPicture=CHOOSE_PICTURE;
    
    [self presentViewController:imagePickerController animated:YES completion:^{}];
    
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
 
    self.storedImage=[info valueForKey:UIImagePickerControllerOriginalImage];
    
    if(self.modeOfGettingPicture == CHOOSE_PICTURE) {
        

        

    } else if(self.modeOfGettingPicture == TAKE_PICTURE) {
        

    //TODO: Rotate the image captured by M_PI/2
        
    }
    

    self.imagePreview_imageView.contentMode=UIViewContentModeScaleAspectFit;
    
    self.imagePreview_imageView.image=self.storedImage;
    [picker dismissViewControllerAnimated:YES completion:^{}];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;

}

- (IBAction)unHide:(id)sender {
    
    [self resignFirstResponder_toAllTextFields];
    
}



-(void)resignFirstResponder_toAllTextFields {
    
    for( UIView * aView in [self.view subviews]) {
        if([aView isKindOfClass:[UITextField class]]) {
            [aView resignFirstResponder];
        }
    }
}



@end

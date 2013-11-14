//
//  CarInputViewController.h
//  core data study01
//
//  Created by sungwook on 09/09/2013.
//  Copyright (c) 2013 sungwook. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CarInputViewController : UIViewController <UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (weak, nonatomic) IBOutlet UITextField *makerTextField;
@property (weak, nonatomic) IBOutlet UITextField *model_nameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *mpgTextField;
- (IBAction)AddACar:(id)sender;
- (IBAction)choosePicture:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imagePreview_imageView;
@property (strong, nonatomic) UIImage * storedImage;
- (IBAction)shotPicture:(id)sender;

@property (assign, nonatomic) enum modeOfGettingPicture_enum {
            TAKE_PICTURE
            , CHOOSE_PICTURE }
            modeOfGettingPicture;

- (IBAction)unHide:(id)sender;

@end

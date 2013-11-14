//
//  CarListTableViewController.m
//  core data study01
//
//  Created by sungwook on 09/09/2013.
//  Copyright (c) 2013 sungwook. All rights reserved.
//

#import "CarListTableViewController.h"
#import "Car.h"
#import "NBAppDelegate.h"
#import "EnlargedTableViewController.h"


@interface CarListTableViewController ()

@end

@implementation CarListTableViewController
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize cars;




- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.readingCoreData=dispatch_queue_create("com.sungwook.study01.readingCoreData", DISPATCH_QUEUE_CONCURRENT);
    self.reading_aCell=dispatch_queue_create("com.sungwook.study01.reading_aCell", DISPATCH_QUEUE_CONCURRENT);
    self.reading_aImage_in_aCell=dispatch_queue_create("com.sungwook.study01.reading_aImage_in_aCell", DISPATCH_QUEUE_CONCURRENT);
    //self.reading_aImage_in_aCell=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);  // still slow in performance.
    
    
    _managedObjectContext=[(NBAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    NSFetchRequest * fetchRequest=[[NSFetchRequest alloc] init];
    
    NSEntityDescription * anEntity=[NSEntityDescription entityForName:@"Car" inManagedObjectContext:self.managedObjectContext];
    NSSortDescriptor *sortDescriptor=[[NSSortDescriptor alloc] initWithKey:@"maker" ascending:YES];
    

    
    NSArray *sortDescriptors=[[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [fetchRequest setEntity:anEntity];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    dispatch_async(self.readingCoreData, ^{
        NSError * err=nil;
        self.cars=[[self.managedObjectContext executeFetchRequest:fetchRequest error:&err] mutableCopy];
        
        if(err) {
            // error handling here...
        }
        
        //Asynchronous execution requires [tableview reloadData:]
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"number of cars=%d\n",[self.cars count]);
            [self.tableView reloadData];
        });
    });
    

    
    

    // Uncomment the following line to preserve selection between presentations.
    //self.clearsSelectionOnViewWillAppear = YES;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
    return [cars count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    enum { MAKER_TAG=11, MODEL_NAME_TAG, MPG_TAG, IMAGEVIEW_TAG};
    
    static NSString *CellIdentifier = @"carList";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    // I tweaked to speed up the speed of scrolling of UITableViewCell objects
    // by using tag attribute.
    // in lieu of [subview removeFromSuperview]
    // 9PM 11Sep2013
    UILabel * __block maker_label=nil;
    UILabel * __block model_name_label=nil;
    UILabel * __block mpg_label=nil;
    UIImageView * __block imageView=(UIImageView *)[cell.contentView viewWithTag:IMAGEVIEW_TAG];
    
    // Thread 1
    dispatch_async(self.reading_aCell, ^{
        
        if(!imageView) { // create all subviews!
            
            maker_label=[[UILabel alloc] initWithFrame:CGRectMake(320/2.0,0, 320,128/4.0*1.0)];
            model_name_label=[[UILabel alloc] initWithFrame:CGRectMake(320/2.0, 128/4.0*1.0, 320,128/4.0*2.0)];
            mpg_label=[[UILabel alloc] initWithFrame:CGRectMake(320/2.0, 128/4.0*2.0, 320, 128/4.0*3.0)];
            imageView=[[UIImageView alloc] init];
            
            NSLog(@"count=%d == 0",[cell.contentView.subviews count]);
            
            [cell.contentView addSubview:imageView];
            [cell.contentView addSubview:maker_label];
            [cell.contentView addSubview:model_name_label];
            [cell.contentView addSubview:mpg_label];
            
            maker_label.tag=MAKER_TAG;
            model_name_label.tag=MODEL_NAME_TAG;
            mpg_label.tag=MPG_TAG;
            imageView.tag=IMAGEVIEW_TAG;
            
            
        } else { // reuse all cells allocated, not mind about what's contained in each cell.
            
            maker_label=(UILabel *)[cell viewWithTag:11];
            model_name_label=(UILabel *)[cell viewWithTag:12];
            mpg_label=(UILabel *)[cell viewWithTag:13];
            
            NSLog(@"count=%d == 4",[cell.contentView.subviews count]);
        }
        
        // Thread 2
        dispatch_async(self.reading_aImage_in_aCell, ^{
            
            //
            // From this point,
            // Contents will be reinitialized for each cell.
            Car * aCar=[cars objectAtIndex:indexPath.row];
            
            UIImage * image=nil;
            if(aCar.picture) {
                image=[UIImage imageWithData:aCar.picture];
            } else {// default image when there is no corresponding image.
                image=[UIImage imageNamed:@"eye.png"];
            }
            
            
            // Thread 3
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                maker_label.text=aCar.maker;
                maker_label.adjustsFontSizeToFitWidth=YES;
                model_name_label.text=aCar.model_name;
                mpg_label.text=[aCar.mpg stringValue];
                
                imageView.layer.anchorPoint=CGPointMake(0, 0);
                imageView.image=image;
                imageView.bounds=CGRectMake(0, 0, 320/2.0, 128);
                imageView.contentMode=UIViewContentModeScaleAspectFit;
                
                //A Tool to debug:
                //NSLog(@"row=%d, maker=%@, mpg=%f, number of subviews=%d\n",indexPath.row,[aCar maker],[aCar.mpg floatValue],[cell.contentView.subviews count]);
                
            });
        });
    });
    
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if(editingStyle == UITableViewCellEditingStyleDelete) {
        
        Car * aCar=[cars objectAtIndex:indexPath.row];
        [self.managedObjectContext deleteObject:aCar];
        [cars removeObject:aCar];
        ////////////////////////////////////////////////////
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
        
        NSError * err=nil;
        if(![self.managedObjectContext save:&err]) {
            // error handling here...
            
        }
    }   else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    Car * moved=[self.cars objectAtIndex:fromIndexPath.row];
    [self.cars removeObject:moved];
    [self.cars insertObject:moved atIndex:toIndexPath.row];
}

 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
 // Return NO if you do not want the item to be re-orderable.
    return YES;
}







#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([segue.identifier isEqualToString:@"CarListTableViewControllerDelegate"]) {
        
        
        //***** Why is the ordering so important? *****
        
        
        // 1. setting delegate
        //TODO: I should have created Helper class supports <CarListTableViewControllerDelegate>, not putting section 1 here.
        // But I leave it due to being lack of time.
        EnlargedTableViewController *enlargedController=segue.destinationViewController;
        self.delegate=enlargedController;
        
        
        
        // 2. protocol implementation
        Car *selectedCar=[self.cars objectAtIndex:self.tableView.indexPathForSelectedRow.row];
        [self.delegate setSelectedCar:selectedCar];
        
        //*****          END                      *****
    }
}





- (IBAction)editButton_pressed:(id)sender {
    
    self.editing = !self.editing;
    
}
@end

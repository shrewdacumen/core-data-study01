//
//  EnlargedTableViewController.m
//  core data study01
//
//  Created by sungwook on 12/09/2013.
//  Copyright (c) 2013 sungwook. All rights reserved.
//

#import "EnlargedTableViewController.h"
#import "Car.h"
#import "CarListTableViewController.h"

@interface EnlargedTableViewController ()

@end

@implementation EnlargedTableViewController
@synthesize selectedCar = _selectedCar; // from <CarListTableViewControllerDelegate>

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
//    CarListTableViewController *CarListController=(CarListTableViewController *)self.presentingViewController;
//    CarListController.delegate=self;
    

    UIImage *image=[UIImage imageWithData:self.selectedCar.picture];
    UIImageView * imageView=[[UIImageView alloc] initWithImage:image];
    imageView.contentMode=UIViewContentModeScaleAspectFit;
    imageView.frame=self.scrollView.frame;
    
    self.maker.textLabel.text=self.selectedCar.maker;
    self.model_name.textLabel.text=self.selectedCar.model_name;
    self.mpg.textLabel.text=[self.selectedCar.mpg stringValue];
    
    [self.scrollView addSubview:imageView];
    
    self.scrollView.minimumZoomScale=1;
    self.scrollView.maximumZoomScale=8.0;
    //self.scrollView.zoomScale=0.7;
    //self.scrollView.contentSize=CGSizeMake(image.size.width, image.size.height);
    self.scrollView.delegate=self;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return [self.scrollView.subviews firstObject];
}

//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    
//    // Configure the cell...
//    
//    return cell;
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end

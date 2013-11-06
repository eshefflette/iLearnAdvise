//
//  DetailViewController.m
//  iLearnAdvise
//
//  Created by Eric Svendsen Shefflette on 9/4/13.
//  Copyright (c) 2013 Eric Svendsen Shefflette. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize stud;

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
    // Do any additional setup after loading the view from its nib.
   // lastname.text = [student objectForKey:@"lastname"];
    
}

#pragma mark - Table View Components

-(int)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"Stud %D", stud.count);
    return 1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell"];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MainCell"];
    }
    // if([[students objectAtIndex:indexPath.row ] objectForKey:@"itemname"] != [NSNull null])
    //{
    //   cell.textLabel.text = [[students objectAtIndex:indexPath.row] objectForKey:@"itemname"];
 //   NSLog(@"Detail view name %@", [[stud objectAtIndex:indexPath.row] objectForKey:@"grademax"]);
  //  cell.detailTextLabel.text = [[[stud objectAtIndex:indexPath.row]  objectAtIndex:0] objectForKey:@"finalgrade"];
    cell.textLabel.text = [[[stud objectAtIndex:indexPath.row] objectAtIndex:0 ] objectForKey:@"coursename"];
    // }
    return cell;
}

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%D", stud.count);
    return stud.count;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    
    //detailViewController.course.text = [[students objectAtIndex:indexPath.row] objectForKey:@"lastname"];
   // detailViewController.stud = [students objectAtIndex:indexPath.row];
  //  [self.navigationController pushViewController:detailViewController animated:YES];
    
}

@end

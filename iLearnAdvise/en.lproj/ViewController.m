//
//  ViewController.m
//  iLearnAdvise
//
//  Created by Eric Svendsen Shefflette on 9/4/13.
//  Copyright (c) 2013 Eric Svendsen Shefflette. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

NSString *kDetailedViewControllerID = @"DetailView";    // view controller storyboard id
NSString *kCellID = @"cellID";

@interface ViewController ()

@end

@implementation ViewController

@synthesize students, assignments, students2, classes;
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Students";
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSURL *url = [NSURL URLWithString:@"http://shefflettetech.com/testmoodle/webservice/rest/server.php?wstoken=5bf740e75ee58d5222263e4ccac9173d&wsfunction=local_test_get_grades_for_cohort_members&moodlewsrestformat=json&cohortids=1"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    NSMutableArray *students2 = [NSMutableArray arrayWithObjects: [NSMutableArray array], [NSMutableArray array], nil];
    //[self.mainTableView registerClass:[UITableViewCell class] forCellWithReuseIdentifier:@"kCellID"];
	// Do any additional setup after loading the view, typically from a nib.
}


#pragma mark - Connection Functions

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    students = [NSJSONSerialization JSONObjectWithData:data options:nil error:nil];
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSLog(@"%@", [[students objectAtIndex:0] objectForKey:@"coursename"]);
    NSLog(@"%@", [[students objectAtIndex:0] objectForKey:@"firstname"]);
    self.assignments = [NSMutableArray array];
    self.students2 = [NSMutableArray array];
    self.classes = [NSMutableArray array];
    NSInteger counter = 0;
    NSArray *hold = [[NSArray alloc] init];
    if(students2.count == 0)
    {
        NSLog(@"Array is empty");
    }
    NSLog(@"Is array empty %@", students2);
    for(id student in students)
    {
        if(counter == 0)
        {
            [assignments addObject:student];
            NSLog(@"IF STATE %@", [[assignments objectAtIndex:counter] valueForKey:@"lastname"] );
            counter++;
        }
        else
        {
            
            if([[student valueForKey:@"lastname"] isEqualToString:[[assignments objectAtIndex:(counter-1)] valueForKey:@"lastname"]] && [[student valueForKey:@"coursename"] isEqualToString:[[assignments objectAtIndex:(counter -1)] valueForKey:@"coursename"]])
            {
                [assignments addObject:student];
                //   NSLog(@"%@", [assignments valueForKey:@"lastname"] );
                
            }
            else if([[student valueForKey:@"lastname"] isEqualToString:[[assignments objectAtIndex:(counter -1)] valueForKey:@"lastname"]] && [[student valueForKey:@"coursename"] isEqualToString:[[assignments objectAtIndex:(counter - 1)] valueForKey:@"coursename"]])
            {
                
            }
            else
            {
                [classes addObject:[assignments mutableCopy]];
                //[assignments removeAllObjects];
                [students2 addObject:[classes mutableCopy]];
                [classes removeAllObjects];
                [assignments removeAllObjects];
               // NSLog(@"ELSE STATEMENT FOR STUDENT2 %@", [students2 objectAtIndex:counter]);
                [assignments addObject:student];
                counter = 0;
            }
        }
    }
    for(id student in students2)
    {
        NSLog(@"Students name %@", student);
    }
    [mainTableView reloadData];

}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    data = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)theData
{
    [data appendData:theData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Coul not establish a connection to the server. " delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [errorView show];
    
}


#pragma mark - Table View Components

-(int)numberOfSectionsInTableView:(UITableView *)tableView
{
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
    cell.textLabel.text = [[[students2 objectAtIndex:indexPath.row] objectAtIndex:0] objectForKey:@"coursename"];
    cell.detailTextLabel.text = [[[students2 objectAtIndex:indexPath.row] objectAtIndex:0] objectForKey:@"lastname"];
   // }
    return cell;
}

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return students2.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    NSMutableArray *object = [students2 objectAtIndex:indexPath.row];
    self.classes = [NSMutableArray array];
    NSInteger counter = 0;
    NSMutableArray *hold = [[students2 objectAtIndex:indexPath.row] mutableCopy];
    for(id class in hold)
    {
        
        NSLog(@"%@", [class valueForKey:@"lastname"] );
            if(counter == 0)
            {
                [classes addObject:class];
                NSLog(@"IF STATEEE %@", [[classes objectAtIndex:0] valueForKey:@"lastname"] );
                counter++;
            }
            else
            {
                
                if([class valueForKey:@"courseid"] == [[classes objectAtIndex:(counter-1)] valueForKey:@"courseid"] )
                {
                    [classes addObject:class];
                    //   NSLog(@"%@", [assignments valueForKey:@"lastname"] );
                    counter++;
                    
                }
                else
                {
                    [object addObject:[classes mutableCopy]];
                    NSLog(@"ELSE STATEMENT FOR STUDENT2 %@", [classes objectAtIndex:0]);
                    [classes removeAllObjects];
                    [classes addObject:class];
                    counter = 1;
                }
            }
        }
    //object = [classes mutableCopy];
    NSLog(@"Output of classes before segue %@", object);
    NSLog(@"Selection %@", [object objectAtIndex:0]);
    detailViewController.stud = object;
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

@end

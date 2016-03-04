//
//  RootViewController.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 10/11/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "RootViewController.h"
#import "SampleViewController.h"

#define SAMPLES_DATA_FILE       @"samples"

#define TITLE_KEY               @"title"
#define SAMPLE_KEY              @"sample"
#define BACKGROUND_KEY          @"background"
#define VIEW_CONTROLLER_KEY     @"viewController"

@interface RootViewController ()
// Data
@property (nonatomic, strong) NSArray             *samplesData;
@property (nonatomic, strong) NSMutableDictionary *viewControllerCache;
@end

@implementation RootViewController
#pragma mark - Constructor
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        self.title = @"Samples list";
    }

    return self;
}

#pragma mark - View management
- (void)viewDidLoad {
    [super viewDidLoad];

    // Load data
    _samplesData = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:SAMPLES_DATA_FILE
                                                                                    ofType:@"plist"]];
}

#pragma mark - UITableViewDelegate methods
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *sampleData = [_samplesData objectAtIndex:indexPath.row];

    // Set sample title
    cell.textLabel.text = [sampleData objectForKey:TITLE_KEY];

    // Set sample cell background color
    cell.backgroundColor = [[sampleData objectForKey:BACKGROUND_KEY] representedColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *viewController;
    NSString *viewControllerClassName = [[_samplesData objectAtIndex:indexPath.row] objectForKey:VIEW_CONTROLLER_KEY];
    if (viewControllerClassName.length)
    {
        // Check cache
        viewController = [_viewControllerCache objectForKey:viewControllerClassName];
        if (!viewController)
        {
            // Instantiate
            viewController = [[NSClassFromString(viewControllerClassName) alloc] init];

            // Hold reference for reuse
            [_viewControllerCache setObject:viewController
                                     forKey:viewControllerClassName];
        }
            
    }
    else
    {
        // Configure sample view controller
        SampleViewController *sampleViewController = [[SampleViewController alloc] init];
        sampleViewController.sampleText            = [[_samplesData objectAtIndex:indexPath.row] objectForKey:SAMPLE_KEY];

        viewController = sampleViewController;
    }

    // Push associated view controller
    [self.navigationController pushViewController:viewController
                                         animated:YES];

    // Deselect row
    [tableView deselectRowAtIndexPath:indexPath
                             animated:YES];
}

#pragma mark - UITableViewDatasource methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell description]];
    if (!cell)
    {
        // Load cell
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:[UITableViewCell description]];
    }

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _samplesData.count;
}

#pragma mark - Memory
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    [_viewControllerCache removeAllObjects];
}

@end

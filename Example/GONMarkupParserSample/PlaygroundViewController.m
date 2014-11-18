//
//  PlaygroundViewController.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 10/11/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "PlaygroundViewController.h"
#import "ResultViewController.h"

@interface PlaygroundViewController ()
// View controllers
@property (nonatomic, strong) ResultViewController *resultViewController;

// Outlets
@property (nonatomic, weak  ) IBOutlet UITextView      *inputTextView;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *validateButton;
@end

@implementation PlaygroundViewController
#pragma mark - View management
- (void)viewDidLoad
{
    [super viewDidLoad];

    // Title
    self.title = @"Playground";

    self.navigationItem.rightBarButtonItem = _validateButton;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [_inputTextView becomeFirstResponder];
}

#pragma mark - UI Actions
- (IBAction)showResult
{
    // Parse string
    self.resultViewController.resultAttributedString = [[GONMarkupParserManager sharedParser] attributedStringFromString:_inputTextView.text];

    // Show results
    [self.navigationController pushViewController:self.resultViewController
                                         animated:YES];
}

LAZY_PROPERTY(resultViewController);
@end

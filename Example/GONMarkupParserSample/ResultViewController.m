//
//  ResultViewController.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()
// Outlets
@property (nonatomic, weak) IBOutlet UITextView  *resultTextView;
@end

@implementation ResultViewController
#pragma mark - View management
- (void)viewDidLoad
{
    [super viewDidLoad];

    // Title
    self.title = @"Result";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    // Affect result string
    _resultTextView.attributedText = _resultAttributedString;
}

#pragma mark - UITextViewDelegate methods
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    // Show link value
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Information"
                                                    message:[URL description]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
    return NO;
}


@end

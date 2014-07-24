//
//  InputViewController.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 25/06/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "InputViewController.h"
#import "ResultViewController.h"
#import "GONMarkupParser.h"

@interface InputViewController ()
// Outlets
@property (nonatomic, weak) IBOutlet UITextView  *inputTextView;
@end

@implementation InputViewController
#pragma mark - View mangement
- (void)viewDidLoad
{
    [super viewDidLoad];

    _inputTextView.text = _defaultString;
    [_inputTextView becomeFirstResponder];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ((ResultViewController *)segue.destinationViewController).resultAttributedString = [[GONMarkupParser sharedInstance] attributedStringFromString:_inputTextView.text
                                                                                                                                              error:nil];
}
@end

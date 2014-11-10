//
//  SampleViewController.m
//  GONMarkupParserSample
//
//  Created by Nicolas Goutaland on 10/11/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "SampleViewController.h"

@interface SampleViewController ()
// Outlets
@property (nonatomic, weak) IBOutlet UILabel *inputLabel;
@property (nonatomic, weak) IBOutlet UILabel *resultLabel;
@end

@implementation SampleViewController
#pragma mark - View management
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    // Configure labels
    _inputLabel.text            = _sampleText;
    _resultLabel.attributedText = [[GONMarkupParserManager sharedParser] attributedStringFromString:_sampleText];
}
@end

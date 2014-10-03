    //
    //  ViewController.m
    //  animateLabel
    //
    //  Created by Rob Mayoff on 10/3/14.
    //  Copyright (c) 2014 Rob Mayoff. All rights reserved.
    //

    #import "ViewController.h"

    @interface ViewController ()
    @property (strong, nonatomic) IBOutlet UILabel *label;
    @property (strong, nonatomic) IBOutlet NSLayoutConstraint *labelContainerWidthConstraint;
    @property (strong, nonatomic) IBOutlet NSLayoutConstraint *labelContainerHeightConstraint;
    @property (strong, nonatomic) IBOutlet NSLayoutConstraint *labelWidthConstraint;
    @property (strong, nonatomic) IBOutlet NSLayoutConstraint *labelHeightConstraint;
    @end

    @implementation ViewController

    - (void)viewDidLoad {
        [super viewDidLoad];
        [UIView performWithoutAnimation:^{
            [self smallButtonWasTapped:self];
        }];
    }

    - (IBAction)smallButtonWasTapped:(id)sender {
        self.labelContainerWidthConstraint.constant = 150;
        self.label.numberOfLines = 1;
        self.labelContainerHeightConstraint.constant = [self.label sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)].height;
        self.label.numberOfLines = 0;
        [UIView animateWithDuration:2 animations:^{
            [self.label.superview layoutIfNeeded];
        } completion:^(BOOL finished) {
            if (finished) {
                self.label.lineBreakMode = NSLineBreakByTruncatingTail;
                self.labelWidthConstraint.constant = self.labelContainerWidthConstraint.constant;
                self.labelHeightConstraint.constant = self.labelContainerHeightConstraint.constant;
            }
        }];
    }

    - (IBAction)bigButtonWasTapped:(id)sender {
        // First, get rid of the ellipsis and resize the label without animation.
        self.label.lineBreakMode = NSLineBreakByWordWrapping;
        self.label.numberOfLines = 0;
        self.labelWidthConstraint.constant = 300;
        self.labelHeightConstraint.constant = [self.label sizeThatFits:CGSizeMake(self.labelWidthConstraint.constant, CGFLOAT_MAX)].height;
        [self.label layoutIfNeeded];

        // Now animate the container.
        self.labelContainerWidthConstraint.constant = self.labelWidthConstraint.constant;
        self.labelContainerHeightConstraint.constant = self.labelHeightConstraint.constant;
        [UIView animateWithDuration:2 animations:^{
            [self.label.superview layoutIfNeeded];
        }];
    }

    @end

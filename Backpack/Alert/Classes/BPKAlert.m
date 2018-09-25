/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018 Skyscanner Ltd
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "BPKAlert.h"
#import <Backpack/Color.h>
#import <Backpack/Spacing.h>
#import <Backpack/Font.h>
#import "BPKAlertView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPKAlert()

@property (nonatomic, strong) UIView *faderView;
@property (nonatomic, strong) UIButton *doneButton;
@property (nonatomic, strong) BPKAlertView *alertView;
@property (nonatomic, strong) UIWindow *window;

@end

@implementation BPKAlert
{
    BPKAlertActionItemHandler _primaryHandler;
    BPKAlertActionItemHandler _secondaryhandler;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _window = [[UIApplication sharedApplication] keyWindow];
        
        _faderView = [UIView new];
        _faderView.clipsToBounds = YES;
        _faderView.userInteractionEnabled = YES;
        _faderView.backgroundColor = BPKColor.gray900;
        _faderView.alpha = 0.5;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(faderTapped:)];
        [_faderView addGestureRecognizer:tapGesture];

        _doneButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_doneButton setTitleColor:BPKColor.white forState:UIControlStateNormal];
        [_doneButton addTarget:self action:@selector(doneTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)alertWithTitle:(NSString * _Nonnull)title
           description:(NSString * _Nonnull)description
                 style:(BPKAlertStyle)style
  primaryActionHandler:(_Nullable BPKAlertActionItemHandler)primaryActionHandler
secondaryActionHandler:(_Nullable BPKAlertActionItemHandler)secondaryActionHandler
            hasDropShadow:(BOOL)isDropShadowEnabled
                onView:(UIView * _Nonnull)baseView {
    
    _primaryHandler = primaryActionHandler;
    _secondaryhandler = secondaryActionHandler;
    
    // show fader
    _faderView.frame = baseView.bounds;
    [baseView addSubview:_faderView];

    
    [_doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [_doneButton.titleLabel setFont:[BPKFont textBaseEmphasized]];
    _doneButton.frame = CGRectMake(baseView.frame.size.width - BPKSpacingBase - _doneButton.intrinsicContentSize.width, BPKSpacingBase, _doneButton.intrinsicContentSize.width, _doneButton.intrinsicContentSize.height);
    [baseView addSubview:_doneButton];
    
    // create alert view && show alert
    _alertView = [[BPKAlertView alloc] initWithFrame:CGRectZero];
    _alertView.translatesAutoresizingMaskIntoConstraints = NO;
    [baseView addSubview:_alertView];

    [_alertView.centerXAnchor constraintEqualToAnchor:baseView.centerXAnchor].active = YES;
    [_alertView.centerYAnchor constraintEqualToAnchor:baseView.centerYAnchor].active = YES;
    [_alertView.leadingAnchor constraintEqualToAnchor:baseView.leadingAnchor constant:BPKSpacingLg].active = YES;
    [_alertView.trailingAnchor constraintEqualToAnchor:baseView.trailingAnchor constant:-BPKSpacingLg].active = YES;
    // show alert
    
    
    // finish --> remove fader && remove alert view
    
    
}

- (void)finishWithSuccess {
    [self.faderView removeFromSuperview];
    [self.doneButton removeFromSuperview];
    [self.alertView removeFromSuperview];
    _primaryHandler();
}

-(void)faderTapped:(UITapGestureRecognizer *)gestureRecognizer {
    if( gestureRecognizer.state == UIGestureRecognizerStateRecognized) {
        [self finishWithSuccess];
    }
}

-(void)doneTapped:(UIButton *)button {
    [self finishWithSuccess];
}

@end

NS_ASSUME_NONNULL_END

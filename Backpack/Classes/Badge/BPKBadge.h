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
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, BPKBadgeType) {
    BPKBadgeTypeSuccess = 0,
    BPKBadgeTypeWarning,
    BPKBadgeTypeDestructive,
    BPKBadgeTypeLight,
    BPKBadgeTypeInverse,
    BPKBadgeTypeOutline
};

NS_ASSUME_NONNULL_BEGIN
IB_DESIGNABLE @interface BPKBadge: UIView
@property(nonatomic, assign) BPKBadgeType type;
@property(nonatomic, copy) IBInspectable NSString *message;

- (instancetype)initWithType:(BPKBadgeType)type message:(NSString *)message;
@end
NS_ASSUME_NONNULL_END
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
#import "BPKLabel.h"
#import <Backpack/Color.h>

NS_ASSUME_NONNULL_BEGIN
@interface BPKLabel()
#if BPKLABEL_ATTRIBUTED_TEXT
@property(nonatomic, class, readonly) NSCache<NSString *, NSDictionary *> *attributesCache;
+ (NSDictionary<NSAttributedStringKey, id> *)attributesForStyle:(BPKFontStyle)style;
#endif

- (void)setupWithStyle:(BPKFontStyle)style;
@end

@implementation BPKLabel

- (instancetype)initWithFontStyle:(BPKFontStyle)style {
    self = [super initWithFrame:CGRectZero];

    if (self) {
        [self setupWithStyle:style];
    }

    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];

    if (self) {
        [self setupWithStyle:BPKFontStyleTextBase];
    }

    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        [self setupWithStyle:BPKFontStyleTextBase];
    }

    return self;
}

- (void)setFontStyle:(BPKFontStyle)fontStyle {
    _fontStyle = fontStyle;
    UIFont *font = [BPKFont fontWithStyle:fontStyle];
    NSAssert(font != nil, @"Invalid font style supplied to BPKLabel");

    if (font == nil) {
        font = [BPKFont textBase];
    }

    self.font = font;
#if BPKLABEL_ATTRIBUTED_TEXT
    [self setText:self.text];
#endif
}

- (void)setText:(NSString *_Nullable)text {
#if BPKLABEL_ATTRIBUTED_TEXT
    if (text) {
        NSDictionary *attributes = [[self class] attributesForStyle:self.fontStyle];
        self.attributedText = [[NSAttributedString alloc] initWithString:text attributes:attributes];
    } else {
        self.attributedText  = nil;
    }
#else
    [super setText:text];
#endif
}

#pragma mark - Private

- (void)setupWithStyle:(BPKFontStyle)style {
    self.fontStyle = style;
    self.textColor = [BPKColor gray700];
}

#if BPKLABEL_ATTRIBUTED_TEXT
+ (NSCache<NSString *, NSDictionary *> *)attributesCache {
    static dispatch_once_t onceToken;
    static NSCache<NSString *, NSDictionary *> *_attributesCache;

    dispatch_once(&onceToken, ^{
        _attributesCache = [[NSCache alloc] init];
    });

    return _attributesCache;
}

+ (CGFloat)lineHeightMultipleForFont:(UIFont *)font desiredLineHeight:(CGFloat)height {
    CGFontRef ref = CGFontCreateWithFontName((__bridge CFStringRef)font.fontName);
    CGFloat unitsPerEm = CGFontGetUnitsPerEm(ref);
    CGFloat ascender = CGFontGetAscent(ref);
    CGFloat descender = CGFontGetDescent(ref);

    CGFontRelease(ref);

    CGFloat calculatedSize = font.pointSize * ((ascender - descender) / unitsPerEm);

    return height / calculatedSize;
}

+ (NSDictionary<NSAttributedStringKey, id> *)attributesForStyle:(BPKFontStyle)style {
    NSString *key = [@(style) stringValue];
    id value = [BPKLabel.attributesCache objectForKey:key];

    if (value) {
        return value;
    }

    NSMutableDictionary *attributes = [NSMutableDictionary new];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
//    paragraphStyle.lineHeightMultiple = 1.0;
    UIFont *font = nil;
    CGFloat desiredLineHeight = 0.0;

    switch (style) {
        case BPKFontStyleTextXs: {
            // BASE style in new type ramp
            font = [UIFont systemFontOfSize:12.0];
            attributes[NSKernAttributeName] = @(-0);
            desiredLineHeight = 16.0;
            break;
        }
        case BPKFontStyleTextXsEmphasized: {
            // BASE style in new type ramp
            font = [UIFont systemFontOfSize:12.0 weight:UIFontWeightSemibold];
            attributes[NSKernAttributeName] = @(-0);
            desiredLineHeight = 16.0;
            break;
        }
        case BPKFontStyleTextSm: {
            // S style in new type ramp
            font = [UIFont systemFontOfSize:14.0];
            attributes[NSKernAttributeName] = @(-0);
            desiredLineHeight = 18.0;
            break;
        }
        case BPKFontStyleTextSmEmphasized:
            // S style in new type ramp
            font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightSemibold];
            attributes[NSKernAttributeName] = @(-0);
            desiredLineHeight = 18.0;
            break;
        case BPKFontStyleTextBase:
            // M style in new type ramp
            font = [UIFont systemFontOfSize:16.0];
            attributes[NSKernAttributeName] = @(-0.2);
            desiredLineHeight = 21;
            break;
        case BPKFontStyleTextBaseEmphasized:
            // M style in new type ramp
            font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightSemibold];
            attributes[NSKernAttributeName] = @(-0.2);
            desiredLineHeight = 21;
            break;
        case BPKFontStyleTextLg:
            // L style in new type ramp
            font = [UIFont systemFontOfSize:20.0];
            attributes[NSKernAttributeName] = @(-0.4);
            desiredLineHeight = 26.0;
            break;
        case BPKFontStyleTextLgEmphasized:
            // L style in new type ramp
            font = [UIFont systemFontOfSize:20.0 weight:UIFontWeightSemibold];
            attributes[NSKernAttributeName] = @(-0.4);
            desiredLineHeight = 26.0;
            break;
        case BPKFontStyleTextXl:
            // XL style in new type ramp
            font = [UIFont systemFontOfSize:24.0];
            attributes[NSKernAttributeName] = @(-0.6);
            desiredLineHeight = 31.0;
            break;
        case BPKFontStyleTextXlEmphasized:
            // XL style in new type ramp
            font = [UIFont systemFontOfSize:24.0 weight:UIFontWeightSemibold];
            attributes[NSKernAttributeName] = @(-0.6);
            desiredLineHeight = 31.0;
            break;
    }
    NSAssert(font, @"Font should have been set in the above switch");
    paragraphStyle.lineHeightMultiple = [self lineHeightMultipleForFont:font desiredLineHeight:desiredLineHeight];
    attributes[NSFontAttributeName] = font;
    attributes[NSParagraphStyleAttributeName] = [paragraphStyle copy];

    NSDictionary *result = [attributes copy];
    [BPKLabel.attributesCache setObject:result forKey:key];

    return result;
}
#endif

@end
NS_ASSUME_NONNULL_END

//***************************************************************************

// Copyright (C) 2009 ~ 2016 Realmac Software Ltd
//
// These coded instructions, statements, and computer programs contain
// unpublished proprietary information of Realmac Software Ltd
// and are protected by copyright law. They may not be disclosed
// to third parties or copied or duplicated in any form, in whole or
// in part, without the prior written consent of Realmac Software Ltd.

//***************************************************************************

#import "AttributedStringToStringValueTransformer.h"

@implementation AttributedStringToStringValueTransformer

+ (Class)transformedValueClass
{
	return [NSAttributedString class];
}

+ (BOOL)allowsReverseTransformation
{
	return YES;
}

- (nullable id)transformedValue:(nullable id)value
{
	if ([value isKindOfClass:[NSString class]]){
		return [[NSAttributedString alloc] initWithString:value attributes:nil];
	}
	return value;
}

- (nullable id)reverseTransformedValue:(nullable id)value
{
	if ([value isKindOfClass:[NSAttributedString class]]){
		return [(NSAttributedString *)value string];
	}
	return value;
}

@end

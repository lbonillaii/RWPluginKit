//***************************************************************************

// Copyright (C) 2009 ~ 2016 Realmac Software Ltd
//
// These coded instructions, statements, and computer programs contain
// unpublished proprietary information of Realmac Software Ltd
// and are protected by copyright law. They may not be disclosed
// to third parties or copied or duplicated in any form, in whole or
// in part, without the prior written consent of Realmac Software Ltd.

//***************************************************************************

#import "RMSSamplePlugin+Sandwich.h"
#import "RMSSamplePluginContentViewController.h"

//***************************************************************************

@implementation RMSSamplePlugin (Sandwich)

+ (void)load
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	[RMSandwich setFactoryClass:self forType:@"RapidWeaver Sample Plugin Data"];
	
	[pool drain];
}

+ (id)createWithSandwich:(RMSandwich *)sandwich
{
	RMSSamplePlugin *plugin = [[[RMSSamplePlugin alloc] init] autorelease];
	
	NSDictionary *dictionary = [sandwich sandwichFillingForVersion:0].dictionary;
	NSData *postsData = dictionary[NSStringFromSelector(@selector(posts))];
	NSArray *posts = [NSKeyedUnarchiver unarchiveObjectWithData:postsData];
	plugin.posts = [NSMutableArray arrayWithArray:posts];
	
	return plugin;
}

- (RMSandwich *)sandwich
{
	RMSandwich *sandwich = [RMSandwich sandwichWithType:@"RapidWeaver Sample Plugin Data"];
	NSDictionary *dictionary = @{NSStringFromSelector(@selector(posts)) : [NSKeyedArchiver archivedDataWithRootObject:self.posts]};
	[sandwich setDictionary:dictionary forVersion:0];
	return sandwich;
}

@end

//***************************************************************************

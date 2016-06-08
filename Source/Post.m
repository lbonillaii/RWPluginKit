//***************************************************************************

// Copyright (C) 2009 ~ 2016 Realmac Software Ltd
//
// These coded instructions, statements, and computer programs contain
// unpublished proprietary information of Realmac Software Ltd
// and are protected by copyright law. They may not be disclosed
// to third parties or copied or duplicated in any form, in whole or
// in part, without the prior written consent of Realmac Software Ltd.

//***************************************************************************

#import "Post.h"

@interface Post ()

@property (nonatomic, copy, readwrite) NSDate *date;
@property (nonatomic, copy, readwrite) NSString *filename;

@end

@implementation Post

- (instancetype)init
{
	if (self = [super init]){
		self.title = @"";
		self.body = @"";
		self.date = [NSDate date];
		self.filename = [[[NSUUID UUID] UUIDString] lowercaseString];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeObject:self.title forKey:NSStringFromSelector(@selector(title))];
	[aCoder encodeObject:self.body forKey:NSStringFromSelector(@selector(body))];
	[aCoder encodeObject:self.date forKey:NSStringFromSelector(@selector(date))];
	[aCoder encodeObject:self.filename forKey:NSStringFromSelector(@selector(filename))];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
	Post *p = [[Post alloc] init];
	p.title = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(title))];
	p.body = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(body))];
	p.date = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(date))];
	p.filename = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(filename))];
	return p;
}

+ (NSDateFormatter *)dateFormatter
{
	static dispatch_once_t onceToken;
	static NSDateFormatter *dateFormatter = nil;
	dispatch_once(&onceToken, ^{
		dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
		[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
		[dateFormatter setLocale:[NSLocale autoupdatingCurrentLocale]];
	});
	return dateFormatter;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"%@ - %@", self.title, self.body];
}

- (NSString *)html
{
	return [NSString stringWithFormat:@"%@\n%@", [self titleHTML], [self bodyHTML]];
}

- (NSString *)titleHTML
{
	return [NSString stringWithFormat:@"<h3>%@</h3>", self.title];
}

- (NSString *)bodyHTML
{
	return [NSString stringWithFormat:@"<em>%@</em>\n<p>%@</p>", [[[self class] dateFormatter] stringFromDate:self.date], self.body];
}


@end

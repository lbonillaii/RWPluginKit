//***************************************************************************

// Copyright (C) 2009 ~ 2016 Realmac Software Ltd
//
// These coded instructions, statements, and computer programs contain
// unpublished proprietary information of Realmac Software Ltd
// and are protected by copyright law. They may not be disclosed
// to third parties or copied or duplicated in any form, in whole or
// in part, without the prior written consent of Realmac Software Ltd.

//***************************************************************************

#import "RMSSamplePlugin.h"
#import "RMSSamplePluginOptionsViewController.h"
#import "RMSSamplePluginContentViewController.h"
#import "Post.h"

@interface RMSSamplePlugin ()

@property (nonatomic, strong) RMSSamplePluginOptionsViewController *optionsAndConfigurationViewController;
@property (nonatomic, strong) RMSSamplePluginContentViewController *userInteractionAndEditingViewController;
@property (nonatomic, strong) NSMutableArray *posts;
@property (nonatomic, strong) NSNumber *mainPagePosts;

@end

//***************************************************************************

@implementation RMSSamplePlugin

//***************************************************************************

#pragma mark Protocol Methods

- (NSView *)optionsAndConfigurationView
{
	if (self.optionsAndConfigurationViewController == nil)
	{
		self.optionsAndConfigurationViewController = [[RMSSamplePluginOptionsViewController alloc] initWithPlugin:self];
	}
	
	return self.optionsAndConfigurationViewController.view;
}

- (NSView *)userInteractionAndEditingView
{
	if (self.userInteractionAndEditingViewController == nil)
	{		
		self.userInteractionAndEditingViewController = [[RMSSamplePluginContentViewController alloc] initWithRepresentedObject:self];
		self.userInteractionAndEditingViewController.posts = self.posts;
	}
	
	return self.userInteractionAndEditingViewController.view;
}

- (id)contentHTML:(NSDictionary *)params
{
	// This is where we'll provide the content for the main page. For a blog, we want to show a list of recent posts.
	
	NSString *extension = params[@"FilenameExt"];
	NSString *folder = params[@"filesfoldername"];
	
	NSMutableString *content = [NSMutableString string];
	for (NSInteger i = 0; i < [self.mainPagePosts integerValue]; i++){
		Post *p = self.userInteractionAndEditingViewController.postsArrayController.arrangedObjects[i];
		[content appendFormat:@"<a href=\"%@/%@.%@\">%@</a><br />\n", folder, p.filename, extension, [p titleHTML]];
	}
	
	return [NSString stringWithString:content];
}

- (NSArray *)extraFilesNeededInExportFolder:(NSDictionary *)params
{
	// This is where we will export all of the sub-pages (blog posts). There are a few ways of doing this, but this is the most simple. This method also ensures that our content is inserted into a page already styled with the selected theme.
	NSString *extension = params[@"FilenameExt"];
	
	NSMutableArray *extraFiles = [NSMutableArray array];
	for (Post *p in self.posts){
		NSString *postContents = [p html];
		NSString *filename = [p.filename stringByAppendingPathExtension:extension];
		[extraFiles addObject:[self contentOnlySubpageWithHTML:postContents name:filename]];
	}
	
	return extraFiles;
}

//***************************************************************************

#pragma mark KVO Broadcasting

- (NSArray *)visibleKeys
{
	// Add any values here that cause the document to need saving. This allows us to use KVO to catch any changes and do our broadcasting instead of writing the setters manually. Properties and KVO FTW!
	
	return @[@"mainPagePosts"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if ([[self visibleKeys] containsObject:keyPath])
	{
		[self broadcastPluginChanged];
	}
}

- (void)stopObservingVisibleKeys
{
	NSArray *keys = [self visibleKeys];
	
	for (NSString *key in keys)
	{
		[self removeObserver:self forKeyPath:key];
	}
}

- (void)observeVisibleKeys
{
	NSArray *keys = [self visibleKeys];
	
	for (NSString *key in keys)
	{
		[self addObserver:self forKeyPath:key options:0 context:NULL];
	}
}

//***************************************************************************

#pragma mark Object Lifecycle

- (void)finishSetup
{
	self.userInteractionAndEditingViewController = nil;
	self.optionsAndConfigurationViewController = nil;
	
	[self observeVisibleKeys];
}

- (void)encodeWithCoder:(NSCoder *)coder
{
	[super encodeWithCoder:coder];
	[coder encodeObject:[NSKeyedArchiver archivedDataWithRootObject:self.posts] forKey:NSStringFromSelector(@selector(posts))];
	[coder encodeObject:self.mainPagePosts forKey:NSStringFromSelector(@selector(mainPagePosts))];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
	if (self = [super initWithCoder:coder]) {
		self.posts = [[NSKeyedUnarchiver unarchiveObjectWithData:[coder decodeObjectForKey:NSStringFromSelector(@selector(posts))]] mutableCopy];
		self.mainPagePosts = [coder decodeObjectForKey:NSStringFromSelector(@selector(mainPagePosts))];
		[self finishSetup];
	}
	
	return self;
}

- (instancetype)init
{
	if (self = [super init]) {
		self.posts = [NSMutableArray array];
		self.mainPagePosts = @5;
		
		[self finishSetup];
	}
	
	return self;
}

- (void)dealloc
{
	[self stopObservingVisibleKeys];
}

//***************************************************************************

#pragma mark Class Methods

+ (NSBundle *)bundle
{
	return [NSBundle bundleForClass:[self class]];
}

+ (BOOL)initializeClass:(NSBundle *)aBundle
{
	return YES;
}

+ (NSString *)pluginName
{
	return NSLocalizedStringFromTableInBundle(@"PluginName", nil, [RMSSamplePlugin bundle], @"Localizable");
}

+ (NSString *)pluginAuthor
{
	return @"My Company Name";
}

+ (NSImage *)pluginIcon
{
	NSBundle *bundle = [RMSSamplePlugin bundle];
	NSString *iconFilename = [bundle objectForInfoDictionaryKey:@"CFBundleIconFile"];
	return [[NSImage alloc] initWithContentsOfFile:[bundle pathForImageResource:iconFilename]];
}

+ (NSString *)pluginDescription;
{
	return NSLocalizedStringFromTableInBundle(@"PluginDescription", nil, [RMSSamplePlugin bundle], @"Localizable");
}

@end

//***************************************************************************

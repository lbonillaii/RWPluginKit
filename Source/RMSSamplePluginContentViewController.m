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
#import "RMSSamplePluginContentViewController.h"
#import "Post.h"

@interface RMSSamplePluginContentViewController ()

@property (nonatomic, weak) RMSSamplePlugin *plugin;
@property (nonatomic, weak) IBOutlet NSTableView *tableView;

@end

//***************************************************************************

static void *PluginContentViewControllerContext = &PluginContentViewControllerContext;

@implementation RMSSamplePluginContentViewController

- (instancetype)initWithRepresentedObject:(id)object
{
	if (self = [super initWithNibName:@"RMSSamplePluginContentView" bundle:[RMSSamplePlugin bundle]]) {
		self.plugin = object;
	}
	
	return self;
}

- (void)awakeFromNib
{
	[super awakeFromNib];
	[self.postsArrayController setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:NSStringFromSelector(@selector(date)) ascending:NO]]];
}

- (IBAction)addPost:(id)sender
{
	Post *p = [[Post alloc] init];
	[self.posts addObject:p];
	[self.postsArrayController rearrangeObjects];
	[self.tableView editColumn:0 row:[self.postsArrayController.arrangedObjects indexOfObject:p] withEvent:nil select:NO];
	[self.plugin broadcastPluginChanged];
}

- (IBAction)removePost:(id)sender
{
	[self.posts removeObjectsInArray:[self.postsArrayController.arrangedObjects objectsAtIndexes:[self.tableView selectedRowIndexes]]];
	[self.postsArrayController rearrangeObjects];
	[self.plugin broadcastPluginChanged];
}

@end

//***************************************************************************

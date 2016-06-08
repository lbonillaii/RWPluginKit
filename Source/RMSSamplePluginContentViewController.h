//***************************************************************************

// Copyright (C) 2009 ~ 2016 Realmac Software Ltd
//
// These coded instructions, statements, and computer programs contain
// unpublished proprietary information of Realmac Software Ltd
// and are protected by copyright law. They may not be disclosed
// to third parties or copied or duplicated in any form, in whole or
// in part, without the prior written consent of Realmac Software Ltd.

//***************************************************************************

@interface RMSSamplePluginContentViewController : NSViewController

- (instancetype)initWithRepresentedObject:(id)object;

@property (nonatomic, weak) NSMutableArray *posts;
@property (nonatomic, weak) IBOutlet NSArrayController *postsArrayController;

@end

//***************************************************************************

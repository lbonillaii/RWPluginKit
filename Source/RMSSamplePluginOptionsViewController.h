//***************************************************************************

// Copyright (C) 2009 ~ 2010 Realmac Software Ltd
//
// These coded instructions, statements, and computer programs contain
// unpublished proprietary information of Realmac Software Ltd
// and are protected by copyright law. They may not be disclosed
// to third parties or copied or duplicated in any form, in whole or
// in part, without the prior written consent of Realmac Software Ltd.

//***************************************************************************

@interface RMSSamplePluginOptionsViewController : NSViewController

- (instancetype)initWithRepresentedObject:(id)object NS_DESIGNATED_INITIALIZER;

- (IBAction)chooseFile:(id)sender;
- (IBAction)testFileAccess:(id)sender;

@end

//***************************************************************************

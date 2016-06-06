//***************************************************************************

// Copyright (C) 2009 Realmac Software Ltd
//
// These coded instructions, statements, and computer programs contain
// unpublished proprietary information of Realmac Software Ltd
// and are protected by copyright law. They may not be disclosed
// to third parties or copied or duplicated in any form, in whole or
// in part, without the prior written consent of Realmac Software Ltd.

//***************************************************************************

#import <Cocoa/Cocoa.h>

//***************************************************************************

@class RWPage;
@class RWPlugin;

//***************************************************************************

#define kPluginCacheBigIcons	0
#define kPluginCacheSmallIcons	1

//***************************************************************************

/*
	Sent when the RWPluginManager has finished loading new plugins. This is what you need to listen for if you want to be
	informed of new plugins being loaded.
*/
extern NSString *const RWPluginManagerDidLoadNewPluginsNotification;

//***************************************************************************

@interface RWPluginManager : NSObject

@property (nonatomic, retain) NSDate *timeStamp;
@property (nonatomic, retain) NSMutableArray *plugins;

@property BOOL loadThirdParty;

+ (RWPluginManager *)sharedInstance;

- (NSImage *)iconForClass:(id)inClass size:(BOOL)inSmallIcons;
- (NSImage *)iconForPage:(RWPage *)inPage size:(BOOL)inSmallIcons;
- (NSImage *)iconForPlugin:(RWPlugin *)inPlugin size:(BOOL)inSmallIcons;

- (NSImage *)iconForClass:(id)inClass size:(BOOL)inSmallIcons selected:(BOOL)selected;
- (NSImage *)iconForPage:(RWPage *)inPage size:(BOOL)inSmallIcons selected:(BOOL)selected;
- (NSImage *)iconForPlugin:(RWPlugin *)inPlugin size:(BOOL)inSmallIcons selected:(BOOL)selected;

- (NSImage *)addMenuIconForPlugin:(RWPlugin *)inPlugin selected:(BOOL)selected;

- (RWPlugin *)pluginForIdentifier:(NSString *)identifier;

- (void)registerDisabledPlugin:(RWPlugin *)plugin;

- (void)scanForNewPlugins;

@end

//***************************************************************************

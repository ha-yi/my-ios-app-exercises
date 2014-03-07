//
//  SRINMasterViewController.h
//  CobaRSS
//
//  Created by MSCI on 2/13/14.
//  Copyright (c) 2014 SRIN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SRINMasterViewController : UITableViewController <NSXMLParserDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
//extern NSString *KEYTITLE;
//extern NSString *KEYLINK;
//extern NSString *KEYDESC;
@end

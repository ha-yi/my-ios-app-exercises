//
//  SRINMasterViewController.m
//  CobaRSS
//
//  Created by MSCI on 2/13/14.
//  Copyright (c) 2014 SRIN. All rights reserved.
//

#import "SRINMasterViewController.h"

#import "SRINDetailViewController.h"
#import "UIImage+NetworkImage.h"
#import "SRINCell.h"


@interface SRINMasterViewController () {
    NSMutableArray *_objects;
    NSXMLParser *parser;
    NSMutableArray *feeds;
    NSMutableDictionary *item;
    NSMutableString *title;
    NSMutableString *link;
    NSMutableString *description;
//    NSMutableString *link;
    NSString *element;
    
    
}
@end

NSString *KEYTITLE = @"title";
NSString *KEYLINK = @"link";
NSString *KEYDESC = @"description";

@implementation SRINMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
//    self.navigationItem.rightBarButtonItem = addButton;
    
    feeds = [[NSMutableArray alloc] init];
    NSString *strURL = @"http://rss.allrecipes.com/daily.aspx?hubID=80";
    NSURL *url = [NSURL URLWithString:strURL];
    
//    NSLog(@"RSS URL %@", strURL);
    
    parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:NO];
    bool parsed = [parser parse];
    
    NSLog(@"parsed: %d", parsed);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
 */

- (NSString *) getImageURLfromHTML: (NSString *) str {
    NSRange r;
    NSString *pattern = @"(http(s?):/.*(jpg|png|gif))";
    while ((r = [str rangeOfString:pattern options:NSRegularExpressionSearch]).location != NSNotFound) {
        str = [str substringWithRange:r];
        break;
    }
    return str;
}

- (NSString *) getRatingFromDescription: (NSString *) str {
    NSRange r;
    NSString *patternStars = @"\\d+.\\d+ / 5 Stars";
    NSString *stars;
    while ((r = [str rangeOfString:patternStars options:NSRegularExpressionSearch]).location != NSNotFound) {
        stars = [str substringWithRange:r];
        break;
    }
    NSString *review;
    NSString *patternReview = @"\\d+ Reviews";
    while ((r = [str rangeOfString:patternReview options:NSRegularExpressionSearch]).location != NSNotFound) {
        review = [str substringWithRange:r];
        break;
    }
    
    return [NSString stringWithFormat:@"%@ | %@", stars, review];
}

- (NSString *) getAuthorFromDescription: (NSString *) str {
    NSRange r;
    NSString *pattern = @"by [A-z]*";
    NSString *result;
    while ((r = [str rangeOfString:pattern options:NSRegularExpressionSearch]).location != NSNotFound) {
        result = [str substringWithRange:r];
        break;
    }
    return result;
}


- (NSMutableDictionary *) getDescriptionDictionary: (NSString *) str {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    NSString *imgUrl = [self getImageURLfromHTML:str];
    NSString *rating = [self getRatingFromDescription:str];
    NSString *author = [self getAuthorFromDescription:str];
    
//    NSLog(@"getDescriptionDictionary:\n URL= %@ \n rating: %@ \n author: %@",imgUrl, rating, author);
    [dict setObject:imgUrl forKey:@"url"];
    [dict setObject:rating forKey:@"rating"];
    [dict setObject:author forKey:@"author"];
    return dict;
}



#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return feeds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellForRowAtIndexPath");
//    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[SRINCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }

    
    cell.textLabel.text = [[feeds objectAtIndex:indexPath.row] objectForKey:@"title"];
    NSString *desc = [[feeds objectAtIndex:indexPath.row] objectForKey:@"description"];
    
    NSMutableDictionary *dict = [self getDescriptionDictionary:desc];
//    NSLog(@"url %@", );
//    NSLog(@"rating %@", [dict objectForKey:@"rating"]);
//    NSLog(@"author %@", [dict objectForKey:@"author"]);
    
    NSString *imgUrl = [dict objectForKey:@"url"];
    NSURL *url = [NSURL URLWithString:imgUrl];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSData *data = [NSData dataWithContentsOfURL:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:data];
            cell.imageView.image = image;
        });
    });
    
//    NSLog(@"image URL: %@",imgUrl);
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/



- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
//    NSLog(@"didStartElement");
    element = elementName;
    if([element isEqualToString:@"item"]) {
        item = [[NSMutableDictionary alloc] init];
        title = [[NSMutableString alloc] init];
        link = [[NSMutableString alloc] init];
        description = [[NSMutableString alloc] init];
        
    }
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
//    NSLog(@"foundCharacters");
    if ([element isEqualToString:@"title"]) {
        [title appendString:string];
    } else if ([element isEqualToString:@"link"]) {
        [link appendString:string];
    } else if ([element isEqualToString:@"description"]) {
        [description appendString:string];
    }
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
//    NSLog(@"didEndElement");
    if ([elementName isEqualToString:@"item"]) {
        [item setObject:title forKey:@"title"];
        [item setObject:link forKey:@"link"];
        [item setObject:description forKey:@"description"];
        
        [feeds addObject:[item copy]];
    }
}

- (void) parserDidEndDocument:(NSXMLParser *)parser {
     NSLog(@"parserDidEndDocument");
    [self.tableView reloadData];
}





@end

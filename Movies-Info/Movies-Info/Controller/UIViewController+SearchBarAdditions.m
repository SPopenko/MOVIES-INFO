//
//  UIViewController+SearchBarAdditions.m
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 1/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIViewController+SearchBarAdditions.h"
#import "MovieInfo.h"
#import "ViewActionIndicator.h"
#import "SearchSuggestionTableViewController.h"

@implementation UIViewController(SuggestionAdditions)

SearchSuggestionTableViewController* _suggestionsTableViewController = nil;
NSString* _searchString = nil;

- (void) prepareSuggestionAtView:(UIView*)displayView
{
    if (_suggestionsTableViewController == nil)
    {
        //TODO: improve this code for better memory mamnagement
        _suggestionsTableViewController = [[SearchSuggestionTableViewController alloc] init];
        _suggestionsTableViewController.tableView.frame = displayView.frame;
    }
    _suggestionsTableViewController.tableView.hidden = YES;
    [displayView.superview addSubview:_suggestionsTableViewController.tableView];
}

- (void) showSuggestionForSearchString:(NSString*) searchString
{
    if (searchString == nil || [searchString isEqualToString:[NSString stringWithString:@""]])
    {
        _suggestionsTableViewController.tableView.hidden = YES;
    }
    else
    {
        _suggestionsTableViewController.tableView.hidden = NO;
        
        MovieInfo* movieInfo = [[MovieInfo alloc] init];
        
        [movieInfo searchShortMovieInfoByName:searchString doAfterLoadFinished:^(id obj)
         {
             _suggestionsTableViewController.searchSuggestions = (NSArray*) obj;
             [_suggestionsTableViewController.tableView reloadData];
         }];
    }
}

- (void) hideSuggestion
{
    [_suggestionsTableViewController.tableView removeFromSuperview];
    [_suggestionsTableViewController release];
    _suggestionsTableViewController = nil;
}


@end

@implementation UIViewController (SearchBarAdditions)

static UIBarButtonItem* _searchBarButton = nil;
static BOOL bSearchIsOn = NO;
static UISearchBar* _searchBar = nil;
static UIColor* backgroundColor = nil;

- (IBAction) searchBar:(id)sender
{
    if (!bSearchIsOn)
    {
        [self displaySearchBar];
    }
    else
    {
        [self hideSearchBar];
    }
}

- (void) addSearchBar
{
    //Creating searchBar
    if (_searchBar == nil)
    {
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.placeholder = @"Type a search term";
        _searchBar.tintColor = self.navigationController.navigationBar.backgroundColor;

        _searchBar.delegate = self;
        
        [_searchBar sizeToFit];
               
        [_searchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [_searchBar sizeToFit];
    }  

    if (_searchBarButton == nil)
    {
        _searchBarButton = [[UIBarButtonItem alloc]
                            initWithBarButtonSystemItem: UIBarButtonSystemItemSearch target:self action:@selector(searchBar:)];
        _searchBarButton.style = UIBarButtonItemStyleBordered;
    }

    self.navigationItem.rightBarButtonItems =[NSArray arrayWithObjects:self.navigationItem.rightBarButtonItem, _searchBarButton, nil];
    if (self.navigationItem.rightBarButtonItem == nil) {
        self.navigationItem.rightBarButtonItem = _searchBarButton;
    }
    [_searchBarButton release];
}

- (void) displaySearchBar
{
    UIView* viewWithSearchBar = self.navigationController.visibleViewController.view;
    bSearchIsOn = YES;
    
    viewWithSearchBar.frame = CGRectMake(viewWithSearchBar.frame.origin.x, 
                                 viewWithSearchBar.frame.origin.y  + _searchBar.frame.size.height,
                                 viewWithSearchBar.frame.size.width, 
                                 viewWithSearchBar.frame.size.height - _searchBar.frame.size.height);

    [viewWithSearchBar.superview insertSubview:_searchBar atIndex:0];
    if (backgroundColor == nil)
    {
        backgroundColor = _searchBarButton.tintColor;
    }
    _searchBarButton.tintColor = [UIColor blackColor];
}

- (void) displaySearchBarIfActive
{
    if (bSearchIsOn)
    {
        [self displaySearchBar];
    }
}

- (void) hideSearchBar
{
    UIView* viewWithSearchBar = self.navigationController.visibleViewController.view;
    
    [self hideSuggestion];
    
    bSearchIsOn = NO;
    
    viewWithSearchBar.frame = CGRectMake(viewWithSearchBar.frame.origin.x, 
                                 viewWithSearchBar.frame.origin.y - _searchBar.frame.size.height,
                                 viewWithSearchBar.frame.size.width, 
                                 viewWithSearchBar.frame.size.height + _searchBar.frame.size.height);
    
    [_searchBar removeFromSuperview];
    _searchBarButton.tintColor = backgroundColor;
}

- (void) searchString:(NSString *)searchString
{
    MovieInfo* movieInfo = [[MovieInfo alloc] init];
    UIViewController* activeViewController = [self.navigationController.visibleViewController retain];
    
    [self hideSearchBar];    
    
    [activeViewController searchBarDelegateBeginSearch];
    
    [movieInfo searchShortMovieInfoByName:searchString doAfterLoadFinished:^(id obj)
     {
         if ([activeViewController respondsToSelector:@selector(searchBarDelegateEndSearch:)])
         {
             [activeViewController searchBarDelegateEndSearch:((NSArray*) obj)];
         }
     }];
    [activeViewController release];
}

#pragma mark - Working with search result
- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self hideSearchBar];
    UIViewController* activeViewController = [self.navigationController.visibleViewController retain];
    if ([searchBar.text isEqualToString:[NSString stringWithString:@""]] &&
        [activeViewController respondsToSelector:@selector(searchBarDelegateHideSearchResults)])
    {
        [activeViewController searchBarDelegateHideSearchResults];
    }
    [activeViewController release];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self searchString:searchBar.text];
}

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
        [self showSuggestionForSearchString:searchBar.text];
}

- (void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    //display table view for 
    _searchBar.showsCancelButton = YES;
    [self prepareSuggestionAtView:self.navigationController.visibleViewController.view];
    [self showSuggestionForSearchString:searchBar.text];

}

- (void) searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    _searchBar.showsCancelButton = NO;
}

- (void) searchBarDelegateBeginSearch
{
    [self.navigationController.visibleViewController showLoadIndicatorWithText:[NSString stringWithString:@"Loading search results"]];
}

@end

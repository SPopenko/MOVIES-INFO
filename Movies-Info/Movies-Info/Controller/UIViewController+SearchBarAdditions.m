//
//  UIViewController+SearchBarAdditions.m
//  Movies-Info
//
//  Created by Anton Poluboiarynov on 1/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIViewController+SearchBarAdditions.h"
#import "MovieInfo.h"

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

    bSearchIsOn = NO;
    
    viewWithSearchBar.frame = CGRectMake(viewWithSearchBar.frame.origin.x, 
                                 viewWithSearchBar.frame.origin.y - _searchBar.frame.size.height,
                                 viewWithSearchBar.frame.size.width, 
                                 viewWithSearchBar.frame.size.height + _searchBar.frame.size.height);
    
    [_searchBar removeFromSuperview];
    _searchBarButton.tintColor = backgroundColor;
}

#pragma mark - Working with search result
- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    //TODO - Add cancel method
    [self hideSearchBar];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    MovieInfo* movieInfo = [[MovieInfo alloc] init];

    [movieInfo searchShortMovieInfoByName:searchBar.text doAfterLoadFinished:^(id obj)
     {
         //TODO: Add display code
     }];
    
    [self hideSearchBar];
}

- (void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    _searchBar.showsCancelButton = YES;
}

- (void) searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    _searchBar.showsCancelButton = NO;
}

@end

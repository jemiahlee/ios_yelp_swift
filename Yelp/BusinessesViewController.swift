//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var listingTableView: UITableView!

    var businesses: [Business]!
    var searchBar: UISearchBar!
    var filterBarButton: UIBarButtonItem!
    var searchBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchBar.delegate = self
        searchBar.hidden = true
        // navigationItem.titleView = searchBar

/*        let searchButton = UIButton()
        searchButton.backgroundColor = UIColor.redColor()
        searchButton.titleLabel?.text = "Search"
        searchButton.addTarget(self, action: "openSearch", forControlEvents: UIControlEvents.TouchDown)

        searchBarButton = UIBarButtonItem()
        searchBarButton = UIBarButtonItem(customView: searchButton)


        let filterButton = UIButton()
        filterButton.backgroundColor = UIColor.redColor()
        filterButton.titleLabel?.text = "Filter"
        filterButton.addTarget(self, action: "goToFilterView", forControlEvents: UIControlEvents.TouchDown)

        filterBarButton = UIBarButtonItem()
        filterBarButton = UIBarButtonItem(customView: filterButton)

        navigationItem.leftBarButtonItem = searchBarButton
        navigationItem.rightBarButtonItem = filterBarButton */
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filter", style: .Plain,// barButtonSystemItem: .Add,
            target: self, action: "goToFilterView:")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style: .Plain, target: self, action: "openSearch:")

        listingTableView.delegate = self
        listingTableView.dataSource = self
        listingTableView.estimatedRowHeight = 100
        listingTableView.rowHeight = UITableViewAutomaticDimension
        



/* Example of Yelp search with more search options specified
        Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
        }
*/
        
        performSearch("")
        
    }

    func goToFilterView(sender: UIBarButtonItem?) {
        performSegueWithIdentifier("filterViewSegue", sender: sender)
    }

    func openSearch(sender: UIBarButtonItem?) {
        print("Got a search button click")
//        performSegueWithIdentifier(identifier: "segueNameHere", sender: self)
    }

    func performSearch(term: String){
        Business.searchWithTerm(term, completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
            
            self.listingTableView.reloadData()
        })
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ListingCell", forIndexPath: indexPath) as! ListingCell
        cell.listing = businesses[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let business = businesses {
            return business.count
        }
        return 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        if searchText.isEmpty {
            performSearch("")
        } else {
            performSearch(searchText)
        }
    }
}

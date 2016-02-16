//
//  FilterViewController.swift
//  Yelp
//
//  Created by Jeremiah Lee on 2/15/16.
//

import UIKit

class FilterViewController: UITableViewController {

    @IBOutlet weak var dealsSwitch: UISwitch!

    @IBOutlet weak var distanceAutoButton: UIButton!
    @IBOutlet weak var distanceHalfButton: UIButton!
    @IBOutlet weak var distanceTwoButton: UIButton!
    @IBOutlet weak var distanceFiveButton: UIButton!
    @IBOutlet weak var distanceTwentyButton: UIButton!
    @IBOutlet weak var sortBySegmentedControl: UISegmentedControl!

    var selectedIndexPath : NSIndexPath?
    let config = YelpConfig.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style: .Plain, target: self, action: "saveParametersAndSearch:")
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: "backToParent:")

        dealsSwitch.on = config.deals

        sortBySegmentedControl.removeAllSegments()
        for (index, sort_text) in config.YelpSortModeLabels.enumerate() {
            sortBySegmentedControl.insertSegmentWithTitle(sort_text, atIndex: index, animated: false)
        }
        sortBySegmentedControl.selectedSegmentIndex = config.sort
    }

    func backToParent(sender: AnyObject?) {
        navigationController?.popViewControllerAnimated(true)
    }

    func saveParametersAndSearch(sender: AnyObject?) {
        config.deals = dealsSwitch.on
        config.sort = sortBySegmentedControl.selectedSegmentIndex
        backToParent(sender)
    }

}

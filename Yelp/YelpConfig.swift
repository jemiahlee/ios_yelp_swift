//
//  YelpConfig.swift
//  Yelp
//
//  Created by Jeremiah Lee on 2/15/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import Foundation

class YelpConfig {
    let YelpSortModeLabels = ["Best Matched", "Distance", "Highest Rated"]

    class var sharedInstance: YelpConfig {
        struct Static {
            static var instance: YelpConfig?
            static var token: dispatch_once_t = 0
        }

        dispatch_once(&Static.token) {
            Static.instance = YelpConfig()
        }

        return Static.instance!
    }

    var deals: Bool = false
    var category: String!
    var distance: Int!
    var sort = 1
    var searchTerm = "Restaurants"
}
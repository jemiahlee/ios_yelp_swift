//
//  ListingCell.swift
//  Yelp
//
//  Created by Jeremiah Lee on 2/11/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class ListingCell: UITableViewCell {

    @IBOutlet weak var listingImageView: UIImageView!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingCountLabel: UILabel!
    @IBOutlet weak var distanceLabel: UIView!
    @IBOutlet weak var spendyLabel: UIView!
    
    internal var listing: Business! {
        didSet {
            classLabel.text = listing.categories!
            nameLabel.text = listing.name!
            ratingCountLabel.text = "\(listing.reviewCount!) reviews"
        }
    }
    
    func setListingValue(listing: Business){
        self.listing = listing
        
        classLabel.text = listing.categories!
        nameLabel.text = listing.name!
        ratingCountLabel.text = "\(listing.reviewCount!) reviews"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

//
//  ListingCell.swift
//  Yelp
//
//  Created by Jeremiah Lee on 2/11/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import AFNetworking
import UIKit

class ListingCell: UITableViewCell {

    @IBOutlet weak var listingImageView: UIImageView!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingCountLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var expenseLabel: UILabel!

    
    internal var listing: Business! {
        didSet {
            classLabel.text = listing.categories!
            nameLabel.text = listing.name!
            ratingCountLabel.text = "\(listing.reviewCount!) reviews"
            addressLabel.text = listing.address!
            distanceLabel.text = listing.distance!

            let ratingImageRequest = NSURLRequest(URL: listing.ratingImageURL!)
            ratingImageView.setImageWithURLRequest(ratingImageRequest, placeholderImage: nil,
                success: { (request:NSURLRequest,response:NSHTTPURLResponse?, image:UIImage) -> Void in
                    self.ratingImageView.image = image
                }, failure: { (request, response,error) -> Void in
                }
            )
            if let listingImageUrl = listing.imageURL {
                let listingImageRequest = NSURLRequest(URL: listingImageUrl)
                listingImageView.setImageWithURLRequest(listingImageRequest, placeholderImage: nil,
                    success: { (request:NSURLRequest,response:NSHTTPURLResponse?, image:UIImage) -> Void in
                        self.listingImageView.image = image
                    }, failure: { (request, response,error) -> Void in
                    }
                )

                listingImageView.layer.cornerRadius = 3
                listingImageView.clipsToBounds = true
            }

        }
    }
    
    func setListingValue(listing: Business){
        self.listing = listing
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

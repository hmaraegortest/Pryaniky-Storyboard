//
//  PictureCell.swift
//  PryanikyStoryboard
//
//  Created by Egor on 10.10.2020.
//

import UIKit

class PictureCell: UITableViewCell {
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var label: UILabel!
    @IBOutlet var pictureView: UIImageView!
    var url: String!
    
    static let cellXib = "PictureCell"
    static let cell = "PictureCell"
    
    static func getNib(nibName: String = PictureCell.cellXib) -> UINib {
        return UINib(nibName: nibName, bundle: nil)
    }
    
    func configure(text: String, url: String) {
        label.text = text
        self.url = url
        activityIndicator.hidesWhenStopped = true
    }
}


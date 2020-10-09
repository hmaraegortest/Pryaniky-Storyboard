//
//  HzCell.swift
//  PryanikyStoryboard
//
//  Created by Egor on 10.10.2020.
//

import UIKit

class HzCell: UITableViewCell {
    
    @IBOutlet var label: UILabel!
    
    static let cellXib = "HzCell"
    static let cell = "HzCell"
    
    static func getNib(nibName: String = HzCell.cellXib) -> UINib {
        return UINib(nibName: nibName, bundle: nil)
    }
    
    func configure(text: String) {
        label.text = text
    }
}

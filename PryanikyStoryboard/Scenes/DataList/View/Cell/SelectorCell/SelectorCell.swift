//
//  SelectorCell.swift
//  PryanikyStoryboard
//
//  Created by Egor on 10.10.2020.
//

import UIKit

protocol SelectedSegmentProtocol {
    func showSegmentId(segmentId: Int, cellName: String)
}

class SelectorCell: UITableViewCell {
    
    @IBAction func SegmentedControlSwitched(_ sender: UISegmentedControl) {
        delegate?.showSegmentId(segmentId: sender.selectedSegmentIndex, cellName: String(describing: type(of: self)))
    }
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    var presenter: DataListPresenterProtocol!
    var variants: [Variant]!
    var selectedId: Int!
    var delegate: SelectedSegmentProtocol?
    
    static let cellXib = "SelectorCell"
    static let cell = "SelectorCell"
    
    static func getNib(nibName: String = SelectorCell.cellXib) -> UINib {
        return UINib(nibName: nibName, bundle: nil)
    }
    
    func configure(listOfSelectors: [Variant], selectedId: Int){
        variants = listOfSelectors
        self.selectedId = selectedId
        
        segmentedControl.removeAllSegments()
        
        for variant in variants {
            segmentedControl.insertSegment(withTitle: variant.text, at: segmentedControl.numberOfSegments, animated: false)
        }
        
        segmentedControl.selectedSegmentIndex = selectedId
    }
    
}



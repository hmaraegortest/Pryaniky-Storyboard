//
//  ViewController.swift
//  PryanikyStoryboard
//
//  Created by Egor on 10.10.2020.
//

import UIKit

class DataListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: DataListPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(HzCell.getNib(), forCellReuseIdentifier: HzCell.cell)
        tableView.register(PictureCell.getNib(), forCellReuseIdentifier: PictureCell.cell)
        tableView.register(SelectorCell.getNib(), forCellReuseIdentifier: SelectorCell.cell)
    }
}

extension DataListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.prepearedListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let element = presenter.prepearedListData[indexPath.row]
        let elementType = ElementType(rawValue: element.name)
        
        switch elementType {
        
        case .hz:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HzCell.cell, for: indexPath) as? HzCell else { return UITableViewCell() }
            
            let text = (element.data as! HzData).text
            cell.configure(text: text)
            return cell
            
        case .picture:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PictureCell.cell, for: indexPath) as? PictureCell else { return UITableViewCell() }
            
            let text = (element.data as! PictureData).text
            let url = (element.data as! PictureData).url
            cell.configure(text: text, url: url)
            
            cell.activityIndicator.startAnimating()
            presenter.imageDownloader.downloadImage(stringURL: url) { (imageData) in

                DispatchQueue.main.async {
                    cell.activityIndicator.stopAnimating()
                    cell.pictureView.image = UIImage(data: imageData)
                    
                }
            }
            return cell
            
        case .selector:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectorCell.cell, for: indexPath) as? SelectorCell else { return UITableViewCell() }
            
            let selectedId = (element.data as! SelectorData).selectedId
            let variants = (element.data as! SelectorData).variants
            cell.configure(listOfSelectors: variants, selectedId: selectedId)
            cell.delegate = self
            return cell
            
        default:
            return UITableViewCell()
        }
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let element = presenter.prepearedListData[indexPath.row]
        guard let elementType = ElementType(rawValue: element.name) else { return }
        self.title = "Cell: ”\(elementType.rawValue)”. Cell ID: \(indexPath.row)"
    }
    
}

extension DataListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


extension DataListViewController: DataListVCProtocol {
    func success() {
       tableView.reloadData()
    }
    
    func failure(error: NetworkServiceError) {
        presenter.errorAlertService.showErrorAlert(error: error, viewController: self)
    }
}

extension DataListViewController: SelectedSegmentProtocol {
    func showSegmentId(segmentId: Int, cellName: String) {
        self.title = "Object: ”\(cellName)”. SegmentID: \(segmentId)"
    }
    
    
}

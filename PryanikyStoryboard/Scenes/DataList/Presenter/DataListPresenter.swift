//
//  Presenter.swift
//  PryanikyStoryboard
//
//  Created by Egor on 10.10.2020.
//

import Foundation

protocol DataListVCProtocol: AnyObject {
    func success()
    func failure(error: NetworkServiceError)
}

protocol DataListPresenterProtocol: AnyObject {
    init(view: DataListVCProtocol, networkService: NetworkServiceProtocol)
    func getList()
    var listData: PryanikyStaticJson? { get set }
}

class DataListPresenter: DataListPresenterProtocol {
    
    weak var view: DataListVCProtocol?  //!
    var networkService: NetworkServiceProtocol!
    var listData: PryanikyStaticJson?
    
    required init(view: DataListVCProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        getList()
    }
    
    func getList() {
        networkService.performHTTPRequest(url: "https://pryaniky.com/static/json/sample.json", method: "GET") { [weak self] (result: Result<PryanikyStaticJson, NetworkServiceError>) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                
                switch result {
                case .success(let json):
                    self.listData = json
                    self.view?.success()
                //print("Data was decoded. ", json.view.first!)
                case .failure(let error):
                    //ErrorAlertService.showErrorAlert(error: error, viewController: self.view)
                    self.view?.failure(error: error)
                }
                
            }
        }
    }
    
    
    
}

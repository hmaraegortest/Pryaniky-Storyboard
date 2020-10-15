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
    init(view: DataListVCProtocol, networkService: NetworkServiceProtocol, errorAlertService: ErrorAlertServiceProtocol, imageDownloader: ImageDownloaderProtocol)
    func getList()
    func prepearingListData()
    var errorAlertService: ErrorAlertServiceProtocol! { get set }
    var imageDownloader: ImageDownloaderProtocol! { get set }
    var listData: PryanikyStaticJson? { get set }
    var prepearedListData: [Element]! { get set }
}

class DataListPresenter: DataListPresenterProtocol {
    
    weak var view: DataListVCProtocol?  //!
    var networkService: NetworkServiceProtocol!
    var errorAlertService: ErrorAlertServiceProtocol!
    var imageDownloader: ImageDownloaderProtocol!
    var listData: PryanikyStaticJson?
    var prepearedListData: [Element]!
    
    required init(view: DataListVCProtocol, networkService: NetworkServiceProtocol, errorAlertService: ErrorAlertServiceProtocol, imageDownloader: ImageDownloaderProtocol) {
        self.view = view
        self.networkService = networkService
        self.errorAlertService = errorAlertService
        self.imageDownloader = imageDownloader
        prepearedListData = []
        getList()
    }
    
    func prepearingListData() {
        guard let types = listData?.view else { return }
        guard let elements = listData?.data else { return }
        for type in types {
            for element in elements {
                if element.name == type && !(element.data is UnknownData) {
                    prepearedListData.append(element)
                    break
                }
            }
        }
    }
    
    func getList() {
        networkService.performHTTPRequest(url: "https://pryaniky.com/static/json/sample.json", method: "GET") { [weak self] (result: Result<PryanikyStaticJson, NetworkServiceError>) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                
                switch result {
                case .success(let json):
                    self.listData = json
                    self.prepearingListData()
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
                
            }
        }
    }
    
    
    
}

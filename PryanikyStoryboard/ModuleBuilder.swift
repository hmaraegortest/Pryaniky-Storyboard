//
//  ModuleBuilder.swift
//  PryanikyStoryboard
//
//  Created by Egor on 10.10.2020.
//

import UIKit

protocol Builder {
    static func createDataListModule() -> UIViewController
}

class ModuleBuilder: Builder {
    static func createDataListModule() -> UIViewController {
        let view = DataListViewController()
        let networkService = NetworkService()
        let errorAlertService = ErrorAlertService()
        let imageDownloader = ImageDownloader()
        let presenter = DataListPresenter(view: view, networkService: networkService, errorAlertService: errorAlertService, imageDownloader: imageDownloader)
        view.presenter = presenter
        return view
    }
}

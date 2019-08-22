//
//  SearchDogViewController.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 20/07/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import UIKit

class SearchDogsViewController: UIViewController {
    
    @IBOutlet weak var tableViewController: UIView!
    @IBOutlet weak var mapViewController: UIView!
    
    private let viewModel: SearchDogsViewModel = SearchDogsViewModel()
    
    override func viewDidLoad() {
        self.showMap()
        
        let tableViewController = self.children.filter { $0 is SearchDogsTableViewController }.first as! SearchDogsTableViewController
        let mapViewController = self.children.filter { $0 is SearchDogsMapViewController }.first as! SearchDogsMapViewController
        
        tableViewController.viewModel = self.viewModel
        self.viewModel.delegate = tableViewController
        
        mapViewController.viewModel = self.viewModel
        
        self.viewModel.downloadAllDogs()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    @objc func showTable() {
        self.toggleViewControllers()
        let mapBtn = UIBarButtonItem(title: "Map", style: .plain, target: self, action: #selector(showMap))
        mapBtn.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = mapBtn
    }
    
    @objc func showMap() {
        self.toggleViewControllers()
        let tableBtn = UIBarButtonItem(title:"Table", style: .plain, target: self, action: #selector(showTable))
        tableBtn.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = tableBtn
    }
    
    func toggleViewControllers() {
        self.tableViewController.isHidden = !self.tableViewController.isHidden
        self.mapViewController.isHidden = !self.mapViewController.isHidden
    }
}

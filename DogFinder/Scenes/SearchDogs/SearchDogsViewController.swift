//
//  SearchDogViewController.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 20/07/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import UIKit

class SearchDogsViewController: UIViewController {

    @IBOutlet weak var tableView: UIView!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet var spottedBtn: UIButton!
    @IBOutlet var missingBtn: UIButton!
    private var tableViewController: SearchDogsTableViewController!
    private var mapViewController: SearchDogsMapViewController!

//    private let viewModel: SearchDogsViewModel = SearchDogsViewModel(api: DogFinderApi.sharedInstance)

    override func viewDidLoad() {
        self.showMap()

        self.spottedBtn.dropShadow(backgroundColor: #colorLiteral(red: 0.1624903977, green: 0.3767777085, blue: 0.3000190258, alpha: 1))
        self.missingBtn.dropShadow(backgroundColor: #colorLiteral(red: 0.4178279042, green: 0.6929649711, blue: 0.5753860474, alpha: 1))

        self.tableViewController = self.children.filter { $0 is SearchDogsTableViewController }.first as? SearchDogsTableViewController
        self.mapViewController = self.children.filter { $0 is SearchDogsMapViewController }.first as? SearchDogsMapViewController
    }

    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }

    @objc func showTable() {
        self.toggleViewControllers()
        let mapBtn = UIBarButtonItem(title: "Map", style: .plain, target: self, action: #selector(showMap))
        mapBtn.tintColor = #colorLiteral(red: 0.9551777244, green: 0.8960478902, blue: 0.7618476748, alpha: 1)
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = mapBtn
    }

    @objc func showMap() {
        self.toggleViewControllers()
        let tableBtn = UIBarButtonItem(title: "Table", style: .plain, target: self, action: #selector(showTable))
        tableBtn.tintColor = #colorLiteral(red: 0.9551777244, green: 0.8960478902, blue: 0.7618476748, alpha: 1)
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = tableBtn
    }

    func toggleViewControllers() {
        self.tableView.isHidden = !self.tableView.isHidden
        self.mapView.isHidden = !self.mapView.isHidden
    }

    @IBAction func spottedDitTap(_ sender: UIButton) {

        self.spottedBtn.backgroundColor = #colorLiteral(red: 0.1624903977, green: 0.3767777085, blue: 0.3000190258, alpha: 1)
        self.missingBtn.backgroundColor = #colorLiteral(red: 0.4178279042, green: 0.6929649711, blue: 0.5753860474, alpha: 1)
        self.tableViewController.showSpotted()
        self.mapViewController.showSpotted()
    }

    @IBAction func missingDidTap(_ sender: UIButton) {

        self.spottedBtn.backgroundColor = #colorLiteral(red: 0.4178279042, green: 0.6929649711, blue: 0.5753860474, alpha: 1)
        self.missingBtn.backgroundColor = #colorLiteral(red: 0.1624903977, green: 0.3767777085, blue: 0.3000190258, alpha: 1)
        self.tableViewController.showMissing()
        self.mapViewController.showMissing()
    }
}

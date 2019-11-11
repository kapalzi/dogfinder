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
    @IBOutlet var spottedBtn: UIButton!
    @IBOutlet var missingBtn: UIButton!

    private let viewModel: SearchDogsViewModel = SearchDogsViewModel(api: DogFinderApi.sharedInstance)

    override func viewDidLoad() {
        self.showMap()

        self.spottedBtn.dropShadow(backgroundColor: #colorLiteral(red: 0.1624903977, green: 0.3767777085, blue: 0.3000190258, alpha: 1))
        self.missingBtn.dropShadow(backgroundColor: #colorLiteral(red: 0.4178279042, green: 0.6929649711, blue: 0.5753860474, alpha: 1))

        let tableViewController = self.children.filter { $0 is SearchDogsTableViewController }.first as! SearchDogsTableViewController
        let mapViewController = self.children.filter { $0 is SearchDogsMapViewController }.first as! SearchDogsMapViewController

        tableViewController.viewModel = self.viewModel
        self.viewModel.delegate = tableViewController

        mapViewController.viewModel = self.viewModel

        self.viewModel.downloadNextSpottedDogs {
            tableViewController.tableView.reloadData()
        }
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
        self.viewModel.currentPage = 1 //czy tego potrzebuje?
        self.tableViewController.isHidden = !self.tableViewController.isHidden
        self.mapViewController.isHidden = !self.mapViewController.isHidden
    }

    @IBAction func spottedDitTap(_ sender: UIButton) {

        self.spottedBtn.backgroundColor = #colorLiteral(red: 0.1624903977, green: 0.3767777085, blue: 0.3000190258, alpha: 1)
        self.missingBtn.backgroundColor = #colorLiteral(red: 0.4178279042, green: 0.6929649711, blue: 0.5753860474, alpha: 1)
        self.viewModel.showSpotted()
    }

    @IBAction func missingDidTap(_ sender: UIButton) {

        self.spottedBtn.backgroundColor = #colorLiteral(red: 0.4178279042, green: 0.6929649711, blue: 0.5753860474, alpha: 1)
        self.missingBtn.backgroundColor = #colorLiteral(red: 0.1624903977, green: 0.3767777085, blue: 0.3000190258, alpha: 1)
        self.viewModel.showMissing()
    }
}

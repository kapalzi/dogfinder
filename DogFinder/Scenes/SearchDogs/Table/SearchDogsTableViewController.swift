//
//  SearchDogsTableViewController.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 21/07/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import UIKit
import Kingfisher

class SearchDogsTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: SearchDogsViewModel = SearchDogsViewModel()
    
}

extension SearchDogsTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.viewModel.dogs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchDogsTableViewCell", for: indexPath) as? SearchDogsTableViewCell ?? SearchDogsTableViewCell(style: .default, reuseIdentifier: "SearchDogsTableViewCell")
        
        self.initCell(cell, indexPath: indexPath)
        
        return cell
    }
    
    func initCell(_ cell:SearchDogsTableViewCell, indexPath:IndexPath) {
        
        let dog = self.viewModel.dogs[indexPath.row]
        cell.breedLbl.text = dog.breed
        cell.dateLbl.text = "Last seen: \(dog.seenDate)"
        cell.dogImageView.kf.setImage(with: DogFinderApi.sharedInstance.getUrlOfPhoto(photoName: dog.photoName))
    }
    
}

extension SearchDogsTableViewController: UITableViewDelegate {
    
}

extension SearchDogsTableViewController: SearchDogsViewModelDelegate {
    
    func reloadTableView() {
        
        self.tableView.reloadData()
    }
}
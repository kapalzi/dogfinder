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

    var viewModel: SearchDogsViewModel = SearchDogsViewModel(api: DogFinderApi.sharedInstance)

    private func isLastCell(indexPath: IndexPath) -> Bool {

        if indexPath.row == self.viewModel.dogs.count {
            return true
        } else {
            return false
        }
    }

    private func initCell(_ cell: SearchDogsTableViewCell, indexPath: IndexPath) {

        let dog = self.viewModel.dogs[indexPath.row]
        cell.breedLbl.text = dog.breed
        cell.dateLbl.text = "Last seen: \(dog.seenDate.toString())"
        cell.dogImageView.kf.setImage(with: DogFinderApi.sharedInstance.getUrlOfPhoto(photoName: dog.photoName))
    }

}

extension SearchDogsTableViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.viewModel.dogs.count > 0 ? self.viewModel.dogs.count + 1 : 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if isLastCell(indexPath: indexPath) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadMoreTableViewCell", for: indexPath) as! LoadMoreTableViewCell
            return cell
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchDogsTableViewCell",
                                                 for: indexPath) as? SearchDogsTableViewCell ??
            SearchDogsTableViewCell(style: .default, reuseIdentifier: "SearchDogsTableViewCell")

        self.initCell(cell, indexPath: indexPath)

        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.isLastCell(indexPath: indexPath) && cell is LoadMoreTableViewCell {

            self.viewModel.downloadNextDogs(areSpotted: self.viewModel.areSpotted) {
                self.tableView.reloadData()
            }
        }
    }
}

extension SearchDogsTableViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if !self.isLastCell(indexPath: indexPath) {
            self.presentDogDetails(dog: self.viewModel.dogs[indexPath.row])
        }
    }

    private func presentDogDetails(dog: Dog) {

        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DogDetailsViewController") as! DogDetailsViewController
        vc.initViewModel(dog: dog)

        self.navigationController?.show(vc, sender: nil)
    }
}

extension SearchDogsTableViewController: SearchDogsViewModelDelegate {

    func reloadTableView() {

        self.tableView.reloadData()
    }
}

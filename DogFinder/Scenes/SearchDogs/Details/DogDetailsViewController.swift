//
//  DogDetailsViewController.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 27/10/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import UIKit

class DogDetailsViewController: BaseDetailsViewController {

    private var viewModel: DogDetailsViewModel!
    @IBOutlet var breedLbl: UILabel!
    @IBOutlet var categoryLbl: UILabel!
    @IBOutlet var sizeLbl: UILabel!
    @IBOutlet var colorLbl: UILabel!
    @IBOutlet var genderLbl: UILabel!
    @IBOutlet var depictionTextView: UITextView!

    override func viewDidLoad() {

        self.initControls()
    }

    func initViewModel(dog: Dog) {

        self.viewModel = DogDetailsViewModel(dog: dog)
    }

    override func initControls() {

        super.initControls()
        self.breedLbl.text = self.viewModel.dog.breed
        self.categoryLbl.text = self.viewModel.dog.getStringForCategory()
        self.sizeLbl.text = self.viewModel.dog.getStringForSize()
        self.colorLbl.text = self.viewModel.dog.color
        self.genderLbl.text = self.viewModel.dog.getStringForGender()

//        let navCont = UINavigationController(rootViewController: rootViewController)
//        navCont.navigationBar.tintColor = #colorLiteral(red: 0.9567165971, green: 0.8978132606, blue: 0.7615829706, alpha: 1)
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.9567165971, green: 0.8978132606, blue: 0.7615829706, alpha: 1)
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.width))
        imageView.kf.setImage(with: DogFinderApi.sharedInstance.getUrlOfPhoto(photoName: self.viewModel.dog.photoName))
        return imageView
    }
}

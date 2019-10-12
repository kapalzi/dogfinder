//
//  ConfirmDogViewController.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 12/08/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import UIKit

class ConfirmDogViewController: UIViewController {
    
    private var viewModel: ConfirmDogViewModel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var firstBreedBtn: UIButton!
    @IBOutlet var secondBreedBtn: UIButton!
    @IBOutlet var thirdBreedBtn: UIButton!
    @IBOutlet var typeOwnBtn: UIButton!
    @IBOutlet var saveBtn: UIButton!
    
    override func viewDidLoad() {
     
        self.initControls()
        
    }
    
    private func initControls() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(self.cancelClicked(_:)))
        
        self.navigationItem.rightBarButtonItem?.tintColor = .black
        
        self.imageView.image = self.viewModel.dogPhoto
        
        self.firstBreedBtn.dropShadow()
        self.secondBreedBtn.dropShadow()
        self.thirdBreedBtn.dropShadow()
        self.typeOwnBtn.dropShadow()
        self.saveBtn.dropShadow()
        
        self.firstBreedBtn.setTitle(self.viewModel.dogPredictions[0].buttonTitleString(), for: .normal)
        self.secondBreedBtn.setTitle(self.viewModel.dogPredictions[1].buttonTitleString(), for: .normal)
        self.thirdBreedBtn.setTitle(self.viewModel.dogPredictions[2].buttonTitleString(), for: .normal)
        
    }
    
    func initViewModel(predictions: [DogPrediction], dogPhoto: UIImage) {
        
        self.viewModel = ConfirmDogViewModel(dogPredictions: predictions, dogPhoto: dogPhoto)
        self.viewModel.initLocationManager()
    }
    
    private func setButtonAsSelected(button: UIButton) {
        
        self.clearSelectedButtons()
        button.setTitleColor(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), for: .normal)
    }
    
    private func clearSelectedButtons() {
        
        self.firstBreedBtn.setTitleColor(.darkGray, for: .normal)
        self.secondBreedBtn.setTitleColor(.darkGray, for: .normal)
        self.thirdBreedBtn.setTitleColor(.darkGray, for: .normal)
    }
    
    @IBAction func cancelClicked(_: Any)
    {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func firstBreedClicked(_ sender: UIButton) {
        
        self.viewModel.selectBreed(0) {
            self.setButtonAsSelected(button: self.firstBreedBtn)
        }
    }
    
    @IBAction func secondBreedClicked(_ sender: UIButton) {
        
        self.viewModel.selectBreed(1) {
            self.setButtonAsSelected(button: self.secondBreedBtn)
        }
    }
    
    @IBAction func thirdBreedClicked(_ sender: UIButton) {
        
        self.viewModel.selectBreed(2) {
            self.setButtonAsSelected(button: self.thirdBreedBtn)
        }
    }
    
    @IBAction func typeOwnBreedClicked(_ sender: UIButton) {
        
        self.clearSelectedButtons()
    }
    
    @IBAction func saveClicked(_ sender: UIButton) {
        
        self.viewModel.saveDog {
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
    }
    
}
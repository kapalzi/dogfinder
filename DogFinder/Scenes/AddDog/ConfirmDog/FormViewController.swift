//
//  FormViewController.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 27/10/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import UIKit

class FormViewController: BaseDetailsViewController, UITextViewDelegate {

    private var viewModel: FormViewModel!
    @IBOutlet var breedBtn: UIButton!
    @IBOutlet var categoryBtn: UIButton!
    @IBOutlet var sizeBtn: UIButton!
    @IBOutlet var colorBtn: UIButton!
    @IBOutlet var genderBtn: UIButton!
    @IBOutlet var depictionTextVIew: UITextView!
    @IBOutlet var saveView: UIView!

    override func viewDidLoad() {

        self.initControls()
    }

    func initViewModel(predictions: [DogPrediction], dogPhoto: UIImage) {

        self.viewModel = FormViewModel(api: DogFinderApi.sharedInstance, dogPredictions: predictions, dogPhoto: dogPhoto)
        self.viewModel.initLocationManager()
    }

    override func initControls() {

        super.initControls()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(self.cancelClicked(_:)))

        self.saveView.dropShadow(backgroundColor: #colorLiteral(red: 0.1612432003, green: 0.3702685833, blue: 0.3063940406, alpha: 1))
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.width))
        imageView.image = self.viewModel.dogPhoto
        imageView.contentMode = .scaleAspectFit
        return imageView
    }

    private func showBreedsAlert() {

        let ac = UIAlertController(title: "Select Breed", message: nil, preferredStyle: .alert)

        for (index, prediction) in self.viewModel.dogPredictions.enumerated() {

            ac.addAction(UIAlertAction(title: prediction.buttonTitleString(), style: .default, handler: { (_) in
                self.viewModel.selectBreed(index) {
                    self.breedBtn.setTitle(prediction.breed, for: .normal)
                }
            }))
        }

        ac.addAction(UIAlertAction(title: "Type own breed", style: .default, handler: { (_) in
            self.showOwnBreedAlert()
        }))

        self.startAlertWithCancel(ac: ac)
    }

    private func showColorAlert() {

        let ac = UIAlertController(title: "Color", message: nil, preferredStyle: .alert)
        ac.addTextField { (textField) in
            textField.placeholder = "Type dog's color"
            textField.backgroundColor = #colorLiteral(red: 0.4178279042, green: 0.6929649711, blue: 0.5753860474, alpha: 1)
            textField.superview?.backgroundColor = #colorLiteral(red: 0.4178279042, green: 0.6929649711, blue: 0.5753860474, alpha: 1)
            textField.textColor = #colorLiteral(red: 0.9551777244, green: 0.8960478902, blue: 0.7618476748, alpha: 1)
        }

        ac.addAction(UIAlertAction(title: "Save", style: .destructive, handler: { (_) in
            let textField = ac.textFields![0] as UITextField
            self.viewModel.setColor(color: textField.text ?? "") {
                self.colorBtn.setTitle(textField.text, for: .normal)
            }
        }))

        self.startAlertWithCancel(ac: ac)
    }

    private func showOwnBreedAlert() {

        let ac = UIAlertController(title: "Breed", message: nil, preferredStyle: .alert)
        ac.addTextField { (textField) in
            textField.placeholder = "Type dog's breed"
            textField.backgroundColor = #colorLiteral(red: 0.4178279042, green: 0.6929649711, blue: 0.5753860474, alpha: 1)
            textField.superview?.backgroundColor = #colorLiteral(red: 0.4178279042, green: 0.6929649711, blue: 0.5753860474, alpha: 1)
            textField.textColor = #colorLiteral(red: 0.9551777244, green: 0.8960478902, blue: 0.7618476748, alpha: 1)
        }

        ac.addAction(UIAlertAction(title: "Save", style: .destructive, handler: { (_) in
            let textField = ac.textFields![0] as UITextField
            self.viewModel.setOwnBreed(breed: textField.text ?? "") {
                self.breedBtn.setTitle(textField.text, for: .normal)
            }
        }))

        self.startAlertWithCancel(ac: ac)
    }

    private func showCategoriesAlert() {

        let ac = UIAlertController(title: "Select Category", message: nil, preferredStyle: .alert)

        for (index, element) in self.viewModel.categories.enumerated() {

           ac.addAction(UIAlertAction(title: element, style: .default, handler: { (_) in
               self.viewModel.selectCategory(index) {
                   self.categoryBtn.setTitle(element, for: .normal)
               }
           }))
       }
        self.startAlertWithCancel(ac: ac)
    }

    private func showSizesAlert() {

        let ac = UIAlertController(title: "Select Size", message: nil, preferredStyle: .alert)

         for (index, element) in self.viewModel.sizes.enumerated() {

            ac.addAction(UIAlertAction(title: element, style: .default, handler: { (_) in
                self.viewModel.selectSize(index) {
                    self.sizeBtn.setTitle(element, for: .normal)
                }
            }))
        }

        self.startAlertWithCancel(ac: ac)
    }

    private func showGendersAlert() {

        let ac = UIAlertController(title: "Select Gender", message: nil, preferredStyle: .alert)

         for (index, element) in self.viewModel.genders.enumerated() {

            ac.addAction(UIAlertAction(title: element, style: .default, handler: { (_) in
                self.viewModel.selectGender(index) {
                    self.genderBtn.setTitle(element, for: .normal)
                }
            }))
        }

        self.startAlertWithCancel(ac: ac)
    }

    private func showMessageAlert(withMessage message: String) {

        let ac = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (_) in
            self.navigationController?.dismiss(animated: true, completion: nil)
        }))

        self.startAlert(ac: ac)
    }

    private func showErrorAlert(withMessage message: String) {

        let ac = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))

        self.startAlert(ac: ac)
    }

    private func startAlertWithCancel(ac: UIAlertController) {
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.startAlert(ac: ac)
    }

    private func startAlert(ac: UIAlertController) {

        ac.setBackgroundColor(color: #colorLiteral(red: 0.1624903977, green: 0.3767777085, blue: 0.3000190258, alpha: 1))
        ac.setTitleColor(color: #colorLiteral(red: 0.9551777244, green: 0.8960478902, blue: 0.7618476748, alpha: 1))
        ac.setTint(color: #colorLiteral(red: 0.9551777244, green: 0.8960478902, blue: 0.7618476748, alpha: 1))
        self.present(ac, animated: true, completion: nil)
    }

    @IBAction func cancelClicked(_: Any) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }

    @IBAction func breedBtnDidTap(_ sender: UIButton) {
        self.showBreedsAlert()
    }

    @IBAction func categoryBtnDidTap(_ sender: UIButton) {
        self.showCategoriesAlert()
    }

    @IBAction func sizeBtnDidTap(_ sender: UIButton) {
        self.showSizesAlert()
    }

    @IBAction func colorBtnDidTap(_ sender: UIButton) {
        self.showColorAlert()
    }

    @IBAction func genderBtnDidTap(_ sender: UIButton) {
        self.showGendersAlert()
    }

    @IBAction func saveBtnDidTap(_ sender: UIButton) {
        self.viewModel.saveDog(completion: { (message) in
            self.showMessageAlert(withMessage: message)
        }) { (errorMessage) in
            self.showErrorAlert(withMessage: errorMessage)
        }
    }

    func textViewDidChange(_ textView: UITextView) {
        self.viewModel.setDepiciton(text: textView.text)
    }

}

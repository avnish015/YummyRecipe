
//
//  NewRecipeViewController.swift
//  YummyRecipe
//
//  Created by Avnish on 01/02/21.
//

import UIKit

class NewRecipeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var ingredientTableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var recipeNameTextField: UITextField!
    @IBOutlet weak var recipeDescriptionTextView: UITextView!
    @IBOutlet weak var recipeStepsTextView: UITextView!
    
    var ingredients = [String]()
    var selectedImageURL = ""
    var isVeg = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addIngredients(_ sender:UIButton) {
        let alertController = UIAlertController(title: "Add Ingredient", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            
        }
        alertController.addAction(UIAlertAction(title: "Done", style: .cancel, handler: {[unowned self] (action) in
            if let text = alertController.textFields?.first?.text  {
                if !text.isEmpty {
                    ingredients.append(text)
                    ingredientTableView.reloadData()
                }
                
            }
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func addImageButtonTapped(_ sender: UIButton) {
        openImagePickerController()
    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        if let recipeName = recipeNameTextField.text, let description = recipeDescriptionTextView.text, let recipeSteps = recipeStepsTextView.text {
            let recipe = Recipe(foodCategory: isVeg, ingredients: ingredients, recipeDescription: description, recipeImageURL: selectedImageURL, recipeName: recipeName, steps: recipeSteps)
            recipe.saveRecipe()
        }
    }
    
    @IBAction func vegNonVegSegmentControllerChangedSelection(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            isVeg = true
        }else {
            isVeg = false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientTableViewCell") else {
            return UITableViewCell()
        }
        cell.textLabel?.text = ingredients[indexPath.row]
        return cell
    }
    
    func openImagePickerController() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.mediaTypes = ["public.image"]
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        }else {
            imagePicker.sourceType = .photoLibrary
        }
        self.present(imagePicker, animated: true, completion: nil)
    }

}

extension NewRecipeViewController:UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(info)
        print(info[UIImagePickerController.InfoKey.imageURL])
        if let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL, let data = try? Data(contentsOf: imageURL) {
            self.recipeImageView.image = UIImage(data: data)
            self.selectedImageURL = imageURL.absoluteString

        }
        picker.dismiss(animated: true, completion: nil)

    }
    
}

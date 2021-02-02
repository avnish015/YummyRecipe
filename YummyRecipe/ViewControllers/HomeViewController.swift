//
//  HomeViewController.swift
//  YummyRecipe
//
//  Created by Avnish on 29/01/21.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    @IBOutlet weak var recipeListTableView: UITableView!
    
    var recipeList = [Recipe]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        var recipe = Recipe(foodCategory: true, ingredients: ["Egg"], recipeDescription: "Prepare it well", recipeImageURL: "", recipeName: "Egg curry", steps: "Cook it well")
//        recipe.saveRecipe()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateRecipeList()
    }
    
    func updateRecipeList() {
        Recipe.fetchRecipeList {[unowned self] (recipes) in
            print(recipes)
            recipeList = recipes
            DispatchQueue.main.async {
                recipeListTableView.reloadData()
            }
        }
    }
    
    @IBAction func signoutButtonCalled(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "Login")
//            self.present(vc, animated: true, completion: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }catch {
            Utility.sharedInstance.showAlert(vc: self, messageText: error.localizedDescription, titleText: "Error")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipeList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeListTableViewCell") as? RecipeListTableViewCell else {
            return UITableViewCell()
        }
        
        let object = recipeList[indexPath.row]
        cell.recipeNameLabel.text = object.recipeName
        cell.recipeDescription.text = object.recipeDescription
        if let urlString = object.recipeImageURL, let url = URL(string: urlString) {
            DispatchQueue.global(qos: .background).async {
                if let imageData = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        let image = UIImage(data: imageData)
                        cell.recipeImageView.image = image
                    }
                }
            }
        }
        return cell
    }
}

//
//  Recipe.swift
//  YummyRecipe
//
//  Created by Avnish on 31/01/21.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

public class Recipe:Codable {
    var recipeId:String = ""
    var foodCategory:Bool
    var ingredients:[String]
    var recipeDescription:String
    var recipeImageURL:String?
    var recipeName:String
    var steps:String
    
    init(foodCategory:Bool, ingredients:[String], recipeDescription:String, recipeImageURL:String, recipeName:String, steps:String) {
        self.foodCategory = foodCategory
        self.ingredients = ingredients
        self.recipeDescription = recipeDescription
        self.recipeImageURL = recipeImageURL
        self.recipeName = recipeName
        self.steps = steps
    }
    
    init?(dict:[String:Any]) {
        if let recipeId = dict["recipeId"] as? String, let foodCategory = dict["foodCategory"] as? Bool, let ingredients = dict["ingredients"] as? [String], let recipeDescription = dict["recipeDescription"] as? String, let recipeName = dict["recipeName"] as? String, let steps = dict["steps"] as? String {
//            print(dict)
            self.recipeId = recipeId
            self.foodCategory = foodCategory
            self.ingredients = ingredients
            self.recipeDescription = recipeDescription
            self.recipeImageURL = dict["recipeImageURL"] as? String
            self.recipeName = recipeName
            self.steps = steps
        }else {
            return nil
        }
    }
    
    static func fetchRecipeList(completion:@escaping ([Recipe])->Void) {
        let db = Firestore.firestore()
        db.collection("Recipe").getDocuments { (snapshot, error) in
            if let error = error {
                print(error.localizedDescription)
                completion([Recipe]())
            }else {
                var recipeList = [Recipe]()
                if let documents = snapshot?.documents {
                    for document in documents {
                        let recipe = Recipe(dict: document.data())
                        if let recipe = recipe {
                            recipeList.append(recipe)
                        }
                    }
                }
                completion(recipeList)
            }
        }
        return
    }
    
     func saveRecipe() {
        let db = Firestore.firestore()
        let document = db.collection("Recipe").document()
        self.recipeId = document.documentID
        document.setData(["recipeId":document.documentID, "foodCategory":self.foodCategory, "ingredients":self.ingredients, "recipeDescription":self.recipeDescription, "recipeImageURL":self.recipeImageURL ?? "", "recipeName":self.recipeName, "steps":self.steps]) {error in
            if let error = error {
                print("\(error.localizedDescription)")
            }else {
                self.saveImage()
            }
        }
    }
    
     func saveImage() {
        var reference = Storage.storage().reference()
        reference = reference.child("Images/\(recipeId).png")
        if let url = URL(string:self.recipeImageURL ?? "") {
            reference.putFile(from: url, metadata: nil){(result, error) in
                if let error = error {
                    print(error.localizedDescription)
                }else {
                    reference.downloadURL { (url, error) in
                        self.recipeImageURL = url?.path
                    }
                }
            }
        }
    }
}

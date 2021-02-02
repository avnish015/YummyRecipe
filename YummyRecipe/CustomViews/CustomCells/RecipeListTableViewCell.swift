//
//  RecipeListTableViewCell.swift
//  YummyRecipe
//
//  Created by Avnish on 31/01/21.
//

import UIKit

class RecipeListTableViewCell: UITableViewCell {

    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeDescription: UILabel!
    @IBOutlet weak var recipeNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

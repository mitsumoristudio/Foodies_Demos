//
//  RecipeListView.swift
//  Foodies_Demo
//
//  Created by Satoshi Mitsumori on 10/5/24.
//

import SwiftUI

struct RecipeListView : View {
    @StateObject var recipeVM = RecipeViewModel()
    
    var body: some View {
        NavigationStack {
                
                if recipeVM.isLoading {
                    ProgressView()
                    
                } else if let recipe = recipeVM.recipes {
                    
                    List(recipe.recipes, id: \.uuid) { items in
                        Text(items.name)
                    }
                }
            
        }
        .navigationTitle("Recipes")
        
        .onAppear {
            recipeVM.fetchAllRecipes()
        }
    }
}


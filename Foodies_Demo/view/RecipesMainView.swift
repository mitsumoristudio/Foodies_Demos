//
//  RecipesMainView.swift
//  Foodies_Demo
//
//  Created by Satoshi Mitsumori on 10/8/24.
//

import SwiftUI

struct RecipesMainView: View {
    @StateObject var recipeVM = RecipeViewModel()
    @State var isToggleSearchText: Bool = false
    @State var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 5) {
                
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 16) {
                        
                        if recipeVM.isLoading {
                            ProgressView()
                            
                        } else {
                        //    if searchText.isEmpty {
                                ForEach(recipeVM.filteredRecipes, id: \.uuid) { items in
                                    
                                    NavigationLink(destination: {
                                        RecipeCard(recipes: items)
                                    }, label: {
                                        RecipeGridCell(recipes: items)
                                        
                                    })
                                }
                        }
                    }
//                    .navigationTitle("World Recipes")
//                    .navigationBarTitleDisplayMode(.automatic)
//                    .ignoresSafeArea()
                }
                .searchable(text: $searchText, prompt: "Search Cuisine")
                
                .onChange(of: searchText) { searchText, _ in
                    isToggleSearchText.toggle()
                    recipeVM.filterData(query: searchText)
                }
            }
        }
        .onAppear {
            recipeVM.fetchAllRecipes()
        }
        
    }
}


struct RecipeMainView_Preview: PreviewProvider {
    static var previews: some View {
        RecipesMainView()
    }
}

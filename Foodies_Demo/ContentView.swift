//
//  ContentView.swift
//  Foodies_Demo
//
//  Created by Satoshi Mitsumori on 10/5/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewmodel = RecipeViewModel()
    var body: some View {
        VStack {
            RecipesMainView(recipeVM: viewmodel)
        }
    }
}

struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

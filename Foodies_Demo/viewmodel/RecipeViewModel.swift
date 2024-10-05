
import Foundation
import SwiftUI
import Combine

final class RecipeViewModel: ObservableObject {
    var recipes: RecipeModel?
    @Published var filteredRecipes: [Recipe] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var searchTextBox: String = ""
    
    
    
    @Published var foodrecipesVM: [Recipe] = []
  //  @Published var filteredrecipes: RecipeModel?
    var cancellables = Set<AnyCancellable>()
    
    init() {
        
    }
    
    func fetchAllRecipes() {
        
        isLoading = true
        
        guard let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json") else {
            fatalError("Missing URL")
        }
        
        let urlRequest = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                print("Request error", error)
                return
            }
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                guard let data = data else { return }
                
                DispatchQueue.main.async {
                    do {
                        var result = try? JSONDecoder().decode(RecipeModel.self, from: data)
                        self.isLoading = false
                        
                        result?.recipes.sort(by: { o1, o2 in
                            o1.name < o2.name
                        })
                        self.filteredRecipes = result?.recipes ?? []
                        
                        if let result = result {
                            
                            result.recipes.forEach { items in
                                print(items.name)
                                
                                print(items.cuisine)
                            }
                        }
                        self.recipes = result
                        
                    } catch let error {
                        self.errorMessage = error.localizedDescription
                    }
                }
            }
        }
        dataTask.resume()
    }
    
  
    func filterData(query: String){
        if(query.isEmpty) {
            self.filteredRecipes = self.recipes?.recipes ?? []
        }
        else{
            self.filteredRecipes = self.recipes?.recipes.filter{ recipe in
                recipe.cuisine.lowercased().contains(query.lowercased())
            } ?? []
        }
    }
    
    func fetchwithCombine() {
        guard let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json") else { return }
                
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) -> Data in
                guard let response = response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: RecipeModel.self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion {
                    
                case .finished:
                    print("Finished")
                case .failure( let error):
                    print("There was an error \(error)")
                }
            } receiveValue: { [weak self] returnedPost in
                
                self?.recipes = returnedPost
                
                returnedPost.recipes.forEach { items in
                    print(items.name)
                }
            }
            .store(in: &cancellables)
    }
}

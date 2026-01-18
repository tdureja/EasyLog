//
//  CategorySelectionView.swift
//  EasyLog
//
//  Created by Tejvir Dureja on 1/15/26.
//

import SwiftUI

struct CategorySelectionView: View {
    @Binding var selectedCategory: String?
    @Binding var savedCategories: [String]
    
    @State private var newCategoryName = ""
    
    var body: some View {
        
        VStack{
            Text("Please Select a Category for Your Workout")
            
            ForEach(savedCategories, id: \.self){ category in
                Button {
                    selectedCategory = category
                } label: {
                    Text(category)
                }
            }
            
            TextField("New category", text: $newCategoryName)
                .textFieldStyle(.roundedBorder)
            
            Button("Add & Continue"){
                let clean = newCategoryName.trimmingCharacters(in: .whitespacesAndNewlines)
                let final = clean.capitalized
                
                guard !final.isEmpty else { return}
                guard !savedCategories.contains(where: { $0.lowercased() == final.lowercased()}) else {
                    selectedCategory = final
                    return
                }
                
                savedCategories.append(final)
                selectedCategory = final
            }
            .disabled(newCategoryName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }
        
        
    }
}

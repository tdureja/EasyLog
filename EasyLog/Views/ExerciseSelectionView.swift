//
//  ExerciseSelectionView.swift
//  EasyLog
//
//  Created by Tejvir Dureja on 2/6/26.
//

import Foundation
import SwiftUI

struct ExerciseSelectionView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding var selectedExercise: ExerciseDefinition?
    @Binding var savedExerciseDefinitions: [ExerciseDefinition]
    @State private var highlightedDefinition: ExerciseDefinition?
    @State private var showNewExerciseAlert = false
    @State private var newExerciseName = ""
    
    var body: some View {
        
        // list of exercises that can be chosen
        // for exercise in exercisedefinitions if exercise.categories contains selected category then list exercise else continue

        VStack {
            ScrollView{
                VStack{
                    
                    ForEach(savedExerciseDefinitions){definition in
                        Button {
                            highlightedDefinition = definition
                        } label: {
                            Text(definition.name)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .background(highlightedDefinition?.id == definition.id
                                            ? Color.blue.opacity(0.2)
                                            :Color.clear
                                )
                        }
                    }
                    .padding(.top, 20)
                    
                    // add exercise button similar to add workout category button
                }
            }
            
            Button("Confirm Selection"){
                guard let definition = highlightedDefinition else { return }
                
                selectedExercise = definition
                dismiss()
            }
            .padding(.bottom, 20)
        }
        .navigationTitle("Select Exercise")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button{
                    showNewExerciseAlert = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .alert("New Exercise", isPresented: $showNewExerciseAlert){
            TextField("Exercise Name", text: $newExerciseName)
            
            Button("Add"){
                let clean = newExerciseName.trimmingCharacters(in: .whitespacesAndNewlines)
                let final = clean.capitalized
                
                guard !final.isEmpty else {return}
                guard !savedExerciseDefinitions.contains(where: {
                    $0.name.lowercased() == final.lowercased()
                }) else {
                    selectedExercise = savedExerciseDefinitions.first(where: {
                        $0.name.lowercased() == final.lowercased()
                    })
                    return
                }
                
                let newDefinition = ExerciseDefinition(name: final)
                savedExerciseDefinitions.append(newDefinition)
                selectedExercise = newDefinition
                newExerciseName = ""
            }
            
            Button("Cancel", role: .cancel){
                newExerciseName = ""
            }
        }

    }
}

//    .alert("New Category", isPresented: $showNewCategoryAlert){
//        
//        TextField("Category Name", text: $newCategoryName)
//        
//        Button("Add"){
//            let clean = newCategoryName.trimmingCharacters(in: .whitespacesAndNewlines)
//            let final = clean.capitalized
//            
//            guard !final.isEmpty else { return }
//            guard !savedCategories.contains(where: {
//                $0.lowercased() == final.lowercased()}) else {
//                selectedCategory = final
//                return
//            }
//            
//            savedCategories.append(final)
//            selectedCategory = final
//        }
//        
//        Button("Cancel", role: .cancel){
//            newCategoryName = ""
//        }
//    }



#Preview {
    ContentView()
}


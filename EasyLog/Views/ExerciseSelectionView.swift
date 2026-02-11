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
    
    var body: some View {
        Text("Hello, World!")
        
        // list of exercises that can be chosen
        // for exercise in exercisedefinitions if exercise.categories contains selected category then list exercise else continue
        ScrollView{
            VStack{
                
                Text("Count: \(savedExerciseDefinitions.count)")
                
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
                
                // add exercise button similar to add workout category button
            }
        }
        
        Button("Confirm Selection"){
            guard let definition = highlightedDefinition else { return }
            
            selectedExercise = definition
            dismiss()
        }
        //TODO: complete view. list excercise definitions
        //TODO: highlight def on click
        //TODO: confirm selection button
    }
}



//
//  ExerciseDetailView.swift
//  EasyLog
//
//  Created by Tejvir Dureja on 1/15/26.
//

import SwiftUI

struct ExerciseDetailView: View{
    @Binding var exercise: WorkoutExercise

    
    
    var body: some View{
        VStack{
            Text("Exercise Detail")
            
            Picker("Unit", selection: $exercise.unit){
                ForEach(WeightUnit.allCases){ unit in
                    Text(unit.rawValue.uppercased())
                        .tag(unit)
                }
            }
            .pickerStyle(.segmented)
            .padding()

            List{
                ForEach(exercise.sets.indices, id: \.self){ index in
                    
                    let set = $exercise.sets[index]
                    // ISSUE: set 1 weight/reps carry over to each added set
                    HStack {
                        Text("Set \(index + 1)")
                        
                        Spacer()
                        
                        TextField("0", value: set.reps, format: .number)
                            .keyboardType(.numberPad)
                            .frame(width:30)
                        
                        Text("x")
                            .foregroundColor(.secondary)
                        
                        HStack(spacing: 4){
                            TextField("0", value: set.weight, format: .number)
                                .keyboardType(.decimalPad)
                                .frame(width: 40)
                                
                            Text(exercise.unit.rawValue)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                    }
                }
                .onDelete{ offsets in
                    exercise.sets.remove(atOffsets: offsets)}
            }
            
            Button("Add Set"){
                exercise.sets.append(
                    SetEntry(id: UUID(), weight: 0, reps: 0))
            }
        }
    }
}


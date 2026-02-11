//
//  ActiveWorkoutView.swift
//  EasyLog
//
//  Created by Tejvir Dureja on 1/15/26.
//
import SwiftUI


struct ActiveWorkoutView: View{
    
    @Environment(\.dismiss) var dismiss
    @Binding var savedWorkouts: [Workout]
    @Binding var savedExerciseDefinitions: [ExerciseDefinition]
    @Binding var selectedCategory: String?
    @Binding var isStartingWorkout: Bool
    
    @State private var isAddingExercise: Bool = false
    @State private var selectedExercise: ExerciseDefinition? = nil
    @State private var showDiscardAlert = false
    @State var exercises: [WorkoutExercise]
    
    

    var body: some View{
        VStack{
            Text("Active Workout")
            
            Text(selectedCategory ?? "")
                .font(.headline)
                // id replaced later with real ids
            ScrollView{
                VStack{
                    ForEach($exercises){ $exercise in
                        NavigationLink{
                            ExerciseDetailView(exercise: $exercise)
                        } label: {
                            Text(exercise.definition.name)
                        }
                    }
                }
            }
            
            Button("Add Exercise"){
                //TODO: add exercise logic
                isAddingExercise = true
            }
            
            
            
            Button("End Workout"){
                if let index = savedWorkouts.firstIndex(where: { workout in
                    Calendar.current.isDateInToday(workout.workoutDate)
                }){
                    // replace workout
                    savedWorkouts[index] = Workout(id: savedWorkouts[index].id, workoutDate: savedWorkouts[index].workoutDate, category: savedWorkouts[index].category, exercises: exercises)
                } else {
                    //append workout
                    guard let category = selectedCategory else{
                        return
                    }
                    savedWorkouts.append(Workout(id: UUID(), workoutDate: Date(), category: category, exercises: exercises))
                    
                }
                selectedCategory = nil
                isStartingWorkout = false
                dismiss()
                print(savedWorkouts.count)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading){
                Button("Back"){
                    showDiscardAlert = true
                }
            }
        }
        .alert("Discard Workout?", isPresented: $showDiscardAlert){
            
            Button("Cancel", role: .cancel){ }
            Button("Discard", role: .destructive){
                exercises.removeAll()
                selectedCategory = nil
                isStartingWorkout = false
                dismiss()
            }
        }
        .navigationDestination(isPresented: $isAddingExercise){
            ExerciseSelectionView(
                selectedExercise: $selectedExercise,
                savedExerciseDefinitions: $savedExerciseDefinitions
            )
        }
        .onChange(of: selectedExercise){
            
            guard let definition = selectedExercise else { return }
            
            let alreadyExists = exercises.contains{
                $0.definition.id == definition.id
            }
            
            if !alreadyExists{
                let newWorkoutExercise = WorkoutExercise(
                    id: UUID(),
                    definition: definition,
                )
                exercises.append(newWorkoutExercise)
            }
                        
            selectedExercise = nil
            isAddingExercise = false
        }
    }
}


#Preview {
    ContentView()
}


//    .navigationDestination(isPresented: $isStartingWorkout){
//        if selectedCategory == nil{
//            CategorySelectionView(selectedCategory: $selectedCategory, savedCategories: $savedCategories)
//        } else{
//            ActiveWorkoutView(
//                savedWorkouts: $savedWorkouts,
//                selectedCategory: $selectedCategory,
//                isStartingWorkout: $isStartingWorkout,
//                exercises: []
//                )
//        }
//    }

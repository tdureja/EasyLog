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
    @Binding var selectedCategory: String?
    @Binding var isStartingWorkout: Bool
    
    @State var exercises: [Exercise]


    var body: some View{
        VStack{
            Text("Active Workout")
                // id replaced later with real ids
            List{
                ForEach($exercises){ $exercise in NavigationLink {
                        ExerciseDetailView(exercise: $exercise)
                } label: {
                    Text(exercise.name)
                }
            }
            .onDelete{ offsets in
                exercises.remove(atOffsets: offsets)}
        }
            
            Button("Add Exercise"){
                let nextId = exercises.count + 1
                exercises.append(Exercise(id: nextId, name: "Exercise \(nextId)", sets: []))
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
    }
}

#Preview {
    ContentView()
}

//
//  HistoryView.swift
//  EasyLog
//
//  Created by Tejvir Dureja on 1/15/26.
//

import SwiftUI

struct CalendarView: View{
    @Binding var savedWorkouts: [Workout]
    
    var body: some View{
        VStack{
            Text("Workout History")
            
            NavigationStack{
                List{
                    ForEach(savedWorkouts){ workout in
                        NavigationLink{
                            PastWorkoutView(workout: workout)
                        } label: {
                            VStack{
                                Text(formatDate(workout.workoutDate))
                                    .font(.title2)
    //                                .bold()
                                Text(workout.category)
                                    .font(.title3)
                                    .foregroundColor(.secondary)// placeholder; use date formatter later
                            }
                        }
                        
                    }
                    .onDelete { offsets in
                        savedWorkouts.remove(atOffsets:offsets)
                    }
                    
                }
            }
        }
        
    }
}

#Preview {
    ContentView()
}

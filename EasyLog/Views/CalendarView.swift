//
//  HistoryView.swift
//  EasyLog
//
//  Created by Tejvir Dureja on 1/15/26.
//

import SwiftUI

struct CalendarView: View{
    let savedWorkouts: [Workout]
    
    var body: some View{
        VStack{
            Text("Workout History")
            
            NavigationStack{
                List{
                    ForEach(savedWorkouts){ workout in
                        NavigationLink{
                            PastWorkoutView(workout: workout)
                        } label: {
                            Text(workout.workoutDate.description) // placeholder; use date formatter later
                        }
                        
                    }
                }
            }
        }
        
    }
}

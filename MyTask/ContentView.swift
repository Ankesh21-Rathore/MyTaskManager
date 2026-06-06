//
//  Challenge3.swift
//  Challenge
//
//  Created by mac on 03/05/26.
//

import SwiftUI

struct HabitActivity: Identifiable, Codable {
    var id = UUID()
    var name: String
    var type: String
    var description: String
    var completionCount: Int = 0
}

@Observable
class Habits {
    var items = [HabitActivity]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "items")
            }
        }
    }
    init() {
        if let savedHabits = UserDefaults.standard.data(forKey: "items") {
            if let decodedHabits = try? JSONDecoder().decode([HabitActivity].self, from: savedHabits) {
                items = decodedHabits
                return
            }
        }
    }
}

struct ContentView: View {
    @State private var habit = Habits()
    @State private var showingNewSheet = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.brown, .white, .brown], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack {
                    Form {
                        ForEach(habit.items) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.description)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    Text("Completed: \(item.completionCount)")
                                        .font(.caption)
                                        .fontWeight(.bold)
                                }
                                
                                Spacer()
                                
                                Button {
                                    if let index = habit.items.firstIndex(where: { $0.id == item.id }) {
                                        habit.items[index].completionCount += 1
                                    }
                                } label: {
                                    if item.completionCount > 0 {
                                        Image(systemName: "checkmark.circle.fill")
                                            .font(.title2)
                                            .foregroundColor(.green)
                                    } else {
                                        Image(systemName: "circle")
                                            .font(.title2)
                                            .foregroundColor(.gray)
                                    }
                                }
                                .buttonStyle(.borderless) // Important: Prevents the whole row from triggering the button click
                            }
                        }
                        .onDelete(perform: removeItems)
                    }
                    
                    .navigationTitle("My Task")
                    .scrollContentBackground(.hidden)
                    .toolbar {
                        
                        ToolbarItem(placement: .topBarLeading) {
                            Button("Clear All", role: .destructive) {
                                if !showingNewSheet {
                                    habit.items.removeAll()
                                }
                            }
                            .foregroundColor(.red)
                        }
                        
                        
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                showingNewSheet = true
                            } label: {
                                Label("Add", systemImage: "plus")
                            }
                        }
                    }
                    .sheet(isPresented: $showingNewSheet) {
                        TaskView(habit: habit)
                    }
                }
            }
        }
    }
    func removeItems(at offsets: IndexSet) {
        habit.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}

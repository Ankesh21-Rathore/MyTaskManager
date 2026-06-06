import SwiftUI

struct TaskView: View {
    @Environment(\.dismiss) var dismiss
    
    // 1. This is the correct instance passed from ContentView
    var habit: Habits
    
    @State private var name = ""
    @State private var description = ""
    @State private var type = "Read"
    
    let types = ["Read", "Practice", "Implement", "Coding","Assignment", "PPT", "Sports", "Other"]
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.brown, .white, .brown], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack {
                    Form {
                        TextField("Title or Topic", text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
                        HStack{
                            Picker("Type of Task", selection: $type) {
                                ForEach(types, id: \.self) {
                                    Text($0)
                                }
                            }
                        }
                        .foregroundStyle(
                            LinearGradient(colors: [.brown, .blue, .brown], startPoint: .leading, endPoint: .trailing)
                        )

                        TextField("Details", text: $description)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .toolbar {
                                Button("Save") {
                                    let item = HabitActivity(name: name, type: type, description: description)
                                    
                                    // 2. FIXED: Append directly to 'habit' instead of 'things'
                                    habit.items.append(item)
                                    
                                    dismiss()
                                }
                                .foregroundColor(.blue)
                            }
                    }
                }
                .navigationTitle("Add New")
                .navigationBarTitleDisplayMode(.inline)
                .scrollContentBackground(.hidden)
            }
        }
    }
}

#Preview {
    TaskView(habit: Habits())
}

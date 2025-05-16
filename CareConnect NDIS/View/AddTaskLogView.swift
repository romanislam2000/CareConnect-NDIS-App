import SwiftUI
import FirebaseFirestore

struct AddTaskLogView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: TaskLogViewModel

    @State private var clientName = ""
    @State private var date = Date()
    @State private var taskStatus: TaskStatus = .pending
    @State private var notes = ""

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 75 / 255, green: 33 / 255, blue: 66 / 255) // #4b2142
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    Text("New Task Log")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                        .padding(.top)

                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(red: 75 / 255, green: 33 / 255, blue: 66 / 255))
                        .shadow(color: Color.black.opacity(0.3), radius: 15, x: 10, y: 10)
                        .shadow(color: Color.white.opacity(0.3), radius: 8, x: -5, y: -5)
                        .frame(width: 340)
                        .overlay(
                            VStack(spacing: 16) {
                                TextField("Client Name", text: $clientName)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(10)

                                DatePicker("Date", selection: $date, displayedComponents: .date)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(10)

                                Picker("Task Status", selection: $taskStatus) {
                                    ForEach(TaskStatus.allCases, id: \.self) { status in
                                        Text(status.rawValue.capitalized)
                                    }
                                }
                                .pickerStyle(SegmentedPickerStyle())
                                .padding(.vertical, 4)

                                TextEditor(text: $notes)
                                    .frame(height: 100)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(10)

                                Button("Save") {
                                    let data: [String: Any] = [
                                        "clientName": clientName,
                                        "date": Timestamp(date: date),
                                        "tasksCompleted": [taskStatus.rawValue],
                                        "notes": notes
                                    ]
                                    viewModel.addLog(data)
                                    dismiss()
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.indigo)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                            }
                            .padding()
                        )
                }
                .padding()
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}

enum TaskStatus: String, CaseIterable {
    case pending
    case completed
}

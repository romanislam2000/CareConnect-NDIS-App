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
                Color(red: 0/255, green: 49/255, blue: 83/255) // #003153
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    Text("📝 New Task Log")
                        .font(.largeTitle.bold())
                        .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                        .padding(.top)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)

                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(red: 0/255, green: 49/255, blue: 83/255))
                        .shadow(color: Color.black.opacity(0.3), radius: 15, x: 10, y: 10)
                        .shadow(color: Color.white.opacity(0.3), radius: 8, x: -5, y: -5)
                        .frame(width: 340)
                        .overlay(
                            VStack(spacing: 16) {
                                GroupBox(label: Text("CLIENT").font(.caption)) {
                                    Menu {
                                        ForEach(clientViewModel.clients) { client in
                                            Button(action: {
                                                selectedClient = client
                                            }) {
                                                  Text(client.name)
                                               }
                                        }
                                   } label: {
                                        Text(selectedClient?.name ?? "Select Client")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(12)
                                        .background(Color(red: 248/255, green: 236/255, blue: 199/255))
                                        .cornerRadius(8)
                                   }
                                }

                                DatePicker("Date", selection: $date, displayedComponents: .date)
                                    .padding()
                                    .background(Color(red: 248/255, green: 236/255, blue: 199/255))
                                    .foregroundColor(Color(red: 0/255, green: 49/255, blue: 83/255))
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
                                    .background(Color(red: 248/255, green: 236/255, blue: 199/255))
                                    .foregroundColor(Color(red: 0/255, green: 49/255, blue: 83/255))
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
                                .background(Color(red: 0/255, green: 49/255, blue: 83/255))
                                .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                                .cornerRadius(12)
                                .shadow(color: Color.black.opacity(0.3), radius: 8, x: 4, y: 4)
                                .shadow(color: Color.white.opacity(0.3), radius: 5, x: -2, y: -2)
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

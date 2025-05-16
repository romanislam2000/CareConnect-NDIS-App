import SwiftUI

struct EditTaskLogView: View {
    @Environment(\.dismiss) var dismiss
    @State var log: TaskLog
    var onSave: (TaskLog) -> Void
    @State private var taskString: String = ""

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.indigo.opacity(0.7), Color.blue.opacity(0.4)]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    GroupBox(label: Label("Client Name", systemImage: "person")) {
                        TextField("Client Name", text: $log.clientName)
                            .textFieldStyle(.roundedBorder)
                    }
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)

                    GroupBox(label: Label("Date", systemImage: "calendar")) {
                        DatePicker("", selection: $log.date, displayedComponents: .date)
                            .labelsHidden()
                    }
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)

                    GroupBox(label: Label("Tasks Completed", systemImage: "checkmark.circle")) {
                        TextField("Tasks (comma-separated)", text: $taskString)
                            .textFieldStyle(.roundedBorder)
                    }
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)

                    GroupBox(label: Label("Notes", systemImage: "note.text")) {
                        TextEditor(text: $log.notes)
                            .frame(height: 100)
                            .cornerRadius(8)
                    }
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)

                    Spacer()

                    HStack(spacing: 20) {
                        Button("Cancel") {
                            dismiss()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white.opacity(0.15))
                        .foregroundColor(.white)
                        .cornerRadius(10)

                        Button("Save") {
                            log.tasksCompleted = taskString.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) }
                            onSave(log)
                            dismiss()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white.opacity(0.15))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }
                .padding()
                .onAppear {
                    taskString = log.tasksCompleted.joined(separator: ", ")
                }
                .navigationTitle("Edit Task Log")
            }
        }
    }
}

//
//  AddTaskLogView.swift
//  CareConnect NDIS
//
//  Created by Md Roman Islam on 14/5/2025.
//

import SwiftUI

struct AddTaskLogView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: TaskLogViewModel

    @State private var clientName = ""
    @State private var selectedTasks: [String] = []
    @State private var notes = ""
    @State private var date = Date()

    let taskOptions = ["Medication Given", "Meal Provided", "Hygiene Support", "Recreational Activity", "Mobility Assistance"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Client & Date")) {
                    TextField("Client Name", text: $clientName)
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                }

                Section(header: Text("Completed Tasks")) {
                    ForEach(taskOptions, id: \.self) { task in
                        MultipleCheckbox(title: task, isSelected: selectedTasks.contains(task)) {
                            if selectedTasks.contains(task) {
                                selectedTasks.removeAll { $0 == task }
                            } else {
                                selectedTasks.append(task)
                            }
                        }
                    }
                }

                Section(header: Text("Notes")) {
                    TextField("Optional notes...", text: $notes)
                }
            }
            .navigationTitle("New Task Log")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let log = TaskLog(
                            clientName: clientName,
                            date: date,
                            tasksCompleted: selectedTasks,
                            notes: notes
                        )
                        viewModel.addLog(log)
                        dismiss()
                    }
                    .disabled(clientName.isEmpty || selectedTasks.isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
        }
    }
}

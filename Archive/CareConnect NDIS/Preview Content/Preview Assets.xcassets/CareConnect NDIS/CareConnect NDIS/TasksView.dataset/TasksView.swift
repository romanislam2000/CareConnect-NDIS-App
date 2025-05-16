//
//  TasksView.swift
//  CareConnect NDIS
//
//  Created by Md Roman Islam on 14/5/2025.
//

import SwiftUI

struct TasksView: View {
    @StateObject private var logVM = TaskLogViewModel()
    @State private var showNewLog = false

    var body: some View {
        NavigationView {
            List {
                ForEach(logVM.taskLogs) { log in
                    VStack(alignment: .leading) {
                        Text(log.clientName)
                            .font(.headline)
                        Text("🗓️ \(formattedDate(log.date))")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("✅ Tasks: \(log.tasksCompleted.joined(separator: ", "))")
                            .font(.footnote)
                        if !log.notes.isEmpty {
                            Text("📝 Notes: \(log.notes)")
                                .font(.caption)
                                .foregroundColor(.blue)
                        }
                    }
                    .padding()
                    .background(Color(.systemGroupedBackground))
                    .cornerRadius(10)
                }
            }
            .navigationTitle("Daily Logs")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showNewLog = true
                    } label: {
                        Image(systemName: "square.and.pencil")
                    }
                }
            }
            .onAppear {
                logVM.fetchLogs()
            }
            .sheet(isPresented: $showNewLog) {
                AddTaskLogView(viewModel: logVM)
            }
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

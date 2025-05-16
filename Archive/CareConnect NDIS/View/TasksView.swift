import SwiftUI

struct TasksView: View {
    @StateObject private var viewModel = TaskLogViewModel()
    @State private var showNewTaskForm = false
    @State private var showEditTaskForm = false
    @State private var selectedLog: TaskLog?
    @State private var searchText = ""

    var filteredLogs: [TaskLog] {
        if searchText.isEmpty {
            return viewModel.taskLogs
        } else {
            return viewModel.taskLogs.filter {
                $0.clientName.lowercased().contains(searchText.lowercased())
            }
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(red: 0.7, green: 0.74, blue: 1.0), Color(red: 0.85, green: 0.9, blue: 1.0)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()

                VStack {
                    if viewModel.taskLogs.isEmpty {
                        Spacer()
                        ProgressView("Loading Task Logs...")
                        Spacer()
                    } else {
                        List {
                            ForEach(filteredLogs) { log in
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        Text(log.clientName)
                                            .font(.headline)
                                            .foregroundColor(.black)
                                        Spacer()
                                        Text(formattedDate(log.date))
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }

                                    if !log.tasksCompleted.isEmpty {
                                        Text("Tasks: \(log.tasksCompleted.joined(separator: ", "))")
                                            .font(.subheadline)
                                            .padding(.top, 2)
                                    }

                                    if !log.notes.isEmpty {
                                        Text("📝 \(log.notes)")
                                            .font(.footnote)
                                            .foregroundColor(.black.opacity(0.8))
                                    }
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(14)
                                .shadow(color: Color.black.opacity(0.07), radius: 4, x: 0, y: 2)
                                .onTapGesture {
                                    selectedLog = log
                                    showEditTaskForm = true
                                }
                            }
                        }
                        .listStyle(PlainListStyle())
                        .searchable(text: $searchText)
                    }
                }
                .padding(.top, 5)
                .navigationTitle("📋 Task Logs")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showNewTaskForm = true
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                                .foregroundColor(.purple)
                        }
                    }
                }
                .sheet(isPresented: $showNewTaskForm) {
                    AddTaskLogView(viewModel: viewModel)
                }
                .sheet(isPresented: $showEditTaskForm) {
                    if let log = selectedLog {
                        EditTaskLogView(log: log) { updatedLog in
                            viewModel.updateLog(updatedLog)
                        }
                    }
                }
                .onAppear {
                    viewModel.fetchLogs()
                }
            }
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

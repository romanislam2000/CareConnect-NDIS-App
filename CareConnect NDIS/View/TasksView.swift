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
                Color(red: 31/255, green: 48/255, blue: 94/255)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 12) {
                        Text("📋 Task Logs")
                            .font(.largeTitle.bold())
                            .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.top, .horizontal])

                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                            TextField("Search", text: $searchText)
                                .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                                .placeholder(when: searchText.isEmpty) {
                                    Text("Search")
                                        .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255).opacity(0.6))
                                }
                        }
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(12)
                        .padding(.horizontal)

                        if viewModel.taskLogs.isEmpty {
                            ProgressView("Loading Task Logs...")
                                .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                                .padding(.top, 50)
                        } else {
                            ForEach(filteredLogs) { log in
                                VStack(alignment: .leading, spacing: 6) {
                                    HStack {
                                        Text(log.clientName)
                                            .font(.headline)
                                            .bold()
                                            .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                                        Spacer()
                                        Text(formattedDate(log.date))
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }

                                    if !log.tasksCompleted.isEmpty {
                                        let isPending = log.tasksCompleted.joined(separator: ", ").lowercased().contains("pending")
                                        Text("\(isPending ? "🟩" : "✅") Tasks: \(log.tasksCompleted.joined(separator: ", "))")
                                            .font(.subheadline)
                                            .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                                    }

                                    if !log.notes.isEmpty {
                                        Text("📝 \(log.notes)")
                                            .font(.footnote)
                                            .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                                    }
                                }
                                .padding()
                                .background(Color(red: 31/255, green: 48/255, blue: 94/255))
                                .cornerRadius(14)
                                .shadow(color: Color.black.opacity(0.3), radius: 15, x: 10, y: 10)
                                .shadow(color: Color.white.opacity(0.4), radius: 8, x: -5, y: -5)
                                .padding(.horizontal)
                                .onTapGesture {
                                    selectedLog = log
                                    showEditTaskForm = true
                                }
                            }
                        }
                    }
                    .padding(.bottom, 16)
                }

                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showNewTaskForm = true
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
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
                            viewModel.fetchLogs()
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

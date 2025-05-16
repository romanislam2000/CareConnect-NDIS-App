import SwiftUI
import FirebaseAuth

struct TasksView: View {
    @StateObject private var viewModel = TaskLogViewModel()
    @State private var showNewTaskForm = false
    @State private var showEditTaskForm = false
    @State private var selectedLog: TaskLog? = nil
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

    var isAdmin: Bool {
        let adminEmails = ["admin@careconnect.com", "admin1@careconnect.com","md.roman.islam3417@gmail.com"]
        return adminEmails.contains(Auth.auth().currentUser?.email ?? "")
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 31/255, green: 48/255, blue: 94/255).ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 12) {
                        headerView()
                        searchBarView()
                        taskListView()
                    }
                    .padding(.bottom, 16)
                }

                // Admin-only Add Task Button
                .toolbar {
                    if isAdmin {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                showNewTaskForm = true
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                            }
                        }
                    }
                }

                .sheet(isPresented: $showNewTaskForm) {
                    AddTaskLogView(viewModel: viewModel)
                }

                // Edit Sheet with ID fix
                .sheet(isPresented: $showEditTaskForm, onDismiss: {
                    selectedLog = nil
                }) {
                    if let log = selectedLog {
                        EditTaskLogView(log: log) { updatedLog in
                            viewModel.updateLog(updatedLog)
                            viewModel.fetchLogs()
                            showEditTaskForm = false
                            selectedLog = nil
                        }
                    }
                }
                .id(selectedLog?.id)

                .onAppear {
                    viewModel.fetchLogs()
                }
            }
        }
    }

    // MARK: - Header View
    @ViewBuilder
    private func headerView() -> some View {
        Text("📋 Task Logs")
            .font(.largeTitle.bold())
            .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding([.top, .horizontal])
    }

    // MARK: - Search Bar
    @ViewBuilder
    private func searchBarView() -> some View {
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
    }

    // MARK: - Task List
    @ViewBuilder
    private func taskListView() -> some View {
        if viewModel.taskLogs.isEmpty {
            ProgressView("Loading Task Logs...")
                .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                .padding(.top, 50)
        } else {
            ForEach(filteredLogs) { log in
                VStack(alignment: .leading, spacing: 8) {
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

                    ForEach(log.tasksCompleted.indices, id: \.self) { index in
                        HStack {
                            Text("Task \(index + 1)")
                                .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                            Spacer()

                            if isAdmin {
                                Text(log.tasksCompleted[index].lowercased() == "completed" ? "✅ Completed" : "🟩 Pending")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .padding(6)
                                    .background(log.tasksCompleted[index].lowercased() == "completed" ? Color.green : Color.orange)
                                    .cornerRadius(8)
                            } else {
                                Button(action: {
                                    var updatedLog = log
                                    let current = updatedLog.tasksCompleted[index].lowercased()
                                    updatedLog.tasksCompleted[index] = current == "completed" ? "pending" : "completed"
                                    viewModel.updateLog(updatedLog)
                                }) {
                                    Text(log.tasksCompleted[index].lowercased() == "completed" ? "✅ Completed" : "🟩 Pending")
                                        .font(.caption)
                                        .foregroundColor(.white)
                                        .padding(6)
                                        .background(log.tasksCompleted[index].lowercased() == "completed" ? Color.green : Color.orange)
                                        .cornerRadius(8)
                                }
                            }
                        }
                    }

                    if !log.notes.isEmpty {
                        Text("📝 \(log.notes)")
                            .font(.footnote)
                            .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                            .padding(.top, 4)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(red: 31/255, green: 48/255, blue: 94/255))
                .cornerRadius(14)
                .shadow(color: Color.black.opacity(0.3), radius: 15, x: 10, y: 10)
                .shadow(color: Color.white.opacity(0.4), radius: 8, x: -5, y: -5)
                .padding(.horizontal)
                .contentShape(Rectangle())
                .onTapGesture {
                    if isAdmin {
                        selectedLog = log
                        showEditTaskForm = true
                    }
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

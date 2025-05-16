import SwiftUI
import FirebaseFirestore
struct AddShiftView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var clientViewModel: ClientViewModel
    var onSave: ([String: Any]) -> Void
    @State private var selectedClient: Client? = nil
    @State private var supportWorkerName = ""
    @State private var date = Date()
    @State private var startTime = Date()
    @State private var endTime = Date()
    @State private var notes = ""
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.indigo.opacity(0.6), Color.blue.opacity(0.4)]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                .ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 20) {
                        Text("New Shift")
                            .font(.largeTitle.bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                        // Client dropdown
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
                                    .background(Color.white)
                                    .cornerRadius(8)
                            }
                        }
                        GroupBox(label: Text("Support Worker").font(.caption)) {
                            TextField("Support Worker Name", text: $supportWorkerName)
                                .textFieldStyle(.roundedBorder)
                        }
                        GroupBox(label: Text("Date").font(.caption)) {
                            DatePicker("", selection: $date, displayedComponents: .date)
                                .labelsHidden()
                        }
                        HStack(spacing: 16) {
                            GroupBox(label: Text("Start Time").font(.caption)) {
                                DatePicker("", selection: $startTime, displayedComponents: .hourAndMinute)
                                    .labelsHidden()
                            }
                            GroupBox(label: Text("End Time").font(.caption)) {
                                DatePicker("", selection: $endTime, displayedComponents: .hourAndMinute)
                                    .labelsHidden()
                            }
                        }
                        GroupBox(label: Text("Notes").font(.caption)) {
                            TextField("Notes", text: $notes)
                                .textFieldStyle(.roundedBorder)
                        }
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
                                saveShift()
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white.opacity(0.15))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            clientViewModel.fetchClients()
        }
    }
    func saveShift() {
        guard let selectedClient = selectedClient else { return }
        let data: [String: Any] = [
            "clientName": selectedClient.name,
            "supportWorkerName": supportWorkerName,
            "date": Timestamp(date: date),
            "startTime": Timestamp(date: startTime),
            "endTime": Timestamp(date: endTime),
            "notes": notes,
            "isAttended": false
        ]
        onSave(data)
        dismiss()
    }
}

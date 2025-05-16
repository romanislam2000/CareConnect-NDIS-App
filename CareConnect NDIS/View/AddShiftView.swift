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
                Color(red: 0/255, green: 47/255, blue: 167/255)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 20) {
                        Text("📅 New Shift")
                            .font(.largeTitle.bold())
                            .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)

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
                        .padding()
                        .background(Color(red: 0/255, green: 47/255, blue: 167/255))
                        .cornerRadius(12)
                        .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                        .shadow(color: Color.black.opacity(0.3), radius: 8, x: 4, y: 4)
                        .shadow(color: Color.white.opacity(0.3), radius: 5, x: -2, y: -2)
                        .padding(.horizontal)

                        GroupBox(label: Text("Support Worker").font(.caption)) {
                            TextField("Support Worker Name", text: $supportWorkerName)
                                .textFieldStyle(.roundedBorder)
                        }
                        .padding()
                        .background(Color(red: 0/255, green: 47/255, blue: 167/255))
                        .cornerRadius(12)
                        .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                        .shadow(color: Color.black.opacity(0.3), radius: 8, x: 4, y: 4)
                        .shadow(color: Color.white.opacity(0.3), radius: 5, x: -2, y: -2)
                        .padding(.horizontal)

                        GroupBox(label: Text("Date").font(.caption)) {
                            DatePicker("", selection: $date, displayedComponents: .date)
                                .labelsHidden()
                        }
                        .padding()
                        .background(Color(red: 0/255, green: 47/255, blue: 167/255))
                        .cornerRadius(12)
                        .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                        .shadow(color: Color.black.opacity(0.3), radius: 8, x: 4, y: 4)
                        .shadow(color: Color.white.opacity(0.3), radius: 5, x: -2, y: -2)
                        .padding(.horizontal)

                        HStack(spacing: 16) {
                            GroupBox(label: Text("Start Time").font(.caption)) {
                                DatePicker("", selection: $startTime, displayedComponents: .hourAndMinute)
                                    .labelsHidden()
                            }
                            .padding()
                            .background(Color(red: 0/255, green: 47/255, blue: 167/255))
                            .cornerRadius(12)
                            .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                            .shadow(color: Color.black.opacity(0.3), radius: 8, x: 4, y: 4)
                            .shadow(color: Color.white.opacity(0.3), radius: 5, x: -2, y: -2)

                            GroupBox(label: Text("End Time").font(.caption)) {
                                DatePicker("", selection: $endTime, displayedComponents: .hourAndMinute)
                                    .labelsHidden()
                            }
                            .padding()
                            .background(Color(red: 0/255, green: 47/255, blue: 167/255))
                            .cornerRadius(12)
                            .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                            .shadow(color: Color.black.opacity(0.3), radius: 8, x: 4, y: 4)
                            .shadow(color: Color.white.opacity(0.3), radius: 5, x: -2, y: -2)
                        }
                        .padding(.horizontal)

                        GroupBox(label: Text("Notes").font(.caption)) {
                            TextField("Notes", text: $notes)
                                .textFieldStyle(.roundedBorder)
                        }
                        .padding()
                        .background(Color(red: 0/255, green: 47/255, blue: 167/255))
                        .cornerRadius(12)
                        .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                        .shadow(color: Color.black.opacity(0.3), radius: 8, x: 4, y: 4)
                        .shadow(color: Color.white.opacity(0.3), radius: 5, x: -2, y: -2)
                        .padding(.horizontal)

                        HStack(spacing: 20) {
                            Button("Cancel") {
                                dismiss()
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 0/255, green: 47/255, blue: 167/255))
                            .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.3), radius: 8, x: 4, y: 4)
                            .shadow(color: Color.white.opacity(0.3), radius: 5, x: -2, y: -2)

                            Button("Save") {
                                saveShift()
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 0/255, green: 47/255, blue: 167/255))
                            .foregroundColor(Color(red: 248/255, green: 236/255, blue: 199/255))
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.3), radius: 8, x: 4, y: 4)
                            .shadow(color: Color.white.opacity(0.3), radius: 5, x: -2, y: -2)
                        }
                        .padding(.horizontal)
                    }
                    .padding(.bottom)
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
